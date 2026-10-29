// lib/app/modules/dashboard/landing_page_controller.dart
//
// This file defines the LandingPageController, which manages the state and navigation
// logic for the main dashboard's bottom navigation bar in the app. It uses GetX for
// state management and navigation, and binds the appropriate controllers and views
// for each tab.

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:zeleaux_app/app/modules/employees_list/employee_list_binding.dart';
import 'package:zeleaux_app/binding/overview_binding.dart';
import 'package:zeleaux_app/binding/time_sheet_binding.dart';
import 'package:zeleaux_app/app/modules/employees_list/employee_list_controller.dart';
import 'package:zeleaux_app/controllers/overview_controller.dart';
import 'package:zeleaux_app/controllers/schedule_controller.dart';
import 'package:zeleaux_app/controllers/time_sheet_controller.dart';
import 'package:zeleaux_app/screens/schedules/schedule_screen.dart';
import 'package:zeleaux_app/screens/timesheet/time_sheet.dart';

import 'subview/overview_screen.dart';
import '../employees_list/employees_screen.dart';
import '../../../binding/schedule_binding.dart';

/// LandingPageController manages the navigation and state for the dashboard's
/// bottom navigation bar. It handles tab changes, initializes controllers,
/// and generates routes for each tab.
class LandingPageController extends GetxController {
  /// Singleton instance getter for LandingPageController.
  static LandingPageController get instance {
    try {
      // Try to find an existing instance.
      return Get.find<LandingPageController>();
    } catch (e) {
      // If not found, create a new instance.
      return Get.put(LandingPageController());
    }
  }

  /// Observable index for the currently selected bottom navigation tab.
  var currentIndex = 0.obs;

  /// List of route names for each bottom navigation tab.
  final bottomPages = <String>[
    '/overview',
    '/schedule',
    '/employees',
    '/time_sheet'
  ];

  /// Returns the route name for the given tab index.
  String currentRoute(int index) {
    return bottomPages[index];
  }

  /// Changes the current tab, navigates to the corresponding route,
  /// and initializes the relevant controller for the selected tab.
  void changePage(int index) {
    currentIndex.value = index;
    Get.toNamed(bottomPages[index], id: 1);

    // Initialize the controller for the selected tab.
    if (currentIndex.value == 0) {
      OverviewController.instance.onInitController();
    } else if (currentIndex.value == 1) {
      ScheduleController.instance.onInitController();
    } else if (currentIndex.value == 2) {
      EmployeeListController.instance.onInitController();
    } else if (currentIndex.value == 3) {
      TimeSheetController.instance.onInitController();
    }
  }

  /// Generates the appropriate route for the nested navigator based on the route name.
  /// Binds the required controller for each tab.
  Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == '/overview') {
      return GetPageRoute(
        settings: settings,
        page: () => OverviewScreen(),
        binding: OverviewBinding(),
      );
    }

    if (settings.name == '/schedule') {
      return GetPageRoute(
        settings: settings,
        page: () => ScheduleScreen(),
        binding: ScheduleBinding(),
      );
    }

    if (settings.name == '/employees') {
      return GetPageRoute(
        settings: settings,
        page: () => const EmployeesScreen(),
        binding: EmployeeListBinding(),
      );
    }

    if (settings.name == '/time_sheet') {
      return GetPageRoute(
        settings: settings,
        page: () => TimeSheet(),
        binding: TimeSheetBinding(),
      );
    }

    // Return null if the route is not recognized.
    return null;
  }
}