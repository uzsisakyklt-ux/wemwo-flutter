// FILE: lib/stores/profile_store.dart

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/candidate_model.dart';

/// Simple in-memory singleton store with optional persistence using
/// SharedPreferences. Implements ChangeNotifier so it can be used with Provider
/// later if desired.
class ProfileStore extends ChangeNotifier {
  ProfileStore._privateConstructor();
  static final ProfileStore instance = ProfileStore._privateConstructor();

  static const _kCandidateKey = 'wemwo_candidate_v1';

  CandidateModel? _candidate;
  CandidateModel? get candidate => _candidate;

  /// Load candidate from memory (if set) or from local storage (SharedPreferences)
  Future<CandidateModel?> load() async {
    if (_candidate != null) return _candidate;

    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_kCandidateKey);
      if (raw != null && raw.isNotEmpty) {
        _candidate = CandidateModel.decode(raw);
        return _candidate;
      }
    } catch (e) {
      if (kDebugMode) print('ProfileStore.load error: $e');
    }

    return null;
  }

  /// Save to memory and persist to SharedPreferences
  Future<void> save(CandidateModel model) async {
    _candidate = model;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_kCandidateKey, model.encode());
    } catch (e) {
      if (kDebugMode) print('ProfileStore.save error: $e');
    }
  }

  /// Clear saved candidate (memory + local)
  Future<void> clear() async {
    _candidate = null;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_kCandidateKey);
    } catch (e) {
      if (kDebugMode) print('ProfileStore.clear error: $e');
    }
  }
}
