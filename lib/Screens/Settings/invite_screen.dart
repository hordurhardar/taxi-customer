import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:taxi/CommonWidgets/custom_scaffold.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Widgets/toolbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:url_launcher/url_launcher.dart';

class InviteScreen extends StatefulWidget {
  static const routeName = "/invite_screen";

  const InviteScreen({super.key});

  @override
  InviteScreenState createState() => InviteScreenState();
}

class InviteScreenState extends State<InviteScreen> {
  List<Contact>? _contacts;
  String appLink =
      'https://play.google.com/store/apps/details?id=com.taxi.taxi247&pli=1';

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  Future<void> _fetchContacts() async {
    bool permissionGranted = await Permission.contacts.request().isGranted;

    if (permissionGranted) {
      List<Contact> contacts =
          await FlutterContacts.getContacts(withProperties: true);

      setState(() {
        _contacts = contacts;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Permission required to access contacts.'),
      ));
    }
  }

  Future<void> _shareAppLink(Contact contact) async {
    String phoneNumber =
        contact.phones.isNotEmpty ? contact.phones.first.number : '';
    String message =
        'Hey ${contact.displayName ?? 'Friend'}, check out this taxi booking app:\n$appLink';

    String url =
        'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}';

    final launched = await launchUrl(Uri.parse(url));

    if (!launched) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Toolbar(
              title: AppLocalizations.of(context)!.inviteFriends,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: _contacts != null
                  ? ListView.builder(
                      itemCount: _contacts!.length,
                      itemBuilder: (context, index) {
                        Contact contact = _contacts![index];
                        return InkWell(
                          onTap: () async {
                            await _shareAppLink(contact);
                            log("Shared App Link");
                          },
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 48,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: AppColors.primary,
                                    ),
                                    child: contact.photo != null &&
                                            contact.photo!.isNotEmpty
                                        ? CircleAvatar(
                                            backgroundImage:
                                                MemoryImage(contact.photo!),
                                          )
                                        : const Icon(Icons.person,
                                            color: Colors.white),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextWidget(
                                          text: contact.displayName ?? '',
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.black,
                                        ),
                                        contact.phones.isNotEmpty
                                            ? TextWidget(
                                                text: contact
                                                        .phones.first.number ??
                                                    '',
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.greyHint,
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    child: Container(
                                      height: 38,
                                      width: 70,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: AppColors.primary,
                                      ),
                                      child: const Center(
                                        child: TextWidget(
                                          text: 'Invite',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(),
                            ],
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
