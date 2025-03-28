import 'package:flutter/material.dart';
import '../model/ride/ride_pref.dart';
import '../repository/ride_preferences_repository.dart';
import 'async_value.dart';

/// This provider manages the ride preferences data:
/// - Holds the current ride preference
/// - Fetches and stores past ride preferences
class RidesPreferencesProvider extends ChangeNotifier {
  RidePreference? _currentPreference;
  late AsyncValue<List<RidePreference>> pastPreferences;

  final RidePreferencesRepository repository;

  /// Constructor: Fetch past preferences when the provider is initialized
  RidesPreferencesProvider({required this.repository}) {
    pastPreferences =  AsyncValue.loading();
    fetchPastPreferences();
  }

  /// Getter to retrieve the current ride preference
  RidePreference? get currentPreference => _currentPreference;

  /// Updates the current ride preference
  void setCurrentPreference(RidePreference pref) {
    if (_currentPreference == pref) return;

    _currentPreference = pref;
    _addPreference(pref);
    notifyListeners();
  }

  /// Adds a new ride preference to the repository and updates past preferences
  Future<void> _addPreference(RidePreference preference) async {
    await repository.addPreference(preference);
    fetchPastPreferences();
  }

  /// Fetches past ride preferences from the repository
  Future<void> fetchPastPreferences() async {
    pastPreferences =  AsyncValue.loading();
    notifyListeners();

    try {
      final pastPrefs = await repository.getPastPreferences();
      pastPreferences = AsyncValue.success(pastPrefs);
    } catch (error) {
      pastPreferences = AsyncValue.error(error);
    }
    notifyListeners();
  }

  /// Returns the list of past ride preferences, or an empty list if data isn't available
  List<RidePreference> get preferencesHistory => pastPreferences.data ?? [];
}
