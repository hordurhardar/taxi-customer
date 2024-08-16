import 'package:flutter/material.dart';

import '../Utils/app_colors.dart';

class CustomScaffold extends StatefulWidget {
  final Widget? body;
  final Widget? floatingActionButton;
  final PreferredSizeWidget? appBar;
  final Color statusBarColor;
  final Brightness statusBarIconBrightness;
  final Color backgroundColor;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final bool extendBodyBehindAppBar;
  final bool resizeToAvoidBottomInset;

  const CustomScaffold(
      {super.key,
      this.body,
      this.appBar,
      this.bottomSheet,
      this.floatingActionButton,
      this.resizeToAvoidBottomInset = false,
      this.bottomNavigationBar,
      this.floatingActionButtonLocation,
      this.extendBodyBehindAppBar = false,
      this.statusBarColor = AppColors.white,
      this.statusBarIconBrightness = Brightness.light,
      this.backgroundColor = AppColors.white});

  @override
  State<CustomScaffold> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
      bottomSheet: widget.bottomSheet,
      backgroundColor: widget.backgroundColor,
      appBar: widget.appBar ??
          AppBar(
            toolbarHeight: 0,
            backgroundColor: widget.statusBarColor,
            elevation: 0,
          ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: widget.body,
      ),
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
      bottomNavigationBar: widget.bottomNavigationBar,
      floatingActionButton: widget.floatingActionButton,
    );
  }
}
