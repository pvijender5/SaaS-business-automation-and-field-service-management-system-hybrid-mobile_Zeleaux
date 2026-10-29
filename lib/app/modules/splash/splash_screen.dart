// lib/app/modules/splash/splash_screen.dart
//
// This file defines the SplashScreen widget, which displays a splash animation
// and navigates the user to the appropriate screen based on their login state.
// It uses GetX for navigation and a shared preferences utility for session checks.

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/preferences.dart';
import '../../routes/routes.dart';

/// SplashScreen displays a splash animation and handles initial navigation.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

/// State for SplashScreen, manages timer and navigation logic.
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkLoginUserOut();
  }

  /// Checks if the user is logged in and navigates accordingly after a delay.
  void checkLoginUserOut() async {
    // Retrieve login state from shared preferences.
    var isUserNotLoggedOut = await SharedPreferencesUtils().getBoolPreferences(
      SharedPreferencesUtils.IS_USER_NOT_LOGGED_OUT,
    );

    // Wait for 3.5 seconds before navigating.
    Timer(const Duration(milliseconds: 3500), () {
      print('go to login');
      if ((isUserNotLoggedOut ?? false)) {
        // Navigate to landing page if user is logged in.
        Get.offAllNamed(Routes.LANDING_PAGE);
      } else {
        // Otherwise, navigate to login screen.
        Get.offAllNamed(Routes.LOGIN);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Full-screen splash image.
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Image.asset(
        'assets/images/Splash_6.gif',
        width: 15.0,
        height: 15.0,
        fit: BoxFit.fill,
      ),
    );
  }
}