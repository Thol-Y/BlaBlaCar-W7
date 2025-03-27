import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/ride/ride_filter.dart';
import '../../../provider/rides_preferences_provider.dart';
import '../../../model/ride/ride.dart';
import '../../../model/ride/ride_pref.dart';
import '../../../service/rides_service.dart' as ridesService;
import '../../../utils/animations_util.dart';
import '../../theme/theme.dart';
import 'widgets/ride_pref_bar.dart';
import 'widgets/ride_pref_modal.dart';
import 'widgets/rides_tile.dart';
// import '../../utils/animation_utils.dart';
// import '../../widgets/ride_tile.dart';
// import '../../widgets/ride_pref_bar.dart';
// import '../../constants/spacings.dart';
// import '../ride_pref/ride_pref_modal.dart';

class RidesScreen extends StatefulWidget {
  const RidesScreen({super.key});

  @override
  State<RidesScreen> createState() => _RidesScreenState();
}

class _RidesScreenState extends State<RidesScreen> {
  RideFilter currentFilter = RideFilter();

  void onBackPressed(BuildContext context) {
    Navigator.of(context).pop();
  }

  List<Ride> getAvailableRides(RidePreference preference) {
    return ridesService.RidesService.instance.getRidesFor(preference, currentFilter);
  }

  Future<void> onPreferencePressed(BuildContext context) async {
    final provider = context.read<RidesPreferencesProvider>();
    final currentPreference = provider.currentPreference;

    final RidePreference? newPreference =
        await Navigator.of(context).push<RidePreference>(
      AnimationUtils.createTopToBottomRoute(
        RidePrefModal(initialPreference: currentPreference),
      ),
    );

    if (newPreference != null) {
      provider.setCurrentPreference(newPreference);
    }
  }

  void onFilterPressed() {
    // Implement filter logic here
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RidesPreferencesProvider>();
    final currentPreference = provider.currentPreference;
    final matchingRides = getAvailableRides(currentPreference!);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: BlaSpacings.m,
          right: BlaSpacings.m,
          top: BlaSpacings.s,
        ),
        child: Column(
          children: [
            RidePrefBar(
              ridePreference: currentPreference,
              onBackPressed: () => onBackPressed(context),
              onPreferencePressed: () => onPreferencePressed(context),
              onFilterPressed: onFilterPressed,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: matchingRides.length,
                itemBuilder: (ctx, index) => RideTile(
                  ride: matchingRides[index],
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
