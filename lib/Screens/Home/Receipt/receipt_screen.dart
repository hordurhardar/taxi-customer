import 'dart:io';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:taxi/CommonWidgets/custom_scaffold.dart';
import 'package:taxi/CommonWidgets/elevated_button_widget.dart';
import 'package:taxi/Providers/BookRideProvider/book_ride_provider.dart';
import 'package:taxi/Providers/DriverProvider/driver_provider.dart';
import 'package:taxi/Providers/ProfileProvider/profile_provider.dart';
import 'package:taxi/Screens/Home/Rate/rate_driver_screen.dart';
import 'package:taxi/Utils/app_images.dart';
import 'package:taxi/Utils/helper_methods.dart';
import 'package:taxi/Widgets/common_footer_widget.dart';
import 'package:taxi/Widgets/raw_item_widget.dart';
import 'package:taxi/Widgets/svg_picture.dart';
import 'package:taxi/Widgets/toolbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ReceiptScreen extends StatelessWidget {
  static const routeName = "/receipt_screen";

  const ReceiptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        body: Consumer3<DriverProvider, BookRideProvider, ProfileProvider>(
      builder: (context, value, bookRideValue, profileValue, child) {
        if (bookRideValue.bookingList.isNotEmpty) {
          return Column(
            children: [
              heightGap(16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Toolbar(
                  title: AppLocalizations.of(context)!.eReceipt,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SvgPic(image: AppImages.barCode),
                        RawItemWidget(
                            title: AppLocalizations.of(context)!.bookingId,
                            value: bookRideValue.bookingList.first.id ?? ""),
                        const Divider(height: 40),
                        RawItemWidget(
                            title: AppLocalizations.of(context)!.driver,
                            value: value.driverData?.name ?? ""),
                        RawItemWidget(
                            title: AppLocalizations.of(context)!.carNumber,
                            value:
                                value.driverData?.carDetails?.carNumber ?? ""),
                        RawItemWidget(
                            title: AppLocalizations.of(context)!.carModel,
                            value:
                                value.driverData?.carDetails?.carModel ?? ""),
                        RawItemWidget(
                            title: AppLocalizations.of(context)!.carColor,
                            value:
                                value.driverData?.carDetails?.carColor ?? ""),
                        const Divider(height: 40),
                        RawItemWidget(
                            title: AppLocalizations.of(context)!.costPerMile,
                            value:
                                'kr ${bookRideValue.bookingList.first.perMileAmount}'),
                        // RawItemWidget(
                        //     title: AppLocalizations.of(context)!.estimatedMile,
                        //     value:
                        //         '${bookRideValue.bookingList.first.perMileAmount}'),
                        heightGap(20),
                        const DottedLine(),
                        heightGap(20),
                        RawItemWidget(
                            title: AppLocalizations.of(context)!.total,
                            value:
                                'kr ${bookRideValue.bookingList.first.totalAmount}'),
                        const Divider(height: 40),
                        RawItemWidget(
                            title: AppLocalizations.of(context)!.name,
                            value: profileValue.profileData?.name ?? ''),
                        RawItemWidget(
                            title: AppLocalizations.of(context)!.phoneNumber,
                            value:
                                profileValue.profileData?.mobileNumber ?? ''),
                        RawItemWidget(
                            title: AppLocalizations.of(context)!.transactionId,
                            value: '${bookRideValue.bookingList.first.id}'),
                      ],
                    ),
                  ),
                ),
              ),
              CommonFooterWidget(
                  cartItem: ElevatedButtonWidget(
                onPressed: () async {
                  Navigator.of(context).pushNamed(RateDriverScreen.routeName);

                  if (Platform.isAndroid) {
                    var status = await Permission.storage.status;
                    if (status != PermissionStatus.granted) {
                      status = await Permission.storage.request();
                    }
                    if (status.isGranted) {
                      const downloadsFolderPath =
                          '/storage/emulated/0/Download/';
                      Directory dir = Directory(downloadsFolderPath);
                      final pdf = pw.Document();
                      pdf.addPage(pw.Page(
                          pageFormat: PdfPageFormat.a4,
                          build: (pw.Context context) {
                            return pw.Table(
                              children: [
                                pw.TableRow(children: [
                                  pw.Column(children: [
                                    rowItem(
                                        title: "Booking ID",
                                        value:
                                            "${bookRideValue.bookingList.first.id}"),
                                    pw.Divider(thickness: 1),
                                    pw.SizedBox(height: 10),
                                    rowItem(
                                        title: "Driver",
                                        value: "${value.driverData?.name}"),
                                    rowItem(
                                        title: "Car Number",
                                        value:
                                            "${value.driverData?.carDetails?.carNumber}"),
                                    rowItem(
                                        title: "Car Model",
                                        value:
                                            "${value.driverData?.carDetails?.carModel}"),
                                    rowItem(
                                        title: "Car Color",
                                        value:
                                            "${value.driverData?.carDetails?.carColor}"),
                                    pw.Divider(thickness: 1),
                                    pw.SizedBox(height: 10),
                                    rowItem(
                                        title: "Cost Per Mile",
                                        value:
                                            "kr ${bookRideValue.bookingList.first.perMileAmount}"),
                                    // rowItem(
                                    //     title: "Estimated Mile", value: "${bookRideValue.bookingList.first.id}"),
                                    pw.Divider(thickness: 1),
                                    pw.SizedBox(height: 10),
                                    rowItem(
                                        title: "Total",
                                        value:
                                            "kr ${bookRideValue.bookingList.first.totalAmount}"),
                                    pw.Divider(thickness: 1),
                                    pw.SizedBox(height: 10),
                                    rowItem(
                                        title: "Name",
                                        value: profileValue.profileData?.name ??
                                            ''),
                                    rowItem(
                                        title: "Phone Number",
                                        value: profileValue
                                                .profileData?.mobileNumber ??
                                            ''),
                                    rowItem(
                                        title: "Transaction Id",
                                        value: bookRideValue
                                                .bookingList.first.id ??
                                            ''),
                                  ]),
                                ]),
                              ],
                            ); // Center
                          }));
                      File file = File('${dir.path}/receipt.pdf');
                      await file.writeAsBytes(await pdf.save());
                    }
                  }
                },
                text: AppLocalizations.of(context)!.downloadReceipt,
              )),
            ],
          );
        } else {
          return Container();
        }
      },
    ));
  }

  pw.Row rowItem({
    required String title,
    required String value,
  }) {
    return pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            title,
          ),
          pw.Text(
            value,
          ),
        ]);
  }
}
