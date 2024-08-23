import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxi/CommonWidgets/custom_scaffold.dart';
import 'package:taxi/CommonWidgets/elevated_button_widget.dart';
import 'package:taxi/CommonWidgets/text_form_field_widget.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:taxi/Providers/AuthProvider/auth_provider.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/app_fonts.dart';
import 'package:taxi/Utils/app_images.dart';
import 'package:taxi/Utils/helper_methods.dart';
import 'package:taxi/Widgets/svg_picture.dart';
import '../../../Utils/validations.dart';
import '../Content/content_screen.dart';

class SignUpScreen extends StatelessWidget {
  static const routeName = "/sign_up_screen";

  SignUpScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, provider, child) {
      return WillPopScope(
        onWillPop: onWillPop,
        child: CustomScaffold(
          resizeToAvoidBottomInset: true,
          body: Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Form(
                          key: formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                heightGap(20),
                                Center(
                                  child: TextWidget(
                                    text: AppLocalizations.of(context)!
                                        .createAccount,
                                    fontSize: 26,
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                heightGap(18),
                                Center(
                                  child: TextWidget(
                                    color: AppColors.greyHint,
                                    textAlign: TextAlign.center,
                                    text: AppLocalizations.of(context)!
                                        .fillYourInformationBelowOrRegisterWithYourSocialAccount,
                                  ),
                                ),
                                heightGap(20),
                                TextWidget(
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.w500,
                                  text: AppLocalizations.of(context)!.name,
                                ),
                                TextFormFieldWidget(
                                  hintText: AppLocalizations.of(context)!.name,
                                  controller: nameController,
                                  validator: (value) => Validations.instance
                                      .emptyValidation(
                                          value: value!,
                                          field: AppLocalizations.of(context)!
                                              .name),
                                ),
                                heightGap(12),
                                TextWidget(
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.w500,
                                  text: AppLocalizations.of(context)!.email,
                                ),
                                TextFormFieldWidget(
                                  hintText:
                                      AppLocalizations.of(context)!.enterEmail,
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) => Validations.instance
                                      .emailValidation(value!, context),
                                ),
                                heightGap(12),
                                TextWidget(
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.w500,
                                  text:
                                      AppLocalizations.of(context)!.phoneNumber,
                                ),
                                Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: AppColors.greyBorder)),
                                    child: Row(
                                      children: [
                                        CountryCodePicker(
                                          onChanged: (value) {
                                            context
                                                .read<AuthProvider>()
                                                .changeCountryCode(
                                                    countryCode: value.dialCode
                                                        .toString());
                                          },
                                          // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                          initialSelection:
                                              '+${context.read<AuthProvider>().countryCode}',
                                          favorite: const ['+354'],
                                          // optional. Shows only country name and flag
                                          showCountryOnly: false,
                                          // optional. Shows only country name and flag when popup is closed.
                                          showOnlyCountryWhenClosed: false,
                                          // optional. aligns the flag and the Text left
                                          alignLeft: false,
                                          showFlagMain: false,
                                        ),
                                        const SizedBox(
                                          height: 25,
                                          child: VerticalDivider(
                                            color: AppColors.greyBorder,
                                          ),
                                        ),
                                        Expanded(
                                          child: TextFormFieldWidget(
                                            showBorder: false,
                                            keyboardType: TextInputType.number,
                                            controller: phoneController,
                                            maxLength: 13,
                                            hintText:
                                                AppLocalizations.of(context)!
                                                    .phoneNumber,
                                            validator: (v) => Validations
                                                .instance
                                                .phoneValidation(v!, context),
                                          ),
                                        ),
                                      ],
                                    )),

                                // ** Gender selection field ** //

                                // TextWidget(
                                //   color: AppColors.blackColor,
                                //   fontWeight: FontWeight.w500,
                                //   text: AppLocalizations.of(context)!.gender,
                                // ),
                                // heightGap(12),
                                // DropdownButtonFormField(
                                //     decoration: InputDecoration(
                                //       enabledBorder: OutlineInputBorder(
                                //         borderSide: const BorderSide(color: AppColors.greyBorder, width: 1),
                                //         borderRadius: BorderRadius.circular(20),
                                //       ),
                                //       border: OutlineInputBorder(
                                //         borderSide: const BorderSide(color: AppColors.greyBorder, width: 1),
                                //         borderRadius: BorderRadius.circular(20),
                                //       ),
                                //       disabledBorder: OutlineInputBorder(
                                //         borderSide: const BorderSide(color: AppColors.greyBorder, width: 1),
                                //         borderRadius: BorderRadius.circular(20),
                                //       ),
                                //       errorBorder: OutlineInputBorder(
                                //         borderSide: const BorderSide(color: AppColors.greyBorder, width: 1),
                                //         borderRadius: BorderRadius.circular(20),
                                //       ),
                                //       focusedBorder: OutlineInputBorder(
                                //         borderSide: const BorderSide(color: AppColors.greyBorder, width: 1),
                                //         borderRadius: BorderRadius.circular(20),
                                //       ),
                                //       focusedErrorBorder: OutlineInputBorder(
                                //         borderSide: const BorderSide(color: AppColors.greyBorder, width: 1),
                                //         borderRadius: BorderRadius.circular(20),
                                //       ),
                                //       filled: true,
                                //       fillColor: AppColors.white,
                                //     ),
                                //     hint: const TextWidget(
                                //       text: 'Select',
                                //     ),
                                //     validator: (value) => value == null ? "Select gender" : null,
                                //     dropdownColor: Colors.white,
                                //     value: provider.selectedGender,
                                //     onChanged: (String? newValue) {
                                //       provider.selectedGender = newValue!;
                                //     },
                                //     items: dropdownItems),
                                heightGap(12),
                                TextWidget(
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.w500,
                                  text: AppLocalizations.of(context)!.password,
                                ),
                                Consumer<AuthProvider>(
                                  builder: (context, value, child) {
                                    return TextFormFieldWidget(
                                      hintText: AppLocalizations.of(context)!
                                          .enterPassword,
                                      controller: passwordController,
                                      isPassword: true,
                                      obscureText: value.passwordObSecureSignUp,
                                      onVisibilityIconTap: () {
                                        context
                                            .read<AuthProvider>()
                                            .changeObSecureForSignUp();
                                      },
                                      validator: (value) => Validations.instance
                                          .passwordValidation(value!, context),
                                    );
                                  },
                                ),

                                // ** terms check widget ** //

                                // heightGap(12),
                                // Consumer<AuthProvider>(
                                //   builder: (context, value, child) {
                                //     return Row(
                                //       children: [
                                //         Checkbox(
                                //           value: value.termsConditionCheck,
                                //           onChanged: (value) {
                                //             context
                                //                 .read<AuthProvider>()
                                //                 .updateTermsConditionCheckBoxValue(
                                //                     value: value!);
                                //           },
                                //           checkColor: AppColors.black,
                                //           activeColor: AppColors.primary,
                                //         ),
                                //         richText(
                                //           context: context,
                                //           firstText: AppLocalizations.of(context)!
                                //               .agreeWith,
                                //           secondText: AppLocalizations.of(context)!
                                //               .termsCondition,
                                //           secondStyle: const TextStyle(
                                //             color: AppColors.primary,
                                //             fontSize: 16,
                                //             fontWeight: FontWeight.w400,
                                //             decoration: TextDecoration.underline,
                                //             decorationColor: AppColors.primary,
                                //             fontFamily: AppFonts.inter,
                                //           ),
                                //           onTap: () {
                                //             Navigator.of(context)
                                //                 .pushNamed(
                                //                 ContentScreen.routeName);
                                //           },
                                //         )
                                //       ],
                                //     );
                                //   },
                                // ),
                                heightGap(20),
                                ElevatedButtonWidget(
                                  onPressed: () {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    // if (phoneController.text.isEmpty) {
                                    //   showSnackBar(
                                    //       context: context,
                                    //       message: 'Please enter phone number',
                                    //       isSuccess: false);
                                    // } else if (phoneController.text.length <
                                    //         7 ) {
                                    //   showSnackBar(
                                    //       context: context,
                                    //       message:
                                    //           'Please enter valid phone number',
                                    //       isSuccess: false);
                                    // } else {
                                    print(
                                        "Country Code is ${context.read<AuthProvider>().countryCode}");
                                    if (formKey.currentState!.validate()) {
                                      context.read<AuthProvider>().setEmail =
                                          emailController.text.trim();
                                      context.read<AuthProvider>().setPhone =
                                          phoneController.text.trim();
                                      context.read<AuthProvider>().setName =
                                          nameController.text.trim().trim();
                                      context.read<AuthProvider>().setPassword =
                                          passwordController.text.trim();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (builder) =>
                                                  const ContentScreen()));
                                    }
                                    // }
                                  },
                                  width: double.infinity,
                                  text: AppLocalizations.of(context)!.signUp,
                                ),
                                heightGap(20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(width: 40, child: Divider()),
                                    widthGap(10),
                                    TextWidget(
                                      color: AppColors.greyHint,
                                      text: AppLocalizations.of(context)!
                                          .orSignUpWith,
                                    ),
                                    widthGap(10),
                                    const SizedBox(width: 40, child: Divider()),
                                  ],
                                ),
                                heightGap(20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          border: Border.all(
                                              color: AppColors.greyHint)),
                                      child: const SvgPic(
                                        image: AppImages.appleLogo,
                                      ),
                                    ),
                                    widthGap(10),
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          border: Border.all(
                                              color: AppColors.greyHint)),
                                      child: const SvgPic(
                                        image: AppImages.googleLogo,
                                      ),
                                    ),
                                    widthGap(10),
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          border: Border.all(
                                              color: AppColors.greyHint)),
                                      child: const SvgPic(
                                        image: AppImages.facebookLogo,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Center(
                  child: richText(
                    context: context,
                    firstText:
                        AppLocalizations.of(context)!.alreadyHaveAnAccount,
                    secondText: AppLocalizations.of(context)!.signIn,
                    secondStyle: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.primary,
                      fontFamily: AppFonts.inter,
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                heightGap(deviceHeight(context) * 0.010),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget socialContainer({required String image, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: AppColors.greyHint)),
        child: SvgPic(
          image: image,
        ),
      ),
    );
  }

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
}
