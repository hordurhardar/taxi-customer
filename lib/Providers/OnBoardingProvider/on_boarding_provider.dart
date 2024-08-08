import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxi/Models/on_bording_model.dart';
import 'package:taxi/Screens/Auth/SignIn/sign_in_screen.dart';
import 'package:taxi/Utils/app_images.dart';

class OnBoardingProvider with ChangeNotifier {
  late PageController pageController;

  int pageChangeIndex = 0;

  List<OnBoardingModel> onBoardingList = [
    OnBoardingModel(
        image: AppImages.mobile,
        heading1: "Book a Ride",
        heading2: 'Anywhere, Anytime!',
        title:
            "Lorem Ipsum Is Simply Dummy Text The Printing Typesetting Industry. Lorem Ipsum Is Simple."),
    OnBoardingModel(
        image: AppImages.mobile,
        heading1: "Choose Your Comfort :",
        heading2: 'Enjoy a Luxurious Ride',
        title:
            "Lorem Ipsum Is Simply Dummy Text The Printing Typesetting Industry. Lorem Ipsum Is Simple."),
    OnBoardingModel(
        image: AppImages.mobile,
        heading1: "Elevate Your Ride",
        heading2: 'Tracking Experience',
        title:
            "Lorem Ipsum Is Simply Dummy Text The Printing Typesetting Industry. Lorem Ipsum Is Simple."),
  ];

  int selectedIndex = 0;

  Future<void> initializedPageController() async {
    pageController = PageController(initialPage: 0);
  }

  Future<void> makeLanguageSelection({required int index}) async {
    selectedIndex = index;
    notifyListeners();
  }

  Future<void> changePageIndex({required int index}) async {
    pageChangeIndex = index;
    notifyListeners();
  }

  void nextPage({required BuildContext context}) {
    if (pageChangeIndex < 2) {
      pageChangeIndex++;
      pageController.animateToPage(pageChangeIndex,
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    } else {
      Navigator.of(context)
          .pushReplacementNamed(SignInScreen.routeName);
    }
  }

  void previousPage() {
    if (pageChangeIndex > 0) {
      pageChangeIndex--;
      pageController.animateToPage(pageChangeIndex,
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    }
  }
}
