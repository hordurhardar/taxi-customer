import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxi/CommonWidgets/custom_scaffold.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:taxi/Utils/app_colors.dart';

import '../../Models/content_response.dart';
import '../../Providers/HelpCenterProvider/help_center_provider.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  @override
  void initState() {
    context.read<HelpCenterProvider>().getContentApi(context: context, slug: "faq");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Consumer<HelpCenterProvider>(
        builder: (context, value, child) {
          return value.isLoading
              ? const Center(
                  child: CupertinoActivityIndicator(),
                )
              : ListView.builder(
                  itemCount: value.content?[0].faq?.length,
                  itemBuilder: (context, index) {
                    Faq? faq = value.content?[0].faq?[index];
                    return Card(
                      child: ExpansionTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        childrenPadding: const EdgeInsets.all(8),
                        iconColor: AppColors.primary,
                        collapsedIconColor: AppColors.primary,
                        title: TextWidget(
                          text: faq?.question ?? "",
                          fontSize: 14,
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w500,
                        ),
                        children: [
                          TextWidget(
                            text: faq?.question ?? "",
                            fontSize: 14,
                            color: AppColors.greyText,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    );
                  });
        },
      ),
    );
  }
}
