import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxi/CommonWidgets/custom_scaffold.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:taxi/CommonWidgets/elevated_button_widget.dart';
import 'package:taxi/CommonWidgets/text_form_field_widget.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:taxi/Providers/AuthProvider/auth_provider.dart';
import 'package:taxi/Providers/LanguageProvider/language_provider.dart';
import 'package:taxi/Providers/ProfileProvider/profile_provider.dart';
import 'package:taxi/Providers/Type/from_auth_type.dart';
import 'package:taxi/Remote/api_config.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/app_images.dart';
import 'package:taxi/Utils/helper_methods.dart';
import 'package:taxi/Utils/validations.dart';
import 'package:taxi/Widgets/common_footer_widget.dart';
import 'package:taxi/Widgets/toolbar.dart';

class YourProfileScreen extends StatefulWidget {
  static const routeName = "/yourProfile_screen";

  const YourProfileScreen({super.key});

  @override
  State<YourProfileScreen> createState() => _YourProfileScreenState();
}

class _YourProfileScreenState extends State<YourProfileScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      () {
        context.read<AuthProvider>().clearData();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Consumer<ProfileProvider>(
        builder: (context, value, child) {
          return Column(
            children: [
              heightGap(16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Toolbar(
                  title: AppLocalizations.of(context)!.yourProfile,
                  showCount: false,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          Consumer<AuthProvider>(
                            builder: (context, valueAuthProvider, child) {
                              return valueAuthProvider.isLoading
                                  ? const SizedBox(
                                      width: 100,
                                      height: 100,
                                      child: CupertinoActivityIndicator(
                                        color: AppColors.black,
                                      ))
                                  : valueAuthProvider.imageData != null
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Container(
                                            width: 100,
                                            height: 100,
                                            decoration: const BoxDecoration(),
                                            child: Image.file(
                                              valueAuthProvider.imageData!,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        )
                                      : value.profileData?.profileImage != null
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              child: Container(
                                                width: 100,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    color:
                                                        AppColors.greyBorder),
                                                child: Image.network(
                                                  '$IMAGE_URL${value.profileData?.profileImage ?? ''}',
                                                  //'https://b2btobacco.s3.amazonaws.com/taxi/profile/image_1712987083086.png',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            )
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              child: Container(
                                                width: 100,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    color:
                                                        AppColors.greyBorder),
                                                child: Image.asset(
                                                  AppImages.user,
                                                  //'https://b2btobacco.s3.amazonaws.com/taxi/profile/image_1712987083086.png',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            );
                            },
                          ),

                          /*Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: AppColors.greyBg),
                        ),*/
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
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Form(
                          key: formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.w500,
                                  text: AppLocalizations.of(context)!.name,
                                ),
                                heightGap(8),
                                TextFormFieldWidget(
                                  hintText: AppLocalizations.of(context)!.name,
                                  controller: value.nameController,
                                  validator: (value) => Validations.instance
                                      .emptyValidation(
                                          value: value!,
                                          field: AppLocalizations.of(context)!
                                              .name),
                                ),
                                heightGap(10),
                                TextWidget(
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.w500,
                                  text:
                                      AppLocalizations.of(context)!.phoneNumber,
                                ),
                                heightGap(8),
                                Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: AppColors.greyBorder)),
                                    child: Row(
                                      children: [
                                        CountryCodePicker(
                                          onChanged: (val) {
                                            context
                                                .read<AuthProvider>()
                                                .changeCountryCode(
                                                    countryCode:
                                                        val.code.toString());
                                            value.changeCountryCode(
                                                val.code.toString());
                                          },
                                          // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                          initialSelection: value.profileData
                                                      ?.countryCode !=
                                                  null
                                              ? value.profileData!.countryCode!
                                                      .startsWith('+')
                                                  ? value
                                                      .profileData!.countryCode
                                                  : '+${value.profileData!.countryCode}'
                                              : '+354',
                                          favorite: const ['+354', 'FR'],
                                          // optional. Shows only country name and flag
                                          showCountryOnly: true,
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
                                            controller:
                                                value.phoneNumberController,
                                            hintText:
                                                AppLocalizations.of(context)!
                                                    .phoneNumber,
                                            onChanged: value.changeMobile,
                                          ),
                                        ),
                                      ],
                                    )),
                                Visibility(
                                    visible: value.isVerifyMobile,
                                    child: heightGap(10)),
                                Visibility(
                                  visible: value.isVerifyMobile,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                              .itNeedsToBeVerify,
                                          style: const TextStyle(
                                              fontSize: 14, color: Colors.red),
                                        ),
                                        ElevatedButtonWidget(
                                          text: AppLocalizations.of(context)!
                                              .verify,
                                          height: 30,
                                          onPressed: () {
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                            if (Validations.instance
                                                    .phoneValidation(
                                                        value
                                                            .phoneNumberController
                                                            .text,
                                                        context) ==
                                                null) {
                                              context
                                                      .read<AuthProvider>()
                                                      .setPhone =
                                                  value.phoneNumberController
                                                      .text;
                                              context
                                                  .read<AuthProvider>()
                                                  .countryCode = value
                                                      .profileData
                                                      ?.countryCode ??
                                                  "354";

                                              context
                                                      .read<AuthProvider>()
                                                      .setFromType =
                                                  FromAuthType.fromProfile;
                                              context
                                                  .read<AuthProvider>()
                                                  .sendOtp(
                                                      context: context,
                                                      type: "phone");
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                heightGap(10),
                                TextWidget(
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.w500,
                                  text: AppLocalizations.of(context)!.email,
                                ),
                                heightGap(8),
                                TextFormFieldWidget(
                                  hintText:
                                      AppLocalizations.of(context)!.enterEmail,
                                  controller: value.emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) => Validations.instance
                                      .emailValidation(value!, context),
                                  onChanged: value.changeEmail,
                                ),
                                Visibility(
                                    visible: value.isVerifyEmail,
                                    child: heightGap(10)),
                                Visibility(
                                  visible: value.isVerifyEmail,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                              .itNeedsToBeVerify,
                                          style: const TextStyle(
                                              fontSize: 14, color: Colors.red),
                                        ),
                                        ElevatedButtonWidget(
                                          text: AppLocalizations.of(context)!
                                              .verify,
                                          height: 30,
                                          onPressed: () {
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                            if (Validations.instance
                                                    .phoneValidation(
                                                        value.emailController
                                                            .text,
                                                        context) ==
                                                null) {
                                              context
                                                      .read<AuthProvider>()
                                                      .setEmail =
                                                  value.emailController.text;
                                              context
                                                  .read<AuthProvider>()
                                                  .countryCode = value
                                                      .profileData
                                                      ?.countryCode ??
                                                  "354";
                                              context
                                                      .read<AuthProvider>()
                                                      .setFromType =
                                                  FromAuthType.fromProfile;
                                              context
                                                  .read<AuthProvider>()
                                                  .sendOtp(
                                                      context: context,
                                                      type: "email");
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                /*heightGap(10),
                              TextWidget(
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.w500,
                                text: AppLocalizations.of(context)!.password,
                              ),
                              heightGap(8),
                              TextFormFieldWidget(
                                hintText: AppLocalizations.of(context)!.enterPassword,
                                controller: passwordController,
                                validator: (value) => Validations.instance
                                    .passwordValidation(value!),
                              ),*/
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: ElevatedButtonWidget(
                        text: AppLocalizations.of(context)!.changeLanguage,
                        onPressed: () {
                          _showLanguageChooser(context);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    CommonFooterWidget(
                        cartItem: ElevatedButtonWidget(
                      text: AppLocalizations.of(context)!.update,
                      onPressed: value.buttonEnable
                          ? () async {
                              context.read<AuthProvider>().setEmail =
                                  value.emailController.text;
                              final update = await context
                                  .read<AuthProvider>()
                                  .updateProfile(
                                      context: context,
                                      mobile: value.phoneNumberController.text,
                                      name: value.nameController.text,
                                      countryCode: context
                                          .read<AuthProvider>()
                                          .countryCode,
                                      profileImage: context
                                          .read<AuthProvider>()
                                          .profileImageUrl,
                                      email: context
                                          .read<AuthProvider>()
                                          .getEmail);
                              if (update) {
                                if (context.mounted) {
                                  Navigator.of(context).pop();
                                }
                              }
                            }
                          : null,
                    )),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showLanguageChooser(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Consumer<LanguageProvider>(
            builder: (context, language, child) {
              return Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RadioListTile<String>(
                      title: const Text('English'),
                      value: 'en',
                      groupValue: language.lang,
                      onChanged: (String? value) {
                        setState(() {
                          language.lang = value!;
                          language.changeLanguage(Locale(value));
                        });
                        Navigator.pop(context);
                      },
                    ),
                    RadioListTile<String>(
                      title: const Text('Íslenska'),
                      value: 'is',
                      groupValue: language.lang,
                      onChanged: (String? value) {
                        setState(() {
                          language.lang = value!;
                          language.changeLanguage(Locale(value));
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        });
  }
}
