// lib/app/modules/employees_list/employee_list_binding.dart
//
// This file defines the binding for the EmployeeList module.
// It is responsible for injecting the EmployeeListController dependency
// using GetX's dependency management system.

import 'package:get/get.dart';
import 'employee_list_controller.dart';

/// EmployeeListBinding sets up the dependencies for the EmployeeList module.
class EmployeeListBinding extends Bindings {
  @override
  void dependencies() {
    // Lazily inject EmployeeListController when it is first used.
    Get.lazyPut(() => EmployeeListController());
  }
}