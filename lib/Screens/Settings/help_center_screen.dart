import 'package:flutter/material.dart';
import 'package:taxi/CommonWidgets/custom_scaffold.dart';
import 'package:taxi/CommonWidgets/text_form_field_widget.dart';
import 'package:taxi/CommonWidgets/text_widget.dart';
import 'package:taxi/Screens/Settings/contact_us_screen.dart';
import 'package:taxi/Screens/Settings/faq_screen.dart';
import 'package:taxi/Utils/app_colors.dart';
import 'package:taxi/Utils/app_fonts.dart';
import 'package:taxi/Utils/helper_methods.dart';
import 'package:taxi/Widgets/svg_picture.dart';
import 'package:taxi/Widgets/toolbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HelpCenterScreen extends StatefulWidget {
  static const routeName = "/helpCenter_screen";

  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late TabController _tabController;
  int categoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                pinned: false,automaticallyImplyLeading: false,
                expandedHeight: 140.0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Column(
                    children: [
                      heightGap(16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Toolbar(
                          title: AppLocalizations.of(context)!.helpCenter,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          TextFormFieldWidget(hintText: 'Enter',),
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
                        text: AppLocalizations.of(context)!.faq,
                        height: 48,
                      ),
                      Tab(
                        text: AppLocalizations.of(context)!.contactUs,
                        height: 48,
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: const TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [FaqScreen(), ContactUsScreen()],
          ),
        ),
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
