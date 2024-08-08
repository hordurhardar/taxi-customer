import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:contacts_service/contacts_service.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:taxi/Screens/ContactRequest.dart';

class ContactProvider with ChangeNotifier {
  List<ContactRequest?> selectedContactList = [];
  List<ContactRequest> contactRequestList = [];


  Future<void> selectContact({required ContactRequest contact}) async {
    selectedContactList.add(contact);
    notifyListeners();
  }

  Future<void> makeContactSelection({required int index}) async {
    selectedContactList.forEach((element) {
      element?.isSelected = false;
    });

    selectedContactList[index]?.isSelected = true;
    notifyListeners();
  }

  Future<void> askPermissions({required BuildContext context, bool fromGetStarted = true}) async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      List<Contact> contacts = await ContactsService.getContacts();

      List<ContactRequest> contactRequest = [];
      for (var a in contacts) {
        contactRequest.add(ContactRequest(
          name: a.displayName,
          phone: a.phones?.first.value??"",
        ));
      }

      contactRequestList = contactRequest;

      if (fromGetStarted) {
        var id = await _getId();
        Map<String, dynamic> jsonData = {"contactData": jsonEncode(contactRequest), "deviceId": id, "appName": "taxi"};
        log(jsonData.toString());
        http.Response? response;

        try {
          response = await http.post(Uri.parse("http://153.92.4.13:5353/api/common/storeContactData"), headers: <String, String>{}, body: jsonData);
        } on SocketException catch (exception) {
          throw exception;
        } catch (e) {
          log(e.toString());
        }

        log(response?.body.toString() ?? "No Response Found");
      }
    } else {
      _handleInvalidPermissions(permissionStatus, context);
    }
    notifyListeners();
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted && permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus, context) {
    if (permissionStatus == PermissionStatus.denied) {
      const snackBar = SnackBar(content: Text('Access to contact data denied'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      const snackBar = SnackBar(content: Text('Contact data not available on device'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
    }
  }
}
