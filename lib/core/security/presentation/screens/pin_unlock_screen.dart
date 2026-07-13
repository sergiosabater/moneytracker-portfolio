import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moneytracker/core/security/app_lock_notifier.dart';
import 'package:moneytracker/core/security/pin_provider.dart';
import 'package:moneytracker/core/security/presentation/screens/pin_entry_screen.dart';
import 'package:moneytracker/l10n/app_localizations.dart';

/// Full-screen PIN prompt shown when the app starts locked (see
/// [AppLockNotifier]). Unlike [PinVerifyScreen], this isn't a route on
/// the navigation stack — it's swapped in via [MaterialApp.router]'s
/// `builder`, covering the whole app until the correct PIN is entered.
/// There's no way to dismiss it without success: no back button, no
/// barrier tap.
class PinUnlockScreen extends ConsumerStatefulWidget {
  const PinUnlockScreen({super.key});

  @override
  ConsumerState<PinUnlockScreen> createState() => _PinUnlockScreenState();
}

class _PinUnlockScreenState extends ConsumerState<PinUnlockScreen> {
  String? _errorMessage;
  int _errorTrigger = 0;
  bool _isVerifying = false;

  Future<void> _handleCompleted(String pin) async {
    if (_isVerifying) return;
    setState(() => _isVerifying = true);

    final isValid = await ref.read(pinServiceProvider).verifyPin(pin);

    if (!mounted) return;

    if (isValid) {
      ref.read(appLockNotifierProvider.notifier).unlock();
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
      title: l10n.appLockTitle,
      subtitle: l10n.appLockSubtitle,
      errorMessage: _errorMessage,
      errorTrigger: _errorTrigger,
      animateEntrance: true,
      onCompleted: _handleCompleted,
    );
  }
}