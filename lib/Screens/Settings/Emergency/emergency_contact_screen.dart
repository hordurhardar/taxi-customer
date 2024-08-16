import 'package:flutter/material.dart';
import 'package:taxi/CommonWidgets/custom_scaffold.dart';
import 'package:taxi/CommonWidgets/elevated_button_widget.dart';
import 'package:taxi/CommonWidgets/text_form_field_widget.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/app_images.dart';
import 'package:taxi/Utils/helper_methods.dart';
import 'package:taxi/Widgets/common_footer_widget.dart';
import 'package:taxi/Widgets/list_tile_card_widget.dart';
import 'package:taxi/Widgets/toolbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmergencyContactScreen extends StatefulWidget {
  static const routeName = "/emergencyContactScreen_screen";

  const EmergencyContactScreen({super.key});

  @override
  State<EmergencyContactScreen> createState() => _EmergencyContactScreenState();
}

class _EmergencyContactScreenState extends State<EmergencyContactScreen> {
  final List<String> _texts = [
    "Robert Alexander  (Father)",
    "Jane Alexander (Mother)",
    "Arlene McCoy (Friends)",
    "Joshua Doe (Friends)",
  ];

  List<bool>? _isChecked;

  @override
  void initState() {
    _isChecked = List<bool>.filled(_texts.length, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          heightGap(16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Toolbar(
              title: 'Emergency Contact',
            ),
          ),
          heightGap(30),
          Expanded(
            child: Column(
              children: [
                CheckboxListTile(
                  value: false,
                  title: const TextWidget(
                    text: 'Select All',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black,
                  ),
                  onChanged: (value) {},
                  checkColor: AppColors.black,
                  activeColor: AppColors.primary,
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _texts.length,
                    itemBuilder: (context, index) {
                      return CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        secondary: const Icon(
                          Icons.close_rounded,
                          color: AppColors.primary,
                        ),
                        title: Text(_texts[index]),
                        checkColor: AppColors.black,
                        activeColor: AppColors.primary,
                        value: _isChecked?[index],
                        onChanged: (val) {
                          setState(
                            () {
                              _isChecked?[index] = val!;
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          CommonFooterWidget(
              cartItem: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButtonWidget(
                onPressed: () {},
                text: 'Send Alert',
              ),
              heightGap(10),
              Center(
                  child: InkWell(
                      onTap: () {
                        bottomSheet(context: context, content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Center(
                              child: Container(
                                width: 100,
                                height: 3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppColors.greyBorder,
                                ),
                              ),
                            ),

                            heightGap(20),
                            Center(
                              child: TextWidget(
                                text: AppLocalizations.of(context)!.bookingCancelledSuccessfully,
                                fontSize: 20,
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            heightGap(20),
                            Container(decoration: BoxDecoration(border: Border.all(color: AppColors.greyBorder),borderRadius: BorderRadius.circular(8)),child: const ListTileCardWidget(height: 48,elevation: 0,title: 'Select Contacts',icon: AppImages.personYellow,arrowColor: AppColors.primary,)),
                            heightGap(20),
                            const TextWidget(
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.w500,
                              text: 'Relationship',
                            ),
                            const TextFormFieldWidget(
                              hintText: 'Enter here',
                            ),
                            heightGap(20),
                            ElevatedButtonWidget(
                              onPressed: () {},
                              text: 'Got it',
                            ),
                          ],
                        ),);
                      },
                      child: const TextWidget(
                        text: 'Add New Content',
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary,
                      ))),
            ],
          )),
        ],
      ),
    );
  }
}
