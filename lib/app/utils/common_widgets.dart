import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zeleaux_app/controllers/overview_controller.dart';
import 'package:zeleaux_app/controllers/profile_controller.dart';

import '../app/routes/routes.dart';

Widget headerView({Widget? leftIcon, String? headerTitle, String? subtitle}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Wave Container
      leftIcon != null
          ? Container(
              height: Get.height * 0.1,
              width: Get.width * 0.10,
              alignment: Alignment.topCenter,
              child: leftIcon
              )
          : Container(),
      // Hi Text Container
      Flexible(
        flex: 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headerTitle != null
                ? Container(
                    alignment: Alignment.topLeft,
                    child: Text(headerTitle ?? "",
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            color: Colors.black87)),
                  )
                : Container(),
            subtitle != null
                ? Container(
                    alignment: Alignment.topLeft,
                    child: Text(subtitle ?? "",
                        style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 20,
                            color: Colors.black87)),
                  )
                : Container(),
          ],
        ),
      ),

      //Notification Container
      GestureDetector(
        onTap: () {
          Get.toNamed(Routes.NOTIFICATION);
          OverviewController.instance.onInitController();
        },
        child: ClipOval(
          child: Container(
            height: Get.width * 0.10,
            width: Get.width * 0.10,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/notification.png')),
                color: Colors.transparent),
            child: Container(
              height: 18,
              width: 18,
              padding: const EdgeInsets.all(2),
              alignment: Alignment.center,
              margin: const EdgeInsets.only(bottom: 15,left: 15),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
              constraints: const BoxConstraints(
                minWidth: 18,
                minHeight: 18,
              ),
              child: Text(
                "${(OverviewController.instance.dashboardModel.value.data?.notificationData?.length ?? 0) > 99 ? "99+" : OverviewController.instance.dashboardModel.value.data?.notificationData?.length ?? 0}",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
      const SizedBox(
        width: 10,
      ),
      // Profile Image Container
      GestureDetector(
          onTap: () async {
            Get.toNamed(Routes.PROFILE_SCREEN);
            ProfileController.instance.onInitController();
          },
          child: Container(
              height: Get.width * 0.10,
              width: Get.width * 0.10,
              padding: const EdgeInsets.all(2),
              margin: const EdgeInsets.only(bottom: 5),
              // backgroundColor: AppColors.shadowColor,
              child: ClipOval(
                child: Obx(
                  () => Container(
                    color: Colors.white,
                    child: Image.network(
                      ProfileController.instance.profilePic.value,
                      fit: BoxFit.cover,
                      height: Get.width * 0.10,
                      width: Get.width * 0.10,
                      errorBuilder: (context, error, stackTrace) {
                        return SizedBox(
                          height: Get.width * 0.10,
                          width: Get.width * 0.10,
                          child: const Icon(Icons
                              .person), // Optionally handle errors by showing an icon
                        );
                      },
                    ),
                  ),
                ),
              ))
          ),
    ],
  );
}
