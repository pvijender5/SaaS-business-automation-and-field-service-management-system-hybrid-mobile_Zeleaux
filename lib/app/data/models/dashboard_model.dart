
import 'dart:convert';

import 'allschedule_model.dart';

DashboardModel dashboardModelFromJson(String str) => DashboardModel.fromJson(json.decode(str));

String dashboardModelToJson(DashboardModel data) => json.encode(data.toJson());

class DashboardModel {
  int? status;
  InspectionData? data;
  String? message;

  DashboardModel({
     this.status,
     this.data,
     this.message,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
    status: json.containsKey("status")?json["status"]:null,
    data: json.containsKey("data")?(json["data"]!=null)?InspectionData.fromJson(json["data"]):null:null,
    message: json.containsKey("message")?json["message"]:null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data?.toJson(),
    "message": message,
  };
}

class InspectionData {
  String? pageTitle;
  String? dayTotalText;
  String? weekTotalText;
  String? payPeriodText;
  bool? isCurrentJob;
  String? currentJob;
  String? currentJobAddress;
  String? currentJobStatus;
  String? dayTotalValue;
  String? todayDate;
  String? currentJobTime;
  String? weekTotalValue;
  String? weekDate;
  String? payPeriodTotal;
  String? payPeriodDate;
  String? todayScheduleText;
  bool? weekSchedule;
  List<Schedule>? schedule;
  bool? isNotification;
  List<NotificationDatum>? notificationData;
  dynamic notificationCount;

  InspectionData({
     this.pageTitle,
     this.dayTotalText,
     this.weekTotalText,
     this.payPeriodText,
     this.isCurrentJob,
     this.currentJob,
     this.currentJobAddress,
     this.currentJobStatus,
     this.dayTotalValue,
     this.todayDate,
     this.currentJobTime,
     this.weekTotalValue,
     this.weekDate,
     this.payPeriodTotal,
     this.payPeriodDate,
     this.todayScheduleText,
     this.weekSchedule,
     this.schedule,
     this.isNotification,
     this.notificationData,
     this.notificationCount,
  });

  factory InspectionData.fromJson(Map<String, dynamic> json) => InspectionData(
    pageTitle: json.containsKey("page_title")?json["page_title"]:null,
    dayTotalText: json.containsKey("day_total_text")?json["day_total_text"]:null,
    weekTotalText: json.containsKey("week_total_text")?json["week_total_text"]:null,
    payPeriodText: json.containsKey("pay_period_text")?json["pay_period_text"]:null,
    isCurrentJob: json.containsKey("is_current_job")?json["is_current_job"]:null,
    currentJob: json.containsKey("current_job")?json["current_job"]:null,
    currentJobAddress: json.containsKey("current_job_address")?json["current_job_address"]:null,
    currentJobStatus: json.containsKey("current_job_status")?json["current_job_status"]:null,
    dayTotalValue: json.containsKey("day_total_value")?json["day_total_value"]:null,
    todayDate: json.containsKey("today_date")?json["today_date"]:null,
    currentJobTime: json.containsKey("current_job_time")?json["current_job_time"]:null,
    weekTotalValue: json.containsKey("week_total_value")?json["week_total_value"]:null,
    weekDate: json.containsKey("week_date")?json["week_date"]:null,
    payPeriodTotal: json.containsKey("pay_period_total")?json["pay_period_total"]:null,
    payPeriodDate: json.containsKey("pay_period_date")?json["pay_period_date"]:null,
    todayScheduleText: json.containsKey("today_schedule_text")?json["today_schedule_text"]:null,
    weekSchedule: json.containsKey("week_schedule")?json["week_schedule"]:null,
    schedule: json["schedule"]!=null?List<Schedule>.from(json["schedule"].map((x) => Schedule.fromJson(x))):null,
    isNotification: json.containsKey("is_notification")?json["is_notification"]:null,
    notificationData: List<NotificationDatum>.from(json["notification_data"].map((x) => NotificationDatum.fromJson(x))),
    notificationCount: json.containsKey("notification_count")?json["notification_count"]:null,
  );

