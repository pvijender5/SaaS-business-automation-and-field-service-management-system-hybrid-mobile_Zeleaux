import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:zeleaux_app/binding/add_break_binding.dart';
import 'package:zeleaux_app/app/modules/employees_list/employee_list_binding.dart';
import 'package:zeleaux_app/binding/landing_page_binding.dart';
import 'package:zeleaux_app/binding/login_binding.dart';
import 'package:zeleaux_app/binding/overview_binding.dart';
import 'package:zeleaux_app/binding/profile_binding.dart';



import '../change_password_binding.dart';
import '../binding/clock_time_binding.dart';
import '../binding/forgot_password_binding.dart';
import '../modules/dashboard/landing_page.dart';
import '../modules/employees_list/employees_screen.dart';
import '../modules/splash/splash_screen.dart';

class Routes {
  static const String SPLASH = "/";
  static const String LOGIN = "/login";
  static const String FORGOT_PASSWORD = "/forgot_password";
  static const String LANDING_PAGE = "/landing_page";
  static const String ADD_BREAK = "/add_break";
  static const String Employee_List = "/employees";

  static var routes = [
    GetPage(name: SPLASH, page: () => const SplashScreen()),
    GetPage(
        name: LOGIN, page: () => const LoginView(), binding: LoginBinding()),
    GetPage(
        name: FORGOT_PASSWORD,
        page: () => const ForgotPasswordView(),
        binding: ForgotPasswordBinding()),
    GetPage(
        name: LANDING_PAGE,
        page: () => const LandingPage(),
        binding: LandingPageBinding()),
    GetPage(
        name: CLOCK_TIME, page: () => ClockTime(), binding: ClockTimeBinding()),
    GetPage(
        name: TIME_SHEET, page: () => TimeSheet(), binding: TimeSheetBinding()),
    GetPage(
        name: ADD_BREAK,
        page: () => AddBreakView(),
        binding: AddBreakBinding()),
    GetPage(
        name: Employee_List,
        page: () => const EmployeesScreen(),
        binding: EmployeeListBinding()),
    GetPage(
        name: PROFILE_SCREEN,
        page: () => ProfileScreen(),
        binding: ProfileBinding()),
    GetPage(
        name: CHANGE_PASSWORD,
        page: () => ChangePasswordScreen(),
        binding: ChangePasswordBinding()),
    GetPage(
        name: NOTIFICATION,
        page: () => const NotificationScreen(),
        binding: OverviewBinding()),
    GetPage(
        name: SCHEDULE_DETAIL,
        page: () => const ScheduleDetailScreen(),
        binding: ScheduleDetailBinding()),
  ];
}
