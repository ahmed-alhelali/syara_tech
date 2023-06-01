import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:sayara_tech_app/app/pages/logged_in_pages/home_page.dart';
import 'package:sayara_tech_app/app/pages/logged_in_pages/my_booking_page.dart';
import 'package:sayara_tech_app/app/pages/logged_in_pages/my_cars_page.dart';
import 'package:sayara_tech_app/app/pages/logged_in_pages/my_profile_page.dart';

class NavigationBarPage extends ConsumerWidget {
  const NavigationBarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PersistentTabView(
      context,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(0.0),
        colorBehindNavBar: Colors.black,
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      bottomScreenMargin: 48,
      navBarStyle: NavBarStyle.style12,
      margin: const EdgeInsets.symmetric(horizontal: 0),
      navBarHeight: 48,
    );
    // return Scaffold(
    //   body: Center(
    //     child: IconButton(
    //       onPressed: () {
    //         ref.watch(userTokenNotifierProvider.notifier).removeTheUserToken();
    //       },
    //       icon: const Icon(
    //         Icons.refresh,
    //         color: Colors.red,
    //       ),
    //     ),
    //   ),
    // );
  }
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: const Icon(
        FontAwesomeIcons.house,
        size: 18,
      ),
      title: ("Home"),
      activeColorPrimary: const Color(0xff02CDBA),
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(
        FontAwesomeIcons.receipt,
        size: 18,
      ),
      title: ("Booking"),
      activeColorPrimary: const Color(0xff02CDBA),
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(
        FontAwesomeIcons.car,
        size: 18,
      ),
      title: ("Cars"),
      activeColorPrimary: const Color(0xff02CDBA),
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(
        FontAwesomeIcons.solidUser,
        size: 18,
      ),
      title: ("Profile"),
      activeColorPrimary: const Color(0xff02CDBA),
      inactiveColorPrimary: Colors.grey,
    ),
  ];
}

List<Widget> _buildScreens() {
  return [
    const HomePage(),
    const MyBookingPage(),
    const MyCarsPage(),
    const MyProfilePage(),
  ];
}
