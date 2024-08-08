import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:taxi/Models/common_model.dart';
import 'package:taxi/Models/get_notification_model.dart';
import 'package:taxi/Remote/api_config.dart';
import 'package:taxi/Remote/remote_service.dart';
import 'package:taxi/Utils/helper_methods.dart';


class NotificationProvider with ChangeNotifier {
  bool isLoading = false;
  int currentPagination = 1;
  GetNotificationModel getNotificaionModel = GetNotificationModel();
  List<NotificationListDocs> notificationList = [];
  Future<void> getNotificationApi({
    required BuildContext context,
  }) async {
    isLoading = true;

    final data = await RemoteService().callGetApi( context: context,
      url: '$tNotification?page=$currentPagination',
    );
    if (data == null) {
      isLoading = false;
      return;
    }
    final notificationResponse =
    GetNotificationModel.fromJson(jsonDecode(data.body));
    if (context.mounted) {
      if (notificationResponse.status == 200) {
        getNotificaionModel = notificationResponse;
        if(currentPagination==1){
          notificationList.clear();
        }
        notificationList.addAll(notificationResponse.data?.docs  ?? []);
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        showSnackBar(
            context: context,
            message: notificationResponse.message,
            isSuccess: false);
      }
    }
    notifyListeners();
  }

  Future<void> deleteNotificationApi({
    required BuildContext context,
    required String id,
    required int index,
  }) async {
    showLoaderDialog(context);
    final data = await RemoteService().callDeleteApi(
      url: '$tDeleteNotification?notificationId=$id',
    );
    if (data == null) {
      hideLoader(context);
      return;
    }
    final deleteNotificationResponse = CommonModel.fromJson(jsonDecode(data.body));
    if (context.mounted) {
      if (deleteNotificationResponse.status == 200) {
        hideLoader(context);
        showSnackBar(
            context: context,
            message: deleteNotificationResponse.message,
            isSuccess: true);
        notificationList.removeAt(index);
      } else {
        showSnackBar(
            context: context,
            message: deleteNotificationResponse.message,
            isSuccess: false);
        hideLoader(context);
      }
    }
    notifyListeners();
  }


  Future<void> readNotificationApi({
    required BuildContext context,
    required String id,
    required int index,
  }) async {
    showLoaderDialog(context);
    final data = await RemoteService().callDeleteApi(
      url: '$tReadNotification?notificationId=$id',
    );
    if (data == null) {
      hideLoader(context);
      return;
    }
    final readNotificationResponse = CommonModel.fromJson(jsonDecode(data.body));
    if (context.mounted) {
      if (readNotificationResponse.status == 200) {
        hideLoader(context);
        showSnackBar(
            context: context,
            message: readNotificationResponse.message,
            isSuccess: true);
        notificationList[index].isRead = true;
      } else {
        showSnackBar(
            context: context,
            message: readNotificationResponse.message,
            isSuccess: false);
        hideLoader(context);
      }
    }
    notifyListeners();
  }
}
