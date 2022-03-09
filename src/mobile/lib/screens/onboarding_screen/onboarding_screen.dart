import 'package:flutter/material.dart';
import 'package:hexabyte/widgets/onboarding_and_profile_form_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const OnboardingAndProfileFormScreen(
      appTitle: 'Welcome! Enter the details',
    );
  }
}
