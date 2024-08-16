import 'package:flutter/material.dart';
import 'package:taxi/Utils/app_colors.dart';


class CommonFooterWidget extends StatelessWidget {
  final Widget cartItem;
  const CommonFooterWidget({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return    Container(
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.8),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 6), // changes position of shadow
          ),
        ],
      ),
      child: Card(
        color: AppColors.white,
        margin: EdgeInsets.zero,
        elevation: 0,shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(8),topLeft: Radius.circular(8))),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 20),
          child: cartItem,
        ),
      ),
    );
  }
}
