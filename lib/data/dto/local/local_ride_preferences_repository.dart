import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../model/ride/ride_pref.dart';
import '../../../repository/ride_preferences_repository.dart';
import '../ride_preference_dto.dart';

class LocalRidePreferencesRepository implements RidePreferencesRepository {
  static const _preferencesKey = 'ride_preferences';

  @override
  Future<List<RidePreference>> getPastPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(_preferencesKey) ?? [];

    return jsonList
        .map((json) => RidePreferenceDto.fromJson(jsonDecode(json)))
        .map((dto) => dto.toModel())
        .toList();
  }

  @override
  Future<void> addPreference(RidePreference preference) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(_preferencesKey) ?? [];

    final dto = RidePreferenceDto.fromModel(preference);
    jsonList.add(jsonEncode(dto.toJson()));

    await prefs.setStringList(_preferencesKey, jsonList);
  }
}
