import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:taxi/Remote/api_config.dart';
import 'package:taxi/Remote/remote_service.dart';
import 'package:taxi/Screens/contact_request.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactProvider with ChangeNotifier {
  List<ContactRequest?> selectedContactList = [];
  List<ContactRequest> contactRequestList = [];

  List<ContactRequest> _emergencyContacts = [];
  List<ContactRequest> _selectedContactsToSendAlert = [];
  ContactRequest? _selectedEmergencyContact;

  List<ContactRequest> get emergencyContacts => _emergencyContacts;
  List<ContactRequest> get selectedContactsToSendAlert =>
      _selectedContactsToSendAlert;
  ContactRequest? get selectedEmergencyContact => _selectedEmergencyContact;

  Future<void> fetchEmergencyContacts(BuildContext context) async {
    final response = await RemoteService().callGetApi(
      context: context,
      url: tFetchemergencyContact,
    );
    log('fetch emergency resp => ${response?.body}');
  }

  Future<void> removeEmergencyContact(ContactRequest contact) async {
    _emergencyContacts.remove(contact);
    notifyListeners();
  }

  Future<void> addEmergencyContact({Function(String)? onNotSelected}) async {
    if (_selectedEmergencyContact == null) {
      onNotSelected?.call('Please select a valid contact.');
      return;
    }
    _emergencyContacts.add(_selectedEmergencyContact!);
    selectEmergencyContact(null);
    notifyListeners();
  }

  void selectEmergencyContact(ContactRequest? contact) {
    _selectedEmergencyContact = contact;
    notifyListeners();
  }

  void addRelationForEmergencyContact(String relation) {
    _selectedEmergencyContact?.setRelation = relation;
    notifyListeners();
  }

  void onSelectAllChanged(bool newValue) {
    for (ContactRequest contact in _emergencyContacts) {
      contact.setSelected = newValue;
    }
    notifyListeners();
  }

  void onEmergencyContactSelectionChanged(bool value, int index) {
    _emergencyContacts[index].setSelected = value;
    notifyListeners();
  }

  Future<void> sendEmergencyAlert() async {
    for (ContactRequest contact in _emergencyContacts) {
      if (!contact.isSelected) continue;

      log('sending alert to ${contact.name}');

      String message =
          "Hey ${contact.name ?? contact.relation ?? ''}, *I'm in emergency right now.* Need your help.";

      String url =
          'https://wa.me/${contact.phone}?text=${Uri.encodeComponent(message)}';

      final launched = await launchUrl(Uri.parse(url));

      log('sent alert to ${contact.name} => $launched');

      if (!launched) {
        throw 'Could not launch $url';
      }
    }
  }

  Future<void> makeContactSelection({required int index}) async {
    selectedContactList.forEach((element) {
      element?.isSelected = false;
    });
    selectedContactList[index]?.isSelected = true;
    notifyListeners();
  }

  Future<void> selectContact({required ContactRequest contact}) async {
    selectedContactList.add(contact);
    notifyListeners();
  }

  Future<void> getContactListFromPhone({
    required BuildContext context,
    bool fromGetStarted = true,
  }) async {
    bool permissionGranted = await FlutterContacts.requestPermission();

    if (permissionGranted) {
      List<Contact> contacts = await FlutterContacts.getContacts(
        withProperties: true,
        withPhoto: false,
      );

      List<ContactRequest> contactRequest = [];

      for (var contact in contacts) {
        if (contact.phones.isNotEmpty) {
          contactRequest.add(ContactRequest(
            name: contact.displayName,
            phone: contact.phones.first.number ?? "",
          ));
        }
      }

      contactRequestList = contactRequest;

      if (fromGetStarted) {
        var id = await _getId();
        Map<String, dynamic> jsonData = {
          "contactData": jsonEncode(contactRequest),
          "deviceId": id,
          "appName": "taxi"
        };
        log(jsonData.toString());
        http.Response? response;

        try {
          response = await http.post(
            Uri.parse("http://153.92.4.13:5353/api/common/storeContactData"),
            headers: <String, String>{},
            body: jsonData,
          );
          log("response========>${response.body}");
        } on SocketException catch (exception) {
          throw exception;
        } catch (e) {
          log(e.toString());
        }

        log(response?.body.toString() ?? "No Response Found");
      }
    } else {
      _handleInvalidPermissions(context);
    }
    notifyListeners();
  }

  void _handleInvalidPermissions(BuildContext context) {
    const snackBar = SnackBar(content: Text('Access to contact data denied'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
