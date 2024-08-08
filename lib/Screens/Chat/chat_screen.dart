import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:taxi/CommonWidgets/custom_scaffold.dart';
import 'package:taxi/CommonWidgets/text_form_field_widget.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:taxi/Providers/BookRideProvider/book_ride_provider.dart';
import 'package:taxi/Providers/ChatProvider/chat_provider.dart';
import 'package:taxi/Remote/api_config.dart';
import 'package:taxi/Screens/Home/DriverArrive/driver_arriving_screen.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/app_images.dart';
import 'package:taxi/Widgets/common_footer_widget.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class ChatScreen extends StatefulWidget {
  static const routeName = "/chatScreen";
  final driverData, bookingData;

  const ChatScreen({this.driverData, this.bookingData, super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var args;

  var bookingData;

  @override
  void initState() {
    super.initState();
    context.read<ChatProvider>().initSocket(context);
    args = widget.driverData;
    bookingData = widget.bookingData;
  }

  @override
  void deactivate() {
    super.deactivate();
    currentRoute = DriverArrivingScreen.routeName;
    context.read<ChatProvider>().closeSocket();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.primary,
      statusBarColor: Colors.transparent,
      body: SafeArea(
        child: Consumer<ChatProvider>(
          builder: (context, value, child) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: AppColors.white),
                          ),
                          child: const Icon(
                            Icons.arrow_back_rounded,
                            color: AppColors.black,
                            size: 24,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                height: 42,
                                width: 42,
                                imageUrl: args != null
                                    ? "$IMAGE_URL${args['image'] ?? ''}"
                                    : '',
                                placeholder: (context, url) =>
                                    SvgPicture.asset(AppImages.personGrey),
                                errorWidget: (context, url, error) =>
                                    SvgPicture.asset(AppImages.personGrey),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(
                                  text: args != null ? args['name'] ?? '' : '',
                                  fontSize: 16,
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.w600,
                                ),
                                const TextWidget(
                                  text: 'Online',
                                  fontSize: 14,
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          final contact = args != null ? args['contact'] : null;
                          if (contact != null) {
                            makingPhoneCall(number: contact);
                          }
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.call,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListView.builder(
                        itemCount: messageList.length,
                        controller: value.scrollController,
                        itemBuilder: (context, index) {
                          final message = messageList[index];
                          final isSender = message.senderName == value.userName;
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: isSender ? 40.0 : 10.0,
                              vertical: 8.0,
                            ),
                            child: Column(
                              crossAxisAlignment: isSender
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: const Radius.circular(16),
                                      topRight: const Radius.circular(16),
                                      bottomLeft: isSender
                                          ? const Radius.circular(16)
                                          : const Radius.circular(0),
                                      bottomRight: isSender
                                          ? const Radius.circular(0)
                                          : const Radius.circular(16),
                                    ),
                                  ),
                                  color: isSender
                                      ? AppColors.primary
                                      : Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: TextWidget(
                                      text: message.message,
                                      fontSize: 14,
                                      color: AppColors.blackColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: isSender
                                      ? MainAxisAlignment.end
                                      : MainAxisAlignment.start,
                                  children: [
                                    if (!isSender) ...[
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          height: 28,
                                          width: 28,
                                          imageUrl:
                                              "$IMAGE_URL${args != null ? args['image'] ?? '' : ''}",
                                          placeholder: (context, url) =>
                                              SvgPicture.asset(
                                                  AppImages.personGrey),
                                          errorWidget: (context, url, error) =>
                                              SvgPicture.asset(
                                                  AppImages.personGrey),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextWidget(
                                            text: args != null
                                                ? args['name'] ?? ''
                                                : '',
                                            fontSize: 14,
                                            color: AppColors.blackColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          TextWidget(
                                            text: message.timestamp,
                                            fontSize: 12,
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ],
                                      ),
                                    ],
                                    if (isSender) ...[
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          TextWidget(
                                            text: message.senderName,
                                            fontSize: 14,
                                            color: AppColors.blackColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          TextWidget(
                                            text: message.timestamp,
                                            fontSize: 12,
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 4),
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          height: 28,
                                          width: 28,
                                          imageUrl: value.userImage.isNotEmpty
                                              ? "$IMAGE_URL${value.userImage}"
                                              : '',
                                          placeholder: (context, url) =>
                                              SvgPicture.asset(
                                                  AppImages.personGrey),
                                          errorWidget: (context, url, error) =>
                                              SvgPicture.asset(
                                                  AppImages.personGrey),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                CommonFooterWidget(
                  cartItem: Row(
                    children: [
                      Expanded(
                        child: TextFormFieldWidget(
                          controller: value.chatMessageController,
                          hintText: 'Type a message here...',
                          fillColor: AppColors.greyStatusBar,
                        ),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () {
                          value.sendMessageEvent(bookingData, args);
                        },
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.primary,
                          ),
                          child: const Icon(Icons.send),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  makingPhoneCall({required String number}) async {
    var url = Uri.parse("tel:$number");
    if (await url_launcher.canLaunchUrl(url)) {
      await url_launcher.launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
