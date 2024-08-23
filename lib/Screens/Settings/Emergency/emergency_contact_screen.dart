import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxi/CommonWidgets/custom_scaffold.dart';
import 'package:taxi/CommonWidgets/elevated_button_widget.dart';
import 'package:taxi/CommonWidgets/text_form_field_widget.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:taxi/Providers/contact_provider.dart';
import 'package:taxi/Screens/contact_request.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/app_images.dart';
import 'package:taxi/Utils/helper_methods.dart';
import 'package:taxi/Widgets/common_footer_widget.dart';
import 'package:taxi/Widgets/contact_sheet_widget.dart';
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
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      context.read<ContactProvider>().selectEmergencyContact(null);
      context
          .read<ContactProvider>()
          .getContactListFromPhone(context: context, fromGetStarted: false);
      context.read<ContactProvider>().fetchEmergencyContacts(context);
    });
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
          Consumer<ContactProvider>(builder: (context, provider, _) {
            return Expanded(
              child: Column(
                children: [
                  if (provider.emergencyContacts.isNotEmpty)
                    CheckboxListTile(
                      value: provider.emergencyContacts.every(
                        (e) => e.isSelected,
                      ), //_isChecked?.every((e) => e == true),
                      title: const TextWidget(
                        text: 'Select All',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                      onChanged: (value) {
                        provider.onSelectAllChanged(value ?? false);
                      },
                      checkColor: AppColors.black,
                      activeColor: AppColors.primary,
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  Expanded(
                    child: provider.emergencyContacts.isEmpty
                        ? const Center(
                            child: TextWidget(text: 'Not added any contact.'),
                          )
                        : ListView.builder(
                            itemCount: provider.emergencyContacts.length,
                            itemBuilder: (context, index) {
                              final contact = provider.emergencyContacts[index];
                              return CheckboxListTile(
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                secondary: IconButton(
                                  onPressed: () {
                                    provider.removeEmergencyContact(contact);
                                  },
                                  icon: const Icon(
                                    CupertinoIcons.clear_circled,
                                    color: AppColors.primary,
                                  ),
                                ),
                                title: Text(contact.name ?? ''),
                                subtitle: contact.relation == null ||
                                        (contact.relation?.isEmpty ?? false)
                                    ? null
                                    : Text(contact.relation!),
                                checkColor: AppColors.black,
                                activeColor: AppColors.primary,
                                value: contact.isSelected,
                                onChanged: (value) {
                                  provider.onEmergencyContactSelectionChanged(
                                    value ?? false,
                                    index,
                                  );
                                },
                              );
                            },
                          ),
                  ),
                ],
              ),
            );
          }),
          CommonFooterWidget(
              cartItem: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButtonWidget(
                onPressed: () {
                  context.read<ContactProvider>().sendEmergencyAlert();
                },
                text: 'Send Alert',
              ),
              heightGap(10),
              TextButton(
                onPressed: _showAddContactSheet,
                child: const TextWidget(
                  text: 'Add New Content',
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }

  _showAddContactSheet() {
    final TextEditingController relationController = TextEditingController();

    return bottomSheet(
      context: context,
      content: Consumer<ContactProvider>(builder: (context, provider, _) {
        return Column(
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
            const Center(
              child: TextWidget(
                text: 'Add emergency contact',
                fontSize: 20,
                color: AppColors.blackColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            heightGap(20),
            ListTileCardWidget(
              onTap: () {
                _showContactBottomSheet(context);
              },
              height: 48,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: const BorderSide(color: AppColors.greyBorder),
              ),
              titleText:
                  provider.selectedEmergencyContact?.name ?? 'Select Contacts',
              leadingIconPath: AppImages.personYellow,
              arrowColor: AppColors.primary,
            ),
            heightGap(20),
            const TextWidget(
              color: AppColors.blackColor,
              fontWeight: FontWeight.w500,
              text: 'Relationship',
            ),
            TextFormFieldWidget(
              controller: relationController,
              hintText: 'Enter here',
            ),
            heightGap(20),
            ElevatedButtonWidget(
              onPressed: () {
                provider.addRelationForEmergencyContact(
                  relationController.text,
                );
                provider.addEmergencyContact(
                  onNotSelected: (msg) {
                    showSnackBar(
                        context: context, isSuccess: false, message: msg);
                  },
                );
                Navigator.of(context).pop();
              },
              text: 'Got it',
            ),
          ],
        );
      }),
    );
  }

  Future<void> _showContactBottomSheet(
    BuildContext context,
  ) async {
    return await showContactListSheet(
      context: context,
      onSelect: (ContactRequest contact) {
        context.read<ContactProvider>().selectEmergencyContact(contact);
        Navigator.of(context).pop();
      },
    );
  }
}
