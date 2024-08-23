import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:taxi/Providers/contact_provider.dart';
import 'package:taxi/Screens/contact_request.dart';

class ContactSheetWidget extends StatelessWidget {
  final Function(ContactRequest)? onSelect;

  const ContactSheetWidget({super.key, this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Consumer<ContactProvider>(
      builder: (context, value, child) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: value.contactRequestList.length,
          itemBuilder: (context, index) {
            final ContactRequest contact = value.contactRequestList[index];
            return InkWell(
              onTap: () {
                onSelect?.call(contact);
              },
              child: SizedBox(
                height: 60,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextWidget(text: contact.name ?? ''),
                        ),
                        TextWidget(text: contact.phone ?? ''),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
