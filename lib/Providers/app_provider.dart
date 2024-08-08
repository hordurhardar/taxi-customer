import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:taxi/Providers/AuthProvider/auth_provider.dart';
import 'package:taxi/Providers/BookRideProvider/book_ride_provider.dart';
import 'package:taxi/Providers/BookingProvider/booking_provider.dart';
import 'package:taxi/Providers/ChatProvider/chat_provider.dart';
import 'package:taxi/Providers/DestinationProvider/destination_provider.dart';
import 'package:taxi/Providers/DriverProvider/driver_provider.dart';
import 'package:taxi/Providers/HomeProvider/home_provider.dart';
import 'package:taxi/Providers/LanguageProvider/language_provider.dart';
import 'package:taxi/Providers/ManageAddressProvider/manage_address_provider.dart';
import 'package:taxi/Providers/MapProvider/map_provider.dart';
import 'package:taxi/Providers/NotificationProvider/notification_provider.dart';
import 'package:taxi/Providers/OnBoardingProvider/on_boarding_provider.dart';
import 'package:taxi/Providers/ProfileProvider/profile_provider.dart';
import 'package:taxi/Providers/RatingProvider/ratingProvider.dart';
import 'package:taxi/Providers/TipProvider/tip_provider.dart';
import 'HelpCenterProvider/help_center_provider.dart'
;
import 'contact_provider.dart';
class AppProvider {
  static final List<SingleChildWidget> appProviders = [
    ChangeNotifierProvider<OnBoardingProvider>(
        create: (_) => OnBoardingProvider()),
    ChangeNotifierProvider<ContactProvider>(create: (_) => ContactProvider()),
    ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
    ChangeNotifierProvider<ProfileProvider>(create: (_) => ProfileProvider()),
    ChangeNotifierProvider<NotificationProvider>(
        create: (_) => NotificationProvider()),
    ChangeNotifierProvider<ManageAddressProvider>(
        create: (_) => ManageAddressProvider()),
    ChangeNotifierProvider<MapProvider>(create: (_) => MapProvider()),
    ChangeNotifierProvider<HomeProvider>(create: (_) => HomeProvider()),
    ChangeNotifierProvider<DestinationProvider>(
        create: (_) => DestinationProvider()),
    ChangeNotifierProvider<BookRideProvider>(create: (_) => BookRideProvider()),
    ChangeNotifierProvider<RatingProvider>(create: (_) => RatingProvider()),
    ChangeNotifierProvider<DriverProvider>(create: (_) => DriverProvider()),
    ChangeNotifierProvider<BookingProvider>(create: (_) => BookingProvider()),
    ChangeNotifierProvider<TipProvider>(create: (_) => TipProvider()),
    ChangeNotifierProvider<HelpCenterProvider>(create: (_) => HelpCenterProvider()),
    ChangeNotifierProvider<ChatProvider>(create: (_) => ChatProvider()),
    ChangeNotifierProvider<LanguageProvider>(create: (_) => LanguageProvider()),
  ];
}
