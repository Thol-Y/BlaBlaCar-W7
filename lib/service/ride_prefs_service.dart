import 'package:flutter/foundation.dart';
import '../model/ride/ride_pref.dart';
import '../repository/ride_preferences_repository.dart';

class RidePrefsService {
  static final RidePrefsService instance = RidePrefsService._();
  RidePrefsService._();

  late final RidePreferencesRepository _repository;
  RidePreference? _currentPreference;

  void initialize(RidePreferencesRepository repository) {
    _repository = repository;
  }

  RidePreference? get currentPreference => _currentPreference;

  void setCurrentPreference(RidePreference? preference) {
    if (kDebugMode) {
      debugPrint('Setting current preference: $preference');
    }
    _currentPreference = preference;
  }

  Future<void> clearCurrentPreference() async {
    if (kDebugMode) {
      debugPrint('Clearing current preference');
    }
    _currentPreference = null;
  }

  Future<List<RidePreference>> getPastPreferences() async {
    return await _repository.getPastPreferences();
  }

  Future<void> addPreference(RidePreference preference) async {
    await _repository.addPreference(preference);
  }
}