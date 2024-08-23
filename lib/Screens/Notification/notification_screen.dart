import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxi/CommonWidgets/custom_scaffold.dart';
import 'package:taxi/CommonWidgets/elevated_button_widget.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:taxi/Providers/NotificationProvider/notification_provider.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/helper_methods.dart';
import 'package:taxi/Widgets/toolbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationScreen extends StatefulWidget {
  static const routeName = "/notification_screen";

  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    context
        .read<NotificationProvider>()
        .getNotificationApi(context: context)
        .then((value) {
      addscrollListener();
    });
    super.initState();
  }

  ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Consumer<NotificationProvider>(
        builder: (context, value, child) {
          return value.isLoading
              ? const Center(
                  child: CupertinoActivityIndicator(),
                )
              : Column(
                  children: [
                    heightGap(16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Toolbar(
                        title: AppLocalizations.of(context)!.notification,
                        showCount:
                            value.notificationList.isEmpty ? false : true,
                      ),
                    ),
                    //TODO: add list here
                    RefreshIndicator(
                      color: AppColors.black,
                      backgroundColor: AppColors.primary,
                      onRefresh: () async {
                        value.currentPagination = 1;
                        value.getNotificationApi(context: context);
                      },
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: value.notificationList.isEmpty
                              ? Center(
                                  child: noDataWidget(),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: value.notificationList.length,
                                  itemBuilder: (context, index) {
                                    final notification =
                                        value.notificationList[index];
                                    return Dismissible(
                                      key: UniqueKey(),
                                      background: Container(
                                        color: Colors.red,
                                        alignment: Alignment.centerRight,
                                        margin:
                                            const EdgeInsets.only(bottom: 15),
                                        padding:
                                            const EdgeInsets.only(right: 20.0),
                                        // Background color when swiping
                                        child: const Icon(Icons.delete,
                                            color: Colors.white),
                                      ),
                                      confirmDismiss:
                                          (DismissDirection direction) async {
                                        return await showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text("Confirm"),
                                              content: const Text(
                                                  "Are you sure you wish to delete this item?"),
                                              actions: <Widget>[
                                                ElevatedButtonWidget(
                                                  onPressed: () {
                                                    return Navigator.of(context)
                                                        .pop(false);
                                                  },
                                                  text: 'CANCEL',
                                                ),
                                                ElevatedButtonWidget(
                                                    onPressed: () {
                                                      return Navigator.of(
                                                        context,
                                                      ).pop(true);
                                                    },
                                                    text: 'DELETE'),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      onDismissed: (direction) {
                                        //TODO: add id here
                                        context
                                            .read<NotificationProvider>()
                                            .deleteNotificationApi(
                                                context: context,
                                                id: notification.id.toString(),
                                                index: index);
                                      },
                                      child: InkWell(
                                        onTap: () {
                                          //TODO: add id here
                                          context
                                              .read<NotificationProvider>()
                                              .readNotificationApi(
                                                  context: context,
                                                  id: notification.id
                                                      .toString(),
                                                  index: index);
                                        },
                                        child: Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 60,
                                                  height: 60,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                      color: AppColors
                                                          .greyStatusBar),
                                                  child: const Icon(
                                                      Icons.perm_camera_mic),
                                                ),
                                                widthGap(10),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      TextWidget(
                                                        text: notification
                                                                .title ??
                                                            '',
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: AppColors.black,
                                                      ),
                                                      TextWidget(
                                                        text: notification
                                                                .message ??
                                                            '',
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            AppColors.greyText,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const TextWidget(
                                                  text: '1h',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.greyText,
                                                ),
                                              ],
                                            ),
                                            const Divider(),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                        ),
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }

  void addscrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        log("inside listner - if condition", name: "notification_sreen");
        if ((context.read<NotificationProvider>().currentPagination) <
            (context
                    .read<NotificationProvider>()
                    .getNotificaionModel
                    .data
                    ?.totalPages ??
                1)) {
          context.read<NotificationProvider>().currentPagination++;
          context
              .read<NotificationProvider>()
              .getNotificationApi(context: context);
        }
      }
    });
  }
}