  Map<String, dynamic> toJson() => {
    "page_title": pageTitle,
    "day_total_text": dayTotalText,
    "week_total_text": weekTotalText,
    "pay_period_text": payPeriodText,
    "is_current_job": isCurrentJob,
    "current_job": currentJob,
    "current_job_address": currentJobAddress,
    "current_job_status": currentJobStatus,
    "day_total_value": dayTotalValue,
    "today_date": todayDate,
    "current_job_time": currentJobTime,
    "week_total_value": weekTotalValue,
    "week_date": weekDate,
    "pay_period_total": payPeriodTotal,
    "pay_period_date": payPeriodDate,
    "today_schedule_text": todayScheduleText,
    "week_schedule": weekSchedule,
    "schedule": List<dynamic>.from((schedule??[]).map((x) => x.toJson())),
    "is_notification": isNotification,
    "notification_data": List<dynamic>.from((notificationData??[]).map((x) => x.toJson())),
    "notification_count": notificationCount,
  };
}

class NotificationDatum {
  String? projectName;
  String? type;
  String? notificationType;
  String? time;
  int? empCount;
  int? scheduleId;
  int? scheduleIdActual;
  String? scheduleDate;
  String? assetId;
  String? note;
  String? location;
  String? color;
  List<EmployeeList>? employeeList;
  String? employeeListString;
  int? projectId;
  int? id;
  int? workrequest_id;
  String? date;
  String? start_time;
  String? title;
  String? message;
  String? isClickable;
  bool? workOrderAccess;
  bool? projectPlanAccess;

  NotificationDatum({
    this.message,
    this.workrequest_id,
     this.projectName,
     this.type,
     this.notificationType,
     this.time,
     this.start_time,
     this.empCount,
     this.scheduleId,
     this.scheduleIdActual,
     this.scheduleDate,
     this.assetId,
     this.note,
     this.location,
     this.color,
     this.employeeList,
     this.employeeListString,
     this.projectId,
     this.id,
     this.date,
     this.title,
     this.isClickable,
     this.workOrderAccess,
     this.projectPlanAccess,
  });

  factory NotificationDatum.fromJson(Map<String, dynamic> json) => NotificationDatum(
    projectName: json.containsKey("project_name")?json["project_name"]:null,
    message: json.containsKey("message")?json["message"]:null,
      workrequest_id: json.containsKey("workrequest_id")?json["workrequest_id"]:null,
    type: json.containsKey("type")?json["type"]:null,
    notificationType: json.containsKey("notification_type")?json["notification_type"]:null,
    time: json.containsKey("time")?json["time"]:null,
    start_time: json.containsKey("start_time")?json["start_time"]:null,

    empCount: json.containsKey("emp_count")?json["emp_count"]:null,
    scheduleId: json.containsKey("schedule_id")?json["schedule_id"]:null,
    scheduleIdActual: json.containsKey("schedule_id_actual")?json["schedule_id_actual"]:null,
    scheduleDate: json.containsKey("schedule_date")?json["schedule_date"]:null,
    assetId: json.containsKey("asset_id")?json["asset_id"]:null,
    note: json.containsKey("note")?json["note"]:null,
    location: json.containsKey("location")?json["location"]:null,
    color: json.containsKey("color")?json["color"]:null,
    employeeList: json.containsKey("employeeList")?List<EmployeeList>.from(json["employeeList"].map((x) => EmployeeList.fromJson(x))):[],
    employeeListString: json.containsKey("employeeList_string")?json["employeeList_string"]:null,
    projectId: json.containsKey("project_id")?json["project_id"]:null,
    id: json.containsKey("id")?json["id"]:null,
    date: json.containsKey("date")?json["date"]:null,
    title: json.containsKey("title")?json["title"]:null,
    isClickable: json.containsKey("is_clickable")?json["is_clickable"]:null,
    workOrderAccess: json.containsKey("work_order_access")?json["work_order_access"]:null,
    projectPlanAccess: json.containsKey("project_plan_access")?json["project_plan_access"]:null,
  );

