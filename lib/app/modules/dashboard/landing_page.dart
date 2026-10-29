// lib/app/modules/dashboard/landing_page.dart
//
// This file defines the LandingPage widget, which serves as the main dashboard
// with a bottom navigation bar and a floating action button for navigation.
// It uses GetX for state management and navigation.

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zeleaux_app/controllers/overview_controller.dart';
import 'package:zeleaux_app/app/modules/dashboard/landing_page_controller.dart';
import 'package:zeleaux_app/controllers/login_controller.dart';
import 'package:zeleaux_app/utils/app_colors.dart';

import '../../routes/routes.dart';

/// LandingPage is the main dashboard screen with bottom navigation and FAB.
class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

/// State for LandingPage, manages navigation and animations.
class _LandingPageState extends State<LandingPage>
    with TickerProviderStateMixin {
  // Group for auto-sizing text widgets
  final autoSizeGroup = AutoSizeGroup();

  // Animation controllers and animations for FAB and bottom bar
  Animation<double>? borderRadiusAnimation;
  AnimationController? _hideBottomBarAnimationController;
  CurvedAnimation? borderRadiusCurve;
  AnimationController? _borderRadiusAnimationController;
  Animation<double>? fabAnimation;
  CurvedAnimation? fabCurve;
  AnimationController? _fabAnimationController;

  // Controller for managing landing page state and navigation
  var landingPageController = Get.put(LandingPageController());

  @override
  void initState() {
    super.initState();

    // Initialize animation controllers for border radius and FAB
    _borderRadiusAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    borderRadiusCurve = CurvedAnimation(
      parent: _borderRadiusAnimationController!,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );
    borderRadiusAnimation = Tween<double>(begin: 0, end: 1).animate(
      borderRadiusCurve!,
    );

    _hideBottomBarAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    fabCurve = CurvedAnimation(
      parent: _fabAnimationController!,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );

    // Start animations
    _borderRadiusAnimationController?.forward();
    _fabAnimationController?.forward();
  }

  // Images for selected and unselected bottom navigation icons
  final selected_image = <Image>[
    Image.asset('assets/images/home_select.png'),
    Image.asset('assets/images/calendar_select.png'),
    Image.asset('assets/images/employee_select.png'),
    Image.asset('assets/images/timesheet_select.png'),
  ];
  final unSelected_image = <Image>[
    Image.asset('assets/images/home_unselect.png'),
    Image.asset('assets/images/calendar_unselect.png'),
    Image.asset('assets/images/employee_unselect.png'),
    Image.asset('assets/images/timesheet_unselect.png'),
  ];

  // Tab names for bottom navigation
  final tabName = <String>[
    "Home",
    "Schedule",
    "Employees",
    "Time Sheet",
  ];

  // Index of the currently selected bottom navigation tab
  var _bottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Main content area uses a nested navigator for tab navigation
      body: Navigator(
        key: Get.nestedKey(1),
        initialRoute: '/overview',
        onGenerateRoute: landingPageController.onGenerateRoute,
      ),
      // Floating action button in the center
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 63, 82, 175),
        foregroundColor: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: const Image(
          image: AssetImage('assets/images/newcenter.png'),
          fit: BoxFit.cover,
        ),
        onPressed: () {
          // Handle FAB press: navigate to clock time and restart animations
          print('center button pressed');
          Get.toNamed(Routes.CLOCK_TIME);

          _fabAnimationController?.reset();
          _borderRadiusAnimationController?.reset();
          _borderRadiusAnimationController?.forward();
          _fabAnimationController?.forward();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // Animated bottom navigation bar
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: selected_image.length,
        tabBuilder: (int index, bool isActive) {
          final textColor = isActive ? Colors.black : Colors.transparent;
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isActive ? selected_image[index] : unSelected_image[index],
              Text(
                tabName[index],
                style: TextStyle(color: textColor, fontSize: 10),
              ),
            ],
          );
        },
        backgroundColor: Colors.white,
        activeIndex: _bottomNavIndex,
        notchAndCornersAnimation: borderRadiusAnimation,
        splashSpeedInMilliseconds: 300,
        notchSmoothness: NotchSmoothness.defaultEdge,
        gapLocation: GapLocation.center,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: (index) => setState(() {
          // Update selected tab and notify controller
          _bottomNavIndex = index;
          landingPageController.changePage(index);
        }),
        hideAnimationController: _hideBottomBarAnimationController,
        shadow: const BoxShadow(
          offset: Offset(0, 1),
          blurRadius: 12,
          spreadRadius: 0.5,
          color: Colors.black,
        ),
      ),
    );
  }
}