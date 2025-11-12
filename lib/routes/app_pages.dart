import 'package:get/get.dart';
import 'package:shaligram_transport_app/ui/common/change_password/change_password_binding.dart';
import 'package:shaligram_transport_app/ui/common/change_password/change_password_screen.dart';
import 'package:shaligram_transport_app/ui/common/create_password/create_password_binding.dart';
import 'package:shaligram_transport_app/ui/common/create_password/create_password_screen.dart';
import 'package:shaligram_transport_app/ui/common/forgot_password/forgot_password_binding.dart';
import 'package:shaligram_transport_app/ui/common/forgot_password/forgot_password_screen.dart';
import 'package:shaligram_transport_app/ui/common/login/login_binding.dart';
import 'package:shaligram_transport_app/ui/common/login/login_screen.dart';
import 'package:shaligram_transport_app/ui/common/splash/splash_binding.dart';
import 'package:shaligram_transport_app/ui/common/splash/splash_screen.dart';
import 'package:shaligram_transport_app/ui/driver_screens/otp_verification/otp_verification.dart';
import 'package:shaligram_transport_app/ui/driver_screens/otp_verification/otp_verification_binding.dart';
import 'package:shaligram_transport_app/ui/paggination/paggination_binding.dart';
import 'package:shaligram_transport_app/ui/passenger/home/passenger_home_binding.dart';
import 'package:shaligram_transport_app/ui/passenger/home/passenger_home_screen.dart';
import 'package:shaligram_transport_app/ui/passenger/new_address/new_address_binding.dart';
import 'package:shaligram_transport_app/ui/passenger/new_address/new_address_screen.dart';
import 'package:shaligram_transport_app/ui/reset_password/reset_password_binding.dart';
import 'package:shaligram_transport_app/ui/reset_password/reset_password_view.dart';
import 'package:shaligram_transport_app/ui/testui.dart';
import '../ui/driver_screens/driver_report/driver_report_binding.dart';
import '../ui/driver_screens/driver_report/driver_report_screen.dart';
import '../ui/driver_screens/home/home_screen.dart';
import '../ui/driver_screens/home/home_binding.dart';
import '../ui/driver_screens/profile/profile_binding.dart';
import '../ui/driver_screens/profile/profile_screen.dart';
import '../ui/driver_screens/scan_qr/scan_qr_binding.dart';
import '../ui/driver_screens/scan_qr/scan_qr_screen.dart';
import '../ui/driver_screens/total_passengers/total_passengers_binding.dart';
import '../ui/driver_screens/total_passengers/total_passengers_screen.dart';
import '../ui/driver_screens/trip/trip_binding.dart';
import '../ui/driver_screens/trip/trip_screen.dart';
import '../ui/driver_screens/vehicleDetail/vehicledetail_binding.dart';
import '../ui/driver_screens/vehicleDetail/vehicledetail_screen.dart';
import '../ui/paggination/paggination_view.dart';
import 'app_routes.dart';

class AppPages {
  static List<GetPage> getPages = [
    GetPage(
        name: Routes.splash,
        page: () => const SplashPage(),
        binding: SplashBinding()),
    GetPage(
        name: Routes.login,
        page: () =>   const LoginPage(),
        binding: LoginBinding()),
    GetPage(
        name: Routes.forgotPassword,
        page: () =>  const ForgotPasswordPage(),
        binding: ForgotPasswordBinding()),
    GetPage(
        name: Routes.createPassword,
        page: () =>  const CreatePasswordPage(),
        binding: CreatePasswordBinding()),
    GetPage(
        name: Routes.otpVerification,
        page: () =>   const OtpVerification(),
        binding: OtpVerificationBinding()),
    GetPage(
        name: Routes.home,
        page: () =>  const HomePage(),
        binding: HomeBinding()),
    GetPage(
        name: Routes.scanQR,
        page: () =>  const ScanQRPage(),
        binding: ScanQRBinding()),
    GetPage(
        name: Routes.trip,
        page: () =>   TripPage(),
        binding: TripBinding()),
    GetPage(
        name: Routes.vehicleDetail,
        page: () =>  const VehicleDetailScreen(),
        binding: VehicleDetailBinding()),
    GetPage(
        name: Routes.totalPassengers,
        page: () =>  const TotalPassengersPage(),
        binding: TotalPassengersBinding()),
    GetPage(
        name: Routes.driverReport,
        page: () =>  const DriverReportScreen(),
        binding: DriverReportBinding()
    ),
    GetPage(
        name: Routes.profile,
        page: () =>   const ProfileScreen(),
        binding: ProfileBinding()
    ),
    GetPage(
        name: Routes.passengerHome,
        page: () =>  const PassengerHomePage(),
        binding: PassengerHomeBinding()
    ),
    GetPage(
        name: Routes.passengerNewAddress,
        page: () =>  const NewAddressPage(),
        binding: NewAddressBinding()
    ),
    GetPage(
        name: Routes.testui,
        page: () =>   const TestUi()
    ),
    GetPage(
        name: Routes.paggination,
        page: () =>    Pagination(),
        binding: PagginationBinding()
    ),
    GetPage(
        name: Routes.changePassword,
        page: () =>    const ChangePasswordPage(),
        binding: ChangePasswordBinding()
    ),
    GetPage(
        name: Routes.resetPassword,
        page: () =>    const ResetPasswordView(),
        binding: ResetPasswordBinding()
    ),
  ];
}
