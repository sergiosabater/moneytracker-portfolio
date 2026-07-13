import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Manages the app's PIN code: whether one is set, and verifying a
/// candidate PIN against the stored one.
///
/// The PIN itself is never stored. Instead, we store a salted SHA-256
/// hash — the same principle used for password storage on any serious
/// backend. Even if the secure storage were somehow compromised, the
/// original PIN can't be recovered from what's saved.
class PinService {
  static const int pinLength = 4;

  static const _hashKey = 'pin_hash';
  static const _saltKey = 'pin_salt';

  final FlutterSecureStorage _storage;

  PinService({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  /// Whether a PIN is currently set for the app.
  Future<bool> isPinSet() async {
    final hash = await _storage.read(key: _hashKey);
    return hash != null;
  }

  /// Hashes and saves [pin] as the app's new PIN, replacing any existing
  /// one. A fresh random salt is generated on every call.
  Future<void> setPin(String pin) async {
    final salt = _generateSalt();
    final hash = _hash(pin, salt);

    await _storage.write(key: _saltKey, value: salt);
    await _storage.write(key: _hashKey, value: hash);
  }

  /// Returns true if [pin] matches the currently stored PIN.
  /// Returns false if no PIN is set at all.
  Future<bool> verifyPin(String pin) async {
    final storedHash = await _storage.read(key: _hashKey);
    final salt = await _storage.read(key: _saltKey);

    if (storedHash == null || salt == null) return false;

    return _hash(pin, salt) == storedHash;
  }

  /// Removes the stored PIN entirely (used when the user disables it).
  Future<void> clearPin() async {
    await _storage.delete(key: _hashKey);
    await _storage.delete(key: _saltKey);
  }

  String _generateSalt() {
    final random = Random.secure();
    final bytes = List<int>.generate(16, (_) => random.nextInt(256));
    return base64Url.encode(bytes);
  }

  String _hash(String pin, String salt) {
    final bytes = utf8.encode('$salt:$pin');
    return sha256.convert(bytes).toString();
  }
}