  Map<String, dynamic> toJson() => {
    "project_name": projectName,
    "workrequest_id":workrequest_id,
    "message":message,
    "type": type,
    "notification_type": notificationType,
    "time": time,
    "start_time":start_time,
    "emp_count": empCount,
    "schedule_id": scheduleId,
    "schedule_id_actual": scheduleIdActual,
    "schedule_date": scheduleDate,
    "asset_id": assetId,
    "note": note,
    "location": location,
    "color": color,
    "employeeList": List<dynamic>.from((employeeList??[]).map((x) => x.toJson())),
    "employeeList_string": employeeListString,
    "project_id": projectId,
    "id": id,
    "date": date,
    "title": title,
    "is_clickable": isClickable,
    "work_order_access": workOrderAccess,
    "project_plan_access": projectPlanAccess,
  };
}

class Schedule {
  String? projectName;
  String? type;
  String? message;
  String? time;
  String? date;
  String? start_time;
  int? empCount;
  int? scheduleId;
  int? scheduleIdActual;
  String? assetId;
  String? scheduleDate;
  String? note;
  String? location;
  List<EmployeeList>? employeeList;
  String? employeeListString;
  int? projectId;
  bool? workOrderAccess;
  bool? projectPlanAccess;

  Schedule({
    this.start_time,
     this.projectName,
     this.type,
     this.time,
     this.empCount,
     this.scheduleId,
     this.scheduleIdActual,
     this.assetId,
     this.scheduleDate,
     this.note,
     this.location,
     this.employeeList,
     this.employeeListString,
     this.projectId,
     this.workOrderAccess,
     this.projectPlanAccess,
    this.date
  });

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
    projectName: json.containsKey("project_name")?json["project_name"]:null,
    type: json.containsKey("type")?json["type"]:null,
    time: json.containsKey("time")?json["time"]:null,
    date: json.containsKey("date")?json["date"]:null,
    start_time: json.containsKey("start_time")?json["start_time"]:null,
    empCount: json.containsKey("emp_count")?json["emp_count"]:null,
    scheduleId: json.containsKey("schedule_id")?json["schedule_id"]:null,
    scheduleIdActual: json.containsKey("schedule_id_actual")?json["schedule_id_actual"]:null,
    assetId: json.containsKey("asset_id")?json["asset_id"]:null,
    scheduleDate: json.containsKey("schedule_date")?json["schedule_date"]:null,
    note: json.containsKey("note")?json["note"]:null,
    location: json.containsKey("location")?json["location"]:null,
    employeeList: json.containsKey("employeeList")?List<EmployeeList>.from(json["employeeList"].map((x) => EmployeeList.fromJson(x))):null,
    employeeListString: json.containsKey("employeeList_string")?json["employeeList_string"]:null,
    projectId: json.containsKey("project_id")?json["project_id"]:null,
    workOrderAccess: json.containsKey("work_order_access")?json["work_order_access"]:null,
    projectPlanAccess: json.containsKey("project_plan_access")?json["project_plan_access"]:null,
  );

  Map<String, dynamic> toJson() => {
    "project_name": projectName,
    "type": type,
    "time": time,
    "date": date,
    "start_time":start_time,
    "emp_count": empCount,
    "schedule_id": scheduleId,
    "schedule_id_actual": scheduleIdActual,
    "asset_id": assetId,
    "schedule_date": scheduleDate,
    "note": note,
    "location": location,
    "employeeList": List<dynamic>.from((employeeList??[]).map((x) => x.toJson())),
    "employeeList_string": employeeListString,
    "project_id": projectId,
    "work_order_access": workOrderAccess,
    "project_plan_access": projectPlanAccess,
  };
}
