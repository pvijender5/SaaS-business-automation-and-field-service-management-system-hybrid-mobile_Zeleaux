// lib/app/modules/dashboard/subview/overview_screen.dart
//
// This file defines the OverviewScreen widget, which displays the dashboard
// overview for the user. It shows today's status, current job info, and
// a list of upcoming schedules. It uses GetX for state management.

import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:zeleaux_app/controllers/overview_controller.dart';
import 'package:zeleaux_app/utils/common_widgets.dart';

import '../../../../screens/schedules/schedule_tile.dart';
import '../../../../utils/app_colors.dart';

/// OverviewScreen displays the dashboard overview, including today's status,
/// current job, and upcoming schedules.
class OverviewScreen extends GetView<OverviewController> {
  @override
  Widget build(BuildContext context) {
    // Calculate padding based on screen size
    var sidepadding = MediaQuery.of(context).size.width * 0.02;
    var topPadding = MediaQuery.of(context).size.height * 0.06;

    return Scaffold(
      body: Obx(
        // Show loading overlay when async call is in progress
            () => BlurryModalProgressHUD(
          inAsyncCall: controller.isLoading.value,
          blurEffectIntensity: 0,
          progressIndicator: const SpinKitFadingCircle(
            color: AppColors.inputFieldBorderColor,
            size: 90.0,
          ),
          dismissible: false,
          opacity: 0,
          color: AppColors.inputFieldBorderColor,
          child: RefreshIndicator(
            // Pull-to-refresh triggers dashboard data reload
            onRefresh: () async {
              controller.getDashboardData();
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(sidepadding, topPadding, sidepadding, 0),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(236, 236, 236, 1.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Top bar with greeting
                  headerView(
                    leftIcon: Image.asset('assets/images/wavehand.png'),
                    headerTitle: 'Hi ${controller.loggedInUserData.value.firstName}',
                    subtitle: '',
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          // Card showing today's status and current job info
                          Container(
                            width: Get.width,
                            padding: const EdgeInsets.only(bottom: 20, top: 10),
                            margin: const EdgeInsets.only(top: 0, bottom: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(Get.height * 0.02),
                              ),
                              gradient: const LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color(0xffEFBE38),
                                  Color(0xffECAB2E),
                                  Color(0xffEA922E),
                                  Color(0xffE98E24),
                                ],
                              ),
                            ),
                            child: Column(
                              children: [
                                // Display today's status and total time
                                Container(
                                  color: Colors.transparent,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        child: const Text(
                                          'Today\'s Status',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.topCenter,
                                        child: Text(
                                          controller.dashboardModel.value.data?.dayTotalValue ?? "",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 25,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Card showing current job status and time
                                Container(
                                  alignment: Alignment.bottomCenter,
                                  height: Get.height * 0.1,
                                  width: Get.width * 0.9,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(Get.height * 0.02),
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      // Status icon
                                      Container(
                                        height: Get.height * 0.1,
                                        width: Get.width * 0.10,
                                        alignment: Alignment.center,
                                        child: Image.asset(
                                          // Show checkin icon for all statuses (can be customized)
                                          'assets/images/checkin.png',
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      // Status text and time
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              controller.dashboardModel.value.data?.currentJobStatus ?? "",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.topCenter,
                                            child: RichText(
                                              text: TextSpan(
                                                style: const TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.black,
                                                ),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text: (
                                                        (controller.dashboardModel.value.data?.currentJobStatus ?? "").toLowerCase() == "clocked in" ||
                                                            (controller.dashboardModel.value.data?.currentJobStatus ?? "").toLowerCase() == "break"
                                                    )
                                                        ? (controller.dashboardModel.value.data?.currentJobTime ?? "")
                                                        : "",
                                                    style: const TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 25,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                // Show current job address if clocked in or on break
                                ((controller.dashboardModel.value.data?.isCurrentJob ?? false) &&
                                    (
                                        (controller.dashboardModel.value.data?.currentJobStatus ?? "").toLowerCase() == "clocked in" ||
                                            (controller.dashboardModel.value.data?.currentJobStatus ?? "").toLowerCase() == "break"
                                    )
                                )
                                    ? Container(
                                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                                  width: Get.width * 0.9,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(Get.height * 0.02),
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(left: 20),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          controller.dashboardModel.value.data?.currentJob ?? "",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            height: Get.height * 0.04,
                                            width: Get.width * 0.10,
                                            alignment: Alignment.center,
                                            child: Image.asset('assets/images/marker.png'),
                                          ),
                                          Expanded(
                                            child: Container(
                                              padding: const EdgeInsets.only(top: 10, bottom: 10),
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                controller.dashboardModel.value.data?.currentJobAddress ?? "",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                                    : Container(),
                              ],
                            ),
                          ),
                          // Section title for upcoming schedule
                          Container(
                            padding: const EdgeInsets.only(left: 5),
                            height: Get.height * 0.08,
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              'Your Upcoming Schedule',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          // List of upcoming schedules or a "No Data Found" message
                          ((controller.dashboardModel.value.data?.schedule?.length ?? 0) > 0)
                              ? ListView.builder(
                            padding: const EdgeInsets.all(0),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: (controller.dashboardModel.value.data?.schedule?.length ?? 0),
                            itemBuilder: (context, position) {
                              return ScheduleTile(
                                (controller.dashboardModel.value.data?.schedule ?? [])[position],
                                controller,
                              );
                            },
                          )
                              : SizedBox(
                            height: 100,
                            child: Center(
                              child: Text(
                                (controller.isLoading.value) ? "" : 'No Data Found',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}