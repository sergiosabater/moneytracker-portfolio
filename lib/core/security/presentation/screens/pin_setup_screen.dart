import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moneytracker/core/security/pin_provider.dart';
import 'package:moneytracker/core/security/presentation/screens/pin_entry_screen.dart';
import 'package:moneytracker/l10n/app_localizations.dart';

enum _PinSetupStep { enter, confirm }

/// Two-step PIN creation flow: first entry, then confirmation.
/// On a mismatch, restarts from the beginning (per product decision —
/// simpler than trying to re-enter just the confirmation step).
class PinSetupScreen extends ConsumerStatefulWidget {
  const PinSetupScreen({super.key});

  @override
  ConsumerState<PinSetupScreen> createState() => _PinSetupScreenState();
}

class _PinSetupScreenState extends ConsumerState<PinSetupScreen> {
  _PinSetupStep _step = _PinSetupStep.enter;
  String? _firstPin;
  String? _errorMessage;
  int _errorTrigger = 0;
  bool _isSaving = false;

  Future<void> _handleCompleted(String pin) async {
    final l10n = AppLocalizations.of(context)!;

    if (_step == _PinSetupStep.enter) {
      setState(() {
        _firstPin = pin;
        _step = _PinSetupStep.confirm;
        _errorMessage = null;
      });
      return;
    }

    if (pin != _firstPin) {
      setState(() {
        _step = _PinSetupStep.enter;
        _firstPin = null;
        _errorMessage = l10n.pinMismatch;
        _errorTrigger++;
      });
      return;
    }

    setState(() => _isSaving = true);
    await ref.read(pinServiceProvider).setPin(pin);
    await ref.read(pinStatusNotifierProvider.notifier).refresh();

    if (!mounted) return;
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isConfirmStep = _step == _PinSetupStep.confirm;

    return PinEntryScreen(
      // Forces a fresh State (and cleared dots) whenever the step
      // changes, since it's a new logical screen even though it reuses
      // the same widget type. This also means the entrance animation
      // replays on every step transition, which reads as an intentional
      // "next screen" beat rather than a glitch.
      key: ValueKey(_step),
      title: isConfirmStep ? l10n.pinConfirmTitle : l10n.pinCreateTitle,
      subtitle:
          isConfirmStep ? l10n.pinConfirmSubtitle : l10n.pinCreateSubtitle,
      errorMessage: _errorMessage,
      errorTrigger: _errorTrigger,
      animateEntrance: true,
      onCompleted: _isSaving ? (_) {} : _handleCompleted,
      onBack: () => Navigator.of(context).pop(false),
    );
  }
}