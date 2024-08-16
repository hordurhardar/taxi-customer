

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taxi/Models/get_booking_details.dart';
import 'package:taxi/Models/message_model.dart';
import 'package:taxi/Providers/BookRideProvider/book_ride_provider.dart';
import 'package:taxi/Utils/app_strings.dart';
import 'package:taxi/main.dart';

import '../../Models/get_driver_details_model.dart';

class ChatProvider with ChangeNotifier {


  TextEditingController chatMessageController = TextEditingController(text: "");
  String userName = "";
  String userImage = "";
  ScrollController scrollController = ScrollController();


  Future<void> initSocket(BuildContext context) async {
    userName = sharedPrefs?.getString(AppStrings.userName) ?? "";
    userImage = sharedPrefs?.getString(AppStrings.userImage) ?? "";
    print("Username is $userName");
    // socket = IO.io(
    //   socketUrl,
    //   IO.OptionBuilder().setTransports(['websocket']).setQuery(
    //       {'token': '${sharedPrefs?.getString(AppStrings.token)}'}).build(),
    // );
    // socket?.connect();
    // socket?.onConnect((data) {
    //   log('connected');
    // });
    receivedIncomingMessageEvent();
    //receivedMessageHistoryEvent();
    scrollToBottom();
  }


  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
   // notifyListeners();
  }
  Future<void> closeSocket() async {
    if (socket != null) {
      socket!.disconnect();
      socket!.dispose();
      socket!.close();
    }
  }

  void receivedIncomingMessageEvent() {
    socket?.on('receiveMessage', (data) async {
      log('receiveMessage event received: $data');
      scrollToBottom();
      notifyListeners();
    });
  }

  void sendMessageEvent(BookingData bookingData, DriverData driverData) {
    userName = sharedPrefs?.getString(AppStrings.userName) ?? "";
    userImage = sharedPrefs?.getString(AppStrings.userImage) ?? "";
    SendMessage sendMessage = SendMessage();
    sendMessage.bookingId  = bookingData.id;
    sendMessage.receiverId  = driverData.driverId;
    sendMessage.message  = chatMessageController.text;
    print(sendMessage.toJson());
    socket?.emit('sendMessage', sendMessage.toJson());
    DateTime dateTimeParsed = DateTime.now();
    String dateFormat = DateFormat('hh:mm a').format(dateTimeParsed);
    messageList.add(MessageModel(chatMessageController.text,userName ,dateFormat, dateTimeParsed));
    messageList.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    chatMessageController.clear();
    scrollToBottom();
    notifyListeners();
  }

  void receivedMessageHistoryEvent() {
    socket?.on('chatHistory', (data) async {
      log('chatHistory event received: $data');
      notifyListeners();
    });
  }



}

class SendMessage {
  String? bookingId;
  String? receiverId;
  String? message;
  String? type;

  Map<String, dynamic> toJson() {
    return {
      'bookingId': bookingId,
      'receiverId': receiverId,
      'message': message,
      'type': "TEXT",
      // Do not include functions in the JSON representation
    };
  }
}