import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:taxi/CommonWidgets/custom_scaffold.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:taxi/Providers/DriverProvider/driver_provider.dart';
import 'package:taxi/Remote/api_config.dart';
import 'package:taxi/Screens/Home/Driver/Widgets/driver_about_widget.dart';
import 'package:taxi/Screens/Home/Driver/Widgets/driver_review_widget.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/app_fonts.dart';
import 'package:taxi/Utils/app_images.dart';
import 'package:taxi/Utils/helper_methods.dart';
import 'package:taxi/Widgets/svg_picture.dart';
import 'package:taxi/Widgets/toolbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DriverDetailsScreen extends StatefulWidget {
  static const routeName = "/driverDetailsScreen";

  final String? driverId;

  const DriverDetailsScreen({
    super.key,
    this.driverId,
  });

  @override
  State<DriverDetailsScreen> createState() => _DriverDetailsScreenState();
}

class _DriverDetailsScreenState extends State<DriverDetailsScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late TabController _tabController;
  int categoryIndex = 0;

  @override
  void initState() {
    //TODO: Make dynamic the driver id here
    context
        .read<DriverProvider>()
        .getDriverDetailApi(context: context, driverId: widget.driverId ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Consumer<DriverProvider>(
        builder: (context, value, child) {
          return DefaultTabController(
            length: 2,
            child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    pinned: false,
                    automaticallyImplyLeading: false,
                    expandedHeight: 322.0,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Column(
                        children: [
                          heightGap(16),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Toolbar(
                              title:
                                  AppLocalizations.of(context)!.driverDetails,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        height: 80,
                                        width: 80,
                                        imageUrl:
                                            "$IMAGE_URL${value.driverData != null ? value.driverData?.image : "https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg"}",
                                        placeholder: (context, url) {
                                          return SvgPicture.asset(
                                              AppImages.personGrey);
                                        },
                                        errorWidget: (context, url, error) {
                                          return SvgPicture.asset(
                                              AppImages.personGrey);
                                        },
                                      ),
                                    ),
                                    widthGap(10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextWidget(
                                          text: value.driverData?.name ?? '',
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.black,
                                        ),
                                        TextWidget(
                                          text: value.driverData?.email ?? '',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.greyText,
                                        ),
                                        Row(
                                          children: [
                                            const SvgPic(
                                              image: AppImages.locationYellow,
                                              height: 12,
                                              width: 12,
                                              fit: BoxFit.contain,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            TextWidget(
                                              text: value.driverData?.address ??
                                                  '',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.greyText,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const Divider(
                                  height: 40,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    circleItem(
                                        title: AppLocalizations.of(context)!
                                            .customer,
                                        value: value
                                                .driverData?.totalCustomerRide
                                                .toString() ??
                                            '0',
                                        icon: AppImages.personYellow),
                                    circleItem(
                                        title: AppLocalizations.of(context)!
                                            .yearsExp,
                                        value:
                                            '${value.driverData?.totalExp.toString() ?? '0'} +',
                                        icon: AppImages.beg),
                                    circleItem(
                                        title: AppLocalizations.of(context)!
                                            .rating,
                                        value:
                                            '${value.driverData?.avgRating.toString() ?? '0.0'} +',
                                        icon: AppImages.star),
                                    circleItem(
                                        title: AppLocalizations.of(context)!
                                            .review,
                                        value:
                                            '${value.driverData?.totalReview.toString() ?? '0.0'} +',
                                        icon: AppImages.messageYellow),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      stretchModes: const [StretchMode.blurBackground],
                    ),
                    //collapsedHeight: 100,
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _SliverAppBarDelegate(
                      TabBar(
                        isScrollable: false,
                        unselectedLabelColor: AppColors.blackColor,
                        indicatorColor: AppColors.primary,
                        indicatorSize: TabBarIndicatorSize.tab,
                        overlayColor:
                            WidgetStateProperty.all<Color?>(Colors.transparent),
                        labelStyle: const TextStyle(
                            fontFamily: AppFonts.inter,
                            color: AppColors.primary,
                            fontSize: 17,
                            fontWeight: FontWeight.w500),
                        tabs: [
                          Tab(
                            text: AppLocalizations.of(context)!.about,
                            height: 48,
                          ),
                          Tab(
                            text: AppLocalizations.of(context)!.review,
                            height: 48,
                          ),
                        ],
                      ),
                    ),
                  ),
                ];
              },
              body: const TabBarView(
                children: [
                  DriverAboutWidget(),
                  DriverReviewWidget(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget circleItem(
      {required String title, required String value, required String icon}) {
    return Column(
      children: [
        Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: AppColors.greyStatusBar),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SvgPic(image: icon),
            )),
        TextWidget(
          text: value,
          fontSize: 17,
          fontWeight: FontWeight.w500,
          color: AppColors.primary,
        ),
        TextWidget(
          text: title,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.greyText,
        ),
      ],
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Material(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
