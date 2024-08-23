import 'package:flutter/material.dart';
import 'package:taxi/Screens/Auth/ForgotPassword/forgot_password_screen.dart';
import 'package:taxi/Screens/Auth/LocationAccess/enable_location_access_screen.dart';
import 'package:taxi/Screens/Auth/SetPassword/new_password_screen.dart';
import 'package:taxi/Screens/Auth/SignIn/sign_in_screen.dart';
import 'package:taxi/Screens/Auth/SignUp/sign_up_screen.dart';
import 'package:taxi/Screens/Auth/VerifyCode/verify_code_screen.dart';
import 'package:taxi/Screens/Booking/CancelTaxiBooking/cancel_taxi_booking.dart';
import 'package:taxi/Screens/BottomNavBar/bottom_bar_screen.dart';
import 'package:taxi/Screens/Chat/chat_screen.dart';
import 'package:taxi/Screens/Home/ActiveRide/active_at_destination_screen.dart';
import 'package:taxi/Screens/Home/ActiveRide/active_ride_live_location.dart';
import 'package:taxi/Screens/Home/BookRide/book_ride_screen.dart';
import 'package:taxi/Screens/Home/BookRide/pre_book_ride.dart';
import 'package:taxi/Screens/Home/BookRide/schedule_ride_screen.dart';
import 'package:taxi/Screens/Home/BookRide/search_ride_screen.dart';
import 'package:taxi/Screens/Home/DriverArrive/driver_arriving_screen.dart';
import 'package:taxi/Screens/Home/Driver/driver_details_screen.dart';
import 'package:taxi/Screens/Home/PayCash/loyalty_points_screen.dart';
import 'package:taxi/Screens/Home/PayCash/pay_cash_screen.dart';
import 'package:taxi/Screens/Home/Payment/add_card_screen.dart';
import 'package:taxi/Screens/Home/Payment/payment_method_screen.dart';
import 'package:taxi/Screens/Home/Rate/rate_driver_screen.dart';
import 'package:taxi/Screens/Home/Receipt/receipt_screen.dart';
import 'package:taxi/Screens/Home/Tip/tip_for_driver_screen.dart';
import 'package:taxi/Screens/Home/destination_screen.dart';
import 'package:taxi/Screens/Home/pick_up_screen.dart';
import 'package:taxi/Screens/Home/promo_screen.dart';
import 'package:taxi/Screens/Home/saved_places.dart';
import 'package:taxi/Screens/Notification/notification_screen.dart';
import 'package:taxi/Screens/OnBording/on_boarding_screen.dart';
import 'package:taxi/Screens/Profile/complete_profile_screen.dart';
import 'package:taxi/Screens/Profile/your_profile_screen.dart';
import 'package:taxi/Screens/Settings/Emergency/emergency_contact_screen.dart';
import 'package:taxi/Screens/Settings/Emergency/emergency_screen.dart';
import 'package:taxi/Screens/Settings/ManageAddress/add_address_screen.dart';
import 'package:taxi/Screens/Settings/ManageAddress/choose_address_map_screen.dart';
import 'package:taxi/Screens/Settings/help_center_screen.dart';
import 'package:taxi/Screens/Settings/invite_screen.dart';
import 'package:taxi/Screens/Settings/ManageAddress/manage_address_screen.dart';
import 'package:taxi/Screens/Settings/password_manager_screen.dart';
import 'package:taxi/Screens/Settings/setting_screen.dart';
import 'package:taxi/Screens/Splash/get_start_screen.dart';
import 'package:taxi/Screens/Splash/splash_screen.dart';
import 'package:taxi/Screens/Wallet/add_money_screen.dart';
import 'package:taxi/Screens/Wallet/wallet_screen.dart';

import '../Screens/Auth/Content/content_screen.dart';
import '../Screens/Home/BookRide/book_for_self_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  final arguments = settings.arguments;
  switch (settings.name) {
    case "/":
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const SplashScreen(),
      );
    case GetStartScreen.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const GetStartScreen(),
      );
    case OnBoardingScreen.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const OnBoardingScreen(),
      );
    case SignInScreen.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => SignInScreen(),
      );
    case SignUpScreen.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => SignUpScreen(),
      );
    case BottomBarScreen.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const BottomBarScreen(),
      );
    case VerifyCodeScreen.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const VerifyCodeScreen(),
      );
    case CompleteProfileScreen.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const CompleteProfileScreen(),
      );
    case EnableLocationAccess.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const EnableLocationAccess(),
      );
    case NewPasswordScreen.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => NewPasswordScreen(),
      );
    case DestinationScreen.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const DestinationScreen(),
      );
    case BookRideScreen.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const BookRideScreen(),
      );
    case SavedPlacesScreen.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const SavedPlacesScreen(),
      );
    case ScheduleRideScreen.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const ScheduleRideScreen(),
      );
    case SearchRideScreen.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const SearchRideScreen(),
      );
    case InviteScreen.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const InviteScreen(),
      );
    case CancelTaxiBooking.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const CancelTaxiBooking(),
      );
    case YourProfileScreen.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const YourProfileScreen(),
      );
    case ManageAddressScreen.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const ManageAddressScreen(),
      );
    case PickUpScreen.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const PickUpScreen(),
      );
    case PaymentMethodScreen.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const PaymentMethodScreen(),
      );
    case PromoScreen.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const PromoScreen(),
      );
    case BookForSelfScreen.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const BookForSelfScreen(),
      );
    case AddCardScreen.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const AddCardScreen(),
      );
    case WalletScreen.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => WalletScreen(
          showToolbar: arguments as bool,
        ),
      );
    case AddMoney.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const AddMoney(),
      );
    case DriverArrivingScreen.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const DriverArrivingScreen(),
      );
    case AddAddressScreen.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const AddAddressScreen(),
      );
    case NotificationScreen.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const NotificationScreen(),
      );
    case SettingScreen.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const SettingScreen(),
      );
    case HelpCenterScreen.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const HelpCenterScreen(),
      );
    case ActiveRideLiveLocation.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const ActiveRideLiveLocation(),
      );
    case ActiveAtDestinationScreen.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const ActiveAtDestinationScreen(),
      );
    case PayCashScreen.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const PayCashScreen(),
      );
    case LoyaltyPointsScreen.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const LoyaltyPointsScreen(),
      );
    case RateDriverScreen.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => RateDriverScreen(),
      );
    case ReceiptScreen.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const ReceiptScreen(),
      );
    case TipForDriverScreen.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const TipForDriverScreen(),
      );
    case DriverDetailsScreen.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => DriverDetailsScreen(
          driverId:
              (settings.arguments as Map<String, dynamic>?)?['driver_id'] ?? '',
        ),
      );
    case EmergencyScreen.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const EmergencyScreen(),
      );
    case EmergencyContactScreen.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const EmergencyContactScreen(),
      );
    case PreBookedRide.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const PreBookedRide(),
      );
    case ForgotPasswordScreen.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => ForgotPasswordScreen(),
      );
    case ContentScreen.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const ContentScreen(),
      );
    case PasswordManagerScreen.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => PasswordManagerScreen(),
      );
    case ChooseAddressMapScreen.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const ChooseAddressMapScreen(),
      );
    case ChatScreen.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const ChatScreen(),
      );
    default:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => Scaffold(
          body: Center(child: Text('No route defined for ${settings.name}')),
        ),
      );
  }
}
