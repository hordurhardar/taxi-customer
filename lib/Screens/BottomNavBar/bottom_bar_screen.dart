import 'package:flutter/material.dart';
import 'package:taxi/CommonWidgets/custom_scaffold.dart';
import 'package:taxi/Screens/Booking/booking_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:taxi/Screens/BottomNavBar/widgets/half_circle_widget.dart';
import 'package:taxi/Screens/Home/home_screen.dart';
import 'package:taxi/Screens/Profile/profile_screen.dart';
import 'package:taxi/Screens/Wallet/wallet_screen.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/app_fonts.dart';
import 'package:taxi/Utils/app_images.dart';
import 'package:taxi/Utils/helper_methods.dart';
import 'package:taxi/Widgets/svg_picture.dart';

class BottomBarScreen extends StatefulWidget {
  static const routeName = "/bottomBar_screen";

  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const WalletScreen(),
    const BookingScreen(),
    // const ChatScreen(),
    const ProfileScreen(),
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: CustomScaffold(
        extendBodyBehindAppBar: true,
        body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.only(top: 0.1),
          decoration: BoxDecoration(
              color: AppColors.greyBorder.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(100.0),
                  topRight: Radius.circular(100.0))),
          child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: _selectedIndex,
              selectedLabelStyle: const TextStyle(
                  fontSize: 11,
                  fontFamily: AppFonts.inter,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary),
              unselectedLabelStyle: const TextStyle(
                  fontSize: 11,
                  fontFamily: AppFonts.inter,
                  fontWeight: FontWeight.w500,
                  color: AppColors.iconDark),
              selectedItemColor: AppColors.primary,
              unselectedItemColor: AppColors.iconDark,
              iconSize: 50,
              backgroundColor: AppColors.white,
              onTap: _onItemTapped,
              // elevation: 5,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    activeIcon: Column(
                      children: [
                        const HalfCircleWidget(),
                        heightGap(5),
                        const SvgPic(
                          image: AppImages.homeYellow,
                          height: 25,
                          width: 25,
                        ),
                      ],
                    ),
                    icon: Column(
                      children: [
                        Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.transparent,
                          ),
                        ),
                        const SvgPic(
                          color: Colors.grey,
                          image: AppImages.homeYellow,
                          height: 25,
                          width: 25,
                        ),
                      ],
                    ),
                    label: AppLocalizations.of(context)!.home),
                BottomNavigationBarItem(
                  activeIcon: Column(
                    children: [
                      const HalfCircleWidget(),
                      heightGap(5),
                      const SvgPic(
                        image: AppImages.walletYellow,
                        height: 25,
                        width: 25,
                      ),
                    ],
                  ),
                  icon: Column(
                    children: [
                      Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.transparent,
                        ),
                      ),
                      const SvgPic(
                        image: AppImages.walletGrey,
                        height: 25,
                        width: 25,
                      ),
                    ],
                  ),
                  label: 'Wallet',
                  backgroundColor: AppColors.white,
                ),
                BottomNavigationBarItem(
                  activeIcon: Column(
                    children: [
                      const HalfCircleWidget(),
                      heightGap(5),
                      const SvgPic(
                        image: AppImages.calendarGrey,
                        color: AppColors.primary,
                        height: 25,
                        width: 25,
                      ),
                    ],
                  ),
                  icon: Column(
                    children: [
                      Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.transparent,
                        ),
                      ),
                      const SvgPic(
                        image: AppImages.calendarGrey,
                        height: 25,
                        width: 25,
                      ),
                    ],
                  ),
                  label: AppLocalizations.of(context)!.booking,
                  backgroundColor: AppColors.white,
                ),

                ///CHAT FUNCTIONALITY

                /*BottomNavigationBarItem(
                  activeIcon: Column(
                    children: [
                      const HalfCircleWidget(),
                      heightGap(5),
                      const SvgPic(
                        image: AppImages.messageIcon,
                        color: AppColors.primary,
                        height: 25,
                        width: 25,
                      ),
                    ],
                  ),
                  icon: Column(
                    children: [
                      Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.transparent,
                        ),
                      ),
                      const SvgPic(
                        image: AppImages.chatGrey,
                        height: 25,
                        width: 25,
                      ),
                    ],
                  ),
                  label: 'Chat',
                  backgroundColor: AppColors.white,
                ),*/
                BottomNavigationBarItem(
                  icon: Column(
                    children: [
                      Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.transparent,
                        ),
                      ),
                      const SvgPic(
                        image: AppImages.personGrey,
                        height: 25,
                        width: 25,
                      ),
                    ],
                  ),
                  activeIcon: Column(
                    children: [
                      const HalfCircleWidget(),
                      heightGap(5),
                      const SvgPic(
                        image: AppImages.personYellow,
                        height: 25,
                        width: 25,
                      ),
                    ],
                  ),
                  label: AppLocalizations.of(context)!.profile,
                  backgroundColor: AppColors.white,
                ),
              ]),
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
