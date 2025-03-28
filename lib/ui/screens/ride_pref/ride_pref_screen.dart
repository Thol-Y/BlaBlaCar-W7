import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/rides_preferences_provider.dart';

import '../../theme/theme.dart';

class RidePrefScreen extends StatelessWidget {
  const RidePrefScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RidesPreferencesProvider>();
    final pastPreferences = provider.preferencesHistory;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ride Preferences'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: BlaColors.primary,
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                'Past Preferences',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: BlaSpacings.m),
            Expanded(
              child: ListView.builder(
                itemCount: pastPreferences.length,
                itemBuilder: (context, index) {
                  final preference = pastPreferences[index];
                  return Card(
                    child: ListTile(
                      title: Text(preference.toString()),
                      onTap: () {
                        provider.setCurrentPreference(preference);
                        Navigator.pop(context);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
