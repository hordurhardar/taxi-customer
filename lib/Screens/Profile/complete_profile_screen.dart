import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxi/CommonWidgets/custom_scaffold.dart';
import 'package:taxi/CommonWidgets/elevated_button_widget.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:taxi/Providers/AuthProvider/auth_provider.dart';
import 'package:taxi/Screens/Auth/LocationAccess/enable_location_access_screen.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/helper_methods.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:taxi/Widgets/toolbar.dart';

import '../../Utils/app_images.dart';

class CompleteProfileScreen extends StatefulWidget {
  static const routeName = "/completeProfile_screen";

  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  String? selectedValue;

  final _dropdownFormKey = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();
  final phoneNumberController = TextEditingController();

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          value: "Male",
          child: TextWidget(
            text: "Male",
          )),
      const DropdownMenuItem(
          value: "Female", child: TextWidget(text: "Female")),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Padding(
        padding: const EdgeInsets.only(right: 20.0, left: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heightGap(
                16,
              ),
              const Toolbar(),
              heightGap(
                deviceHeight(context) * 0.02,
              ),
              SizedBox(
                width: deviceWidth(context) * 0.9,
                child: Center(
                  child: TextWidget(
                    text: AppLocalizations.of(context)!.completeYourProfile,
                    fontSize: 26,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              heightGap(10),
              Center(
                child: SizedBox(
                  width: deviceWidth(context) * 0.8,
                  child: Center(
                    child: TextWidget(
                      color: AppColors.greyHint,
                      textAlign: TextAlign.center,
                      fontSize: 13,
                      text:
                          AppLocalizations.of(context)!.doNotWorryPersonalData,
                    ),
                  ),
                ),
              ),
              heightGap(20),
              Center(
                child: Stack(
                  children: [
                    Consumer<AuthProvider>(
                      builder: (context, value, child) {
                        return value.isLoading
                            ? const SizedBox(
                                width: 100,
                                height: 100,
                                child: CupertinoActivityIndicator(
                                  color: AppColors.black,
                                ))
                            : value.imageData != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      decoration: const BoxDecoration(),
                                      child: Image.file(
                                        value.imageData!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                : Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: AppColors.greyBorder),
                                    child: Image.asset(AppImages.user),
                                  );
                      },
                    ),
                    Positioned(
                      bottom: 10,
                      right: 0,
                      child: InkWell(
                        onTap: () async {
                          await context
                              .read<AuthProvider>()
                              .showBottomSheet(context: context);
                        },
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: AppColors.primary),
                          child: const Icon(
                            Icons.edit_outlined,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              heightGap(20),
              // TextWidget(
              //   color: AppColors.blackColor,
              //   fontWeight: FontWeight.w500,
              //   text: AppLocalizations.of(context)!.email,
              // ),
              // TextFormFieldWidget(
              //   hintText: AppLocalizations.of(context)!.enterEmail,
              //   controller: phoneNumberController,
              //   keyboardType: TextInputType.emailAddress,
              //   validator: (value) => Validations.instance.emailValidation(value!, context),
              // ),
              // Container(
              //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: AppColors.greyBorder)),
              //     child: Row(
              //       children: [
              //         CountryCodePicker(
              //           onChanged: (value) {
              //             context.read<AuthProvider>().changeCountryCode(countryCode: value.dialCode.toString());
              //           },
              //           // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
              //           initialSelection: 'IS',
              //           favorite: ['+354'],
              //           // optional. Shows only country name and flag
              //           showCountryOnly: false,
              //           // optional. Shows only country name and flag when popup is closed.
              //           showOnlyCountryWhenClosed: false,
              //           // optional. aligns the flag and the Text left
              //           alignLeft: false,
              //           showFlagMain: false,
              //         ),
              //         const SizedBox(
              //           height: 25,
              //           child: VerticalDivider(
              //             color: AppColors.greyBorder,
              //           ),
              //         ),
              //         Expanded(
              //           child: TextFormFieldWidget(
              //             showBorder: false,
              //             keyboardType: TextInputType.number,
              //             controller: phoneNumberController,
              //             hintText: AppLocalizations.of(context)!.phoneNumber,
              //           ),
              //         ),
              //       ],
              //     )),
              //heightGap(10),
              TextWidget(
                color: AppColors.blackColor,
                fontWeight: FontWeight.w500,
                text: AppLocalizations.of(context)!.gender,
              ),
              heightGap(8),
              DropdownButtonFormField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: AppColors.greyBorder, width: 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: AppColors.greyBorder, width: 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: AppColors.greyBorder, width: 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: AppColors.greyBorder, width: 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: AppColors.greyBorder, width: 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: AppColors.greyBorder, width: 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    filled: true,
                    fillColor: AppColors.white,
                  ),
                  hint: const TextWidget(
                    text: 'Select',
                  ),
                  validator: (value) => value == null ? "Select gender" : null,
                  dropdownColor: Colors.white,
                  value: selectedValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedValue = newValue!;
                    });
                  },
                  items: dropdownItems),
              heightGap(30),
              ElevatedButtonWidget(
                onPressed: () async {
                  final update =
                      await context.read<AuthProvider>().updateProfile(
                            context: context,
                            gender: selectedValue.toString(),
                            profileImage:
                                context.read<AuthProvider>().profileImageUrl,
                            email: phoneNumberController.text,
                          );
                  if (update) {
                    Navigator.of(context)
                        .pushNamed(EnableLocationAccess.routeName);
                  }
                },
                width: double.infinity,
                text: AppLocalizations.of(context)!.completeProfile,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
