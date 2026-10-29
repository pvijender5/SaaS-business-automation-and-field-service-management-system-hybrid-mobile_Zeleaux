import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zeleaux_app/app/data/models/employee_list_model.dart';

import '../../../utils/preferences.dart';
import '../../data/services/api_services.dart';

/// Controller for managing the employee list and related actions.
class EmployeeListController extends GetxController {
  /// Singleton instance getter for the controller.
  static EmployeeListController get instance {
    try {
      return Get.find<EmployeeListController>();
    } catch (e) {
      return Get.put(EmployeeListController());
    }
  }

  /// Observable model holding the employee list data.
  var employeeListModel = EmployeeListModel().obs;

  /// Observable loading state.
  RxBool isLoading = false.obs;

  /// Called when the controller is initialized.
  @override
  void onInit() {
    super.onInit();
    onInitController();
  }

  /// Additional initialization logic.
  void onInitController() {
    getEmployeeList();
  }

  /// Fetches the employee list from the API and updates the state.
  Future<void> getEmployeeList() async {
    isLoading.value = true;
    isLoading.refresh();
    update();

    // Retrieve user session token from shared preferences.
    var userLoginSession = await SharedPreferencesUtils()
        .getStringPreferences(SharedPreferencesUtils.LOGIN_SESSION);

    // Fetch employee list from API.
    var employeeListData = await ApiServices()
        .getEmployeesList(accessToken: userLoginSession ?? "");

    // Update state based on API response.
    if (employeeListData?.status == 200) {
      isLoading.value = false;
      if (employeeListData != null) {
        employeeListModel.value = employeeListData;
      }
    } else {
      isLoading.value = false;
    }
    isLoading.value = false;
    isLoading.refresh();
    update();
  }

  /// Initiates a phone call to the given [phoneNumber].
  void makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $launchUri';
    }
  }

  /// Sends an SMS with [message] to the [recipient].
  void makePhoneMessage(String message, String recipient) async {
    final Uri smsUri = Uri(
      scheme: 'sms',
      path: recipient,
      queryParameters: {'body': message},
    );
    if (await canLaunchUrl(smsUri)) {
      await launchUrl(smsUri);
    } else {
      throw 'Could not launch $smsUri';
    }
  }
}