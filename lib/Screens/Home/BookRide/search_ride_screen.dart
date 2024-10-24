import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxi/CommonWidgets/custom_scaffold.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:taxi/Providers/BookRideProvider/book_ride_provider.dart';
import 'package:taxi/Screens/Home/Driver/driver_details_screen.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/app_images.dart';
import 'package:taxi/Utils/app_strings.dart';
import 'package:taxi/Utils/constants.dart';
import 'package:taxi/Utils/helper_methods.dart';
import 'package:taxi/Widgets/google_map_widget.dart';
import 'package:taxi/Widgets/svg_picture.dart';
import 'package:taxi/Widgets/toolbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:taxi/main.dart';

import '../../../CommonWidgets/elevated_button_widget.dart';

class SearchRideScreen extends StatefulWidget {
  static const routeName = "/searchRide_screen";

  // final String? bookingId;

  const SearchRideScreen({
    super.key,
    // required this.bookingId,
  });

  @override
  State<SearchRideScreen> createState() => _SearchRideScreenState();
}

class _SearchRideScreenState extends State<SearchRideScreen> {
  IO.Socket? socket;
  final GlobalKey<NavigatorState> _key = GlobalKey<NavigatorState>();
  late Timer _timer;
  int _start = 60;

  Future<void> initSocket() async {
    await context.read<BookRideProvider>().getAllDriverApi(
          context: context,
        );
    socket = IO.io(
      socketUrl,
      IO.OptionBuilder().setTransports(['websocket']).setQuery({
        'token': '${sharedPrefs?.getString(AppStrings.token)}'
      }).build(), // for Flutter or Dart VM
    );

    socket?.connect();

    socket?.on('receiveStatusUpdate', (data) async {
      log('acceptRide event received: $data');
      await context.read<BookRideProvider>().receivedStatusUpdate(
          value: data, context: context, callDriverDetailsApi: true);

      log("data========>${data}");
    });
    socket?.onConnect((data) {
      log('connected');
    });
    socket?.onDisconnect((_) => log('disconnect'));
  }

  @override
  void initState() {
    log(sharedPrefs?.getString(AppStrings.token) ?? "", name: "TOKEN");
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await initSocket();
      startTimer();
    });
    super.initState();
  }

  @override
  void dispose() {
    socket?.disconnect();
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
          showDialog(
            context: context,
            builder: (BuildContext context) => const TimerCompleteDialog(),
          );
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: CustomScaffold(
          key: _key,
          extendBodyBehindAppBar: true,
          statusBarColor: Colors.transparent,
          body: Consumer<BookRideProvider>(builder: (context, value, child) {
            return Stack(
              children: [
                GoogleMapWidget(
                  markers: value.markers,
                ),
                Container(
                  decoration:
                      BoxDecoration(color: AppColors.white.withOpacity(0.5)),
                  child: SafeArea(
                    child: Column(
                      children: [
                        heightGap(16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Toolbar(
                            showBack: true,
                            title: AppLocalizations.of(context)!.bookRide,
                          ),
                        ),
                        Expanded(
                            child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                              color: AppColors.white.withOpacity(0.1)),
                          child: Column(
                            children: [
                              heightGap(40),
                              Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                        padding: const EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                            color: AppColors.white,
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: AppColors.black
                                                      .withOpacity(0.1),
                                                  blurRadius: 5,
                                                  spreadRadius: 3)
                                            ]),
                                        child: const SvgPic(
                                            image: AppImages.onlyCar)),
                                  ),
                                  const Align(
                                    alignment: Alignment.center,
                                    child: SizedBox(
                                        height: 81,
                                        width: 80,
                                        child: CircularProgressIndicator(
                                            strokeWidth: 3,
                                            color: AppColors.primary)),
                                  ),
                                ],
                              ),
                              heightGap(10),
                              TextWidget(
                                text:
                                    AppLocalizations.of(context)!.searchingRide,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                              TextWidget(
                                text: AppLocalizations.of(context)!
                                    .thisTakeFewSeconds,
                                fontWeight: FontWeight.w500,
                                color: AppColors.greyHint,
                              ),
                              heightGap(10),
                            ],
                          ),
                        )),
                        ElevatedButtonWidget(
                          onPressed: () {
                            // showCancelDialog(context, widget.bookingId ?? '');
                            Navigator.pop(context);
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             DriverDetailsScreen()));
                            // change navigator here
                          },
                          text: AppLocalizations.of(context)!.cancelReq,
                        ),
                        heightGap(20)
                      ],
                    ),
                  ),
                )
              ],
            );
          })),
    );
  }
}

class TimerCompleteDialog extends StatelessWidget {
  const TimerCompleteDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.pleaseTryAgain),
      content: Text(AppLocalizations.of(context)!.noDriversAvailable),
      actions: <Widget>[
        ElevatedButtonWidget(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          text: AppLocalizations.of(context)!.close,
        ),
      ],
    );
  }
}
