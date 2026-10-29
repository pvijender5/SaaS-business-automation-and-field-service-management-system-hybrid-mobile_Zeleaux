// lib/app/modules/employees_list/employees_screen.dart
//
// This file defines the EmployeesScreen widget, which displays a list of employees
// with options to call or message each employee. Uses GetX for state management.

import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/common_widgets.dart';
import 'employee_list_controller.dart';
import '../../data/models/employee_list_model.dart';

/// EmployeesScreen displays a list of employees with call and message actions.
class EmployeesScreen extends GetView<EmployeeListController> {
  const EmployeesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Calculate padding based on screen size
    final sidePadding = MediaQuery.of(context).size.width * 0.02;
    final topPadding = MediaQuery.of(context).size.height * 0.06;

    return Scaffold(
      body: Obx(
        // Show loading indicator when data is loading
            () => BlurryModalProgressHUD(
          inAsyncCall: controller.isLoading.value,
          // ... other parameters ...
          child: Container(
            padding: EdgeInsets.fromLTRB(sidePadding, topPadding, sidePadding, 0),
            decoration: const BoxDecoration(
              color: Color.fromRGBO(236, 236, 236, 1.0),
            ),
            child: Column(
              children: [
                // Header section
                headerView(headerTitle: 'Employees'),
                // Employee list with pull-to-refresh
                Flexible(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      controller.getEmployeeList();
                    },
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // List of employee items
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: controller.employeeListModel.value.data?.length ?? 0,
                            itemBuilder: (context, index) {
                              return listTileItem(
                                (controller.employeeListModel.value.data ?? [])[index],
                                controller,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Builds a card widget for an employee with call and message actions.
/// 
/// [data] - The employee data.
/// [controller] - The controller for handling actions.
Widget listTileItem(EmployeeData data, EmployeeListController controller) {
  return Card(
    child: Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Employee avatar and info
          Row(
            children: [
              // Employee profile picture
              Container(
                height: Get.width * 0.10,
                width: Get.width * 0.10,
                margin: const EdgeInsets.only(bottom: 5),
                child: ClipOval(
                  child: Image.network(
                    data.pic ?? "",
                    fit: BoxFit.cover,
                    height: Get.width * 0.10,
                    width: Get.width * 0.10,
                    errorBuilder: (context, error, stackTrace) {
                      // Show default icon if image fails to load
                      return SizedBox(
                        height: Get.width * 0.10,
                        width: Get.width * 0.10,
                        child: const Icon(Icons.person),
                      );
                    },
                  ),
                ),
              ),
              // Employee name and title
              Container(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${data.firstName ?? ""} ${data.lastName ?? ""}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      data.title ?? "",
                      style: const TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Call and message buttons
          Row(
            children: [
              // Call button
              GestureDetector(
                onTap: () {
                  controller.makePhoneCall(data.phoneNumber ?? "");
                },
                child: Container(
                  height: Get.width * 0.10,
                  width: Get.width * 0.10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Get.height * 0.05),
                    color: Colors.transparent,
                  ),
                  child: Image.asset('assets/images/call.png'),
                ),
              ),
              // Message button
              GestureDetector(
                onTap: () {
                  controller.makePhoneMessage("Zeleaux", data.phoneNumber ?? "");
                },
                child: Container(
                  height: Get.width * 0.10,
                  width: Get.width * 0.10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Get.height * 0.05),
                    color: Colors.transparent,
                  ),
                  child: Image.asset('assets/images/chat.png'),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}