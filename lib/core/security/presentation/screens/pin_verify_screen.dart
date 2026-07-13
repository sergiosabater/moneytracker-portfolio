import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moneytracker/core/security/pin_provider.dart';
import 'package:moneytracker/core/security/presentation/screens/pin_entry_screen.dart';
import 'package:moneytracker/l10n/app_localizations.dart';

/// Single-step PIN verification. Reused both for disabling the PIN and
/// for [SecurityGate], gating any sensitive action behind the app's
/// existing PIN — same screen, same behavior, regardless of what
/// triggered it.
///
/// Pops `true` when the entered PIN is correct, `false` if the user
/// backs out.
class PinVerifyScreen extends ConsumerStatefulWidget {
  const PinVerifyScreen({super.key});

  @override
  ConsumerState<PinVerifyScreen> createState() => _PinVerifyScreenState();
}

class _PinVerifyScreenState extends ConsumerState<PinVerifyScreen> {
  String? _errorMessage;
  int _errorTrigger = 0;
  bool _isVerifying = false;

  Future<void> _handleCompleted(String pin) async {
    if (_isVerifying) return;
    setState(() => _isVerifying = true);

    final isValid = await ref.read(pinServiceProvider).verifyPin(pin);

    if (!mounted) return;

    if (isValid) {
      Navigator.of(context).pop(true);
      return;
    }

    final l10n = AppLocalizations.of(context)!;
    setState(() {
      _isVerifying = false;
      _errorMessage = l10n.pinIncorrect;
      _errorTrigger++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return PinEntryScreen(
      title: l10n.pinVerifyTitle,
      errorMessage: _errorMessage,
      errorTrigger: _errorTrigger,
      onCompleted: _handleCompleted,
      onBack: () => Navigator.of(context).pop(false),
    );
  }
}