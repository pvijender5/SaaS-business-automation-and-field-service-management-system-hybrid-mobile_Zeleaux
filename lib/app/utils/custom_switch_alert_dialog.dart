import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zeleaux_app/controllers/clock_time_controller.dart';
import 'package:zeleaux_app/screens/logyourday/time_clock_model.dart';
import 'package:zeleaux_app/utils/apputils.dart';

import 'custom_add_notes_alert_dialog.dart';

class CustomSwitchAlertDialog extends StatelessWidget {
  ClockTimeController controller;

  CustomSwitchAlertDialog({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    var sidePadding = Get.width * 0.05;
    var topPadding = Get.height * 0.05;
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      physics: const AlwaysScrollableScrollPhysics(),
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        padding: EdgeInsets.fromLTRB(sidePadding, topPadding, sidePadding, 0),
        width: MediaQuery.of(context).size.width,
        child: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 10,
              ),
              (controller.selectedSwitchProjectType.value.toLowerCase() ==
                          "projectname" ||
                      controller.selectedSwitchProjectType.value
                              .toLowerCase() ==
                          "")
                  ? Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: DropdownButton<TimeClockProjectData?>(
                        isExpanded: true,
                        value: controller.selectedSwitchProject.value,
                        icon: const Icon(Icons.arrow_drop_down_sharp),
                        elevation: 16,
                        style: const TextStyle(color: Colors.deepPurple),
                        onChanged: (TimeClockProjectData? value) {
                          // This is called when the user selects an item.
                          controller.selectedSwitchProject.value = value;
                          if (value?.name?.toLowerCase() == "select project" ||
                              value?.name?.toLowerCase() == "") {
                            controller.selectedSwitchProjectType.value = "";
                          } else {
                            controller.selectedSwitchProjectType.value =
                                "projectname";
                          }
                          controller.selectedSwitchProjectType.refresh();
                        },
                        items: controller.timeClockModel?.value.data
                            ?.map<DropdownMenuItem<TimeClockProjectData?>>(
                                (TimeClockProjectData? value) {
                          return DropdownMenuItem<TimeClockProjectData?>(
                            value: value,
                            child: Text(value?.name ?? "",
                                style: TextStyle(color: Colors.black)),
                          );
                        }).toList(),
                      ),
                    )
                  : Container(),
              (controller.selectedSwitchProjectType.value.toLowerCase() ==
                          "projectname" ||
                      controller.selectedSwitchProjectType.value
                              .toLowerCase() ==
                          "")
                  ? const SizedBox(
                      height: 10,
                    )
                  : const SizedBox(
                      height: 0,
                    ),
              (controller.selectedSwitchProjectType.value.toLowerCase() ==
                          "operationcode" ||
                      controller.selectedSwitchProjectType.value
                              .toLowerCase() ==
                          "")
                  ? Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: DropdownButton<TimeClockProjectData?>(
                        isExpanded: true,
                        value: controller.selectedSwitchOpProject.value,
                        icon: const Icon(Icons.arrow_drop_down_sharp),
                        elevation: 16,
                        style: const TextStyle(color: Colors.deepPurple),
                        onChanged: (TimeClockProjectData? value) {
                          // This is called when the user selects an item.
                          controller.selectedSwitchOpProject.value = value;
                          if (value?.name?.toLowerCase() ==
                                  "select operational code" ||
                              value?.name?.toLowerCase() == "") {
                            controller.selectedSwitchProjectType.value = "";
                          } else {
                            controller.selectedSwitchProjectType.value =
                                "operationcode";
                          }
                          controller.selectedSwitchProjectType.refresh();
                          controller.update();
                        },
                        items: controller.timeClockModel?.value.dataOp
                            ?.map<DropdownMenuItem<TimeClockProjectData?>>(
                                (TimeClockProjectData? value) {
                          return DropdownMenuItem<TimeClockProjectData?>(
                            value: value,
                            child: Text(
                              value?.name ?? "",
                              style: TextStyle(color: Colors.black),
                            ),
                          );
                        }).toList(),
                      ),
                    )
                  : Container(),
              (controller.selectedSwitchProjectType.value.toLowerCase() ==
                          "operationcode" ||
                      controller.selectedSwitchProjectType.value
                              .toLowerCase() ==
                          "")
                  ? SizedBox(
                      height: 10,
                    )
                  : SizedBox(
                      height: 0,
                    ),
              // (controller.selectedSwitchProjectType
              //     .value ==
              //     "projectname")?Container(
              //   padding: EdgeInsets.only(left: 10),
              //   child: Text('Please Schedule at: ${controller.getScheduledFormatedTime(controller.selectedSwitchProject.value?.schedule_start_time??"")}',
              //       style: TextStyle(
              //           fontWeight: FontWeight.w700,
              //           fontSize: 16)),
              // ):Container(),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      print('Submit Button tapped');

                      Navigator.of(context).pop();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.redAccent),
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: 50,
                      alignment: Alignment.center,
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      print('Submit Button tapped');
                      if (controller.selectedSwitchProjectType.value ==
                          "projectname") {
                        var projectArr =
                        (controller.selectedSwitchProject.value?.id ??
                            "")
                            .split("---");
                        String scheduleId = "";
                        if (projectArr.length > 2) {
                          scheduleId = projectArr[1];
                        }
                        if (scheduleId == "" || scheduleId == "0") {
                          Get.back();
                          addClockInNote(context);
                        }else if (AppUtils.isValidToStartProjectFromDateTime(
                              scheduleTime:
                              "${controller.selectedSwitchProject.value?.date} ${controller.selectedSwitchProject.value?.schedule_start_time}",
                              currentFormat: "dd/MM/yyyy HH:mm"))
                        {
                          Get.defaultDialog(
                              middleText:
                                  'You are going to clock in to this project',
                              confirm: MaterialButton(
                                  child: Text("OK"),
                                  onPressed: () async {
                                    Get.back();
                                    await controller.manageClickedTime(
                                        eventType: "1", isSwitch: "1");
                                    Get.back();
                                  }),
                              cancel: MaterialButton(
                                child: Text("Cancel"),
                                onPressed: Get.back,
                              ));
                        } else {
                          Get.defaultDialog(
                            middleText:
                                'You can not clock-in before ${controller.selectedSwitchProject.value?.scheduleDate} ${AppUtils.getFormatedDateTime(scheduleTime: (controller.selectedSwitchProject.value?.schedule_start_time ?? ""), currentFormat: "HH:mm", newFormat: "hh:mm a")}',
                            confirm: MaterialButton(
                                child: const Text("OK"),
                                onPressed: () {
                                  Get.back();
                                }),
                          );
                        }
                      } else {
                        var projectOpArr =
                        (controller.selectedSwitchOpProject.value?.id ??
                            "")
                            .split("---");
                        String scheduleId = "";
                        if (projectOpArr.length > 2) {
                          scheduleId = projectOpArr[1];
                        }
                        if (scheduleId == "" || scheduleId == "0") {
                          Get.back();
                          addClockInNote(context);
                        }else{
                          Get.defaultDialog(
                              middleText:
                              'You are going to clock in to this project',
                              confirm: MaterialButton(
                                  child: Text("OK"),
                                  onPressed: () async {
                                    Get.back();
                                    Get.back();

                                    await controller.manageClickedTime(
                                        eventType: "1", isSwitch: "1");
                                  }),
                              cancel: MaterialButton(
                                child: Text("Cancel"),
                                onPressed: Get.back,
                              ));
                        }

                      }

                      // print('Submit Button tapped');
                      // if(controller.selectedSwitchProjectType.value!=""){
                      //   Navigator.of(context).pop();
                      // }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.green),
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: 50,
                      alignment: Alignment.center,
                      child: Text(
                        'Switch ',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  addClockInNote(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAddNotesAlertDialog(
          noteTitle: "You are clocking in to an unscheduled shift.",
          noteEnterHint: "Please note your reason",
          onSave: (String note) {
            // Handle the saved note here
             controller.manageClickedTime(
                eventType: "1", isSwitch: "1",notes: note);
            // controller.manageClickedTime(eventType: "1", notes: note);
          },
        );
      },
    );
  }
}
