// lib/app/data/services/api_services.dart
//
// This file defines the ApiServices class, which provides methods for
// communicating with the backend API. It handles user authentication,
// employee management, timesheet operations, schedule retrieval, and
// user settings using HTTP requests.
//
// All API methods return model objects parsed from the server response.

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zeleaux_app/app/data/models/employee_list_model.dart';
import 'package:zeleaux_app/app/data/models/forgot_password_model.dart';
import 'package:zeleaux_app/app/data/models/login_model.dart';
import 'package:zeleaux_app/app/data/models/logout_model.dart';
import 'package:zeleaux_app/app/data/models/myschedule_model.dart';

import '../../../controllers/login_controller.dart';
import '../../../screens/logyourday/time_clock_model.dart';
import '../../../screens/timesheet/time_sheet_model.dart';
import '../../../utils/api_constants.dart';
import '../models/base_reponse.dart';
import '../models/dashboard_model.dart';
import '../models/manage_clock_time_model.dart';
import '../models/reset_user_setting_model.dart';

/// ApiServices provides methods to interact with the backend API.
/// Each method sends an HTTP request and parses the response into a model.
class ApiServices {


  /// Retrieves the list of employees.
  /// Returns an [EmployeeListModel] on success, or null on failure.
  Future<EmployeeListModel?> getEmployeesList({
    required String accessToken,
  }) async {
    var url = Uri.parse(ApiConstants.BASE_URL);
    var body = {
      "accessToken": accessToken,
      "method": "getEmployeeList",
    };
    var response = await http.post(url, body: body);

    if (response.statusCode == 200) {
      EmployeeListModel employeeListModel =
      employeeListModelFromJson(response.body);
      if (employeeListModel.status == 403) {
        LoginController.instance.logoutUser();
      }
      return employeeListModel;
    }
    return null;
  }


}