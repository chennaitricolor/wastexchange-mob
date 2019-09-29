import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/models/user.dart';
import 'package:wastexchange_mobile/resources/user_repository.dart';
import 'package:wastexchange_mobile/routes/router.dart';
import 'package:wastexchange_mobile/screens/map_screen.dart';
import 'package:wastexchange_mobile/screens/my_bids_screen.dart';
import 'package:wastexchange_mobile/utils/app_colors.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';
import 'package:wastexchange_mobile/utils/global_utils.dart';
import 'package:wastexchange_mobile/widgets/views/drawer_item_view.dart';

// TODO(Sayeed): Should this be a stateless widget?
class DrawerView extends StatelessWidget {
  DrawerView({UserRepository userRepository}) {
    _userRepository = userRepository ?? UserRepository();
    _getThisUserProfile();
  }

  UserRepository _userRepository;
  User _thisUser;

  Future<void> _getThisUserProfile() async {
    _thisUser = await _userRepository.getProfile();
  }

  void logoutUser() {
    _userRepository.logoutUser();
  }

  bool isLoggedIn() => _thisUser != null;

  User thisUser() => _thisUser;

  User guestUser() => User(name: 'Guest', emailId: '');

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: isLoggedIn()
            ? signedInWidgets(context)
            : signedOutWidgets(context));
  }

// TODO(Sayeed): Is this the correct convention to have functions returning widgets and using them in build method.
  List<Widget> signedOutWidgets(BuildContext context) {
    return [
      _userAccountsDrawerHeader(user: guestUser()),
      _homeDrawerItem(context),
      const Divider(),
    ];
  }

  List<Widget> signedInWidgets(BuildContext context) {
    return [
      _userAccountsDrawerHeader(user: thisUser()),
      _homeDrawerItem(context),
      DrawerItemView(
        iconData: Icons.casino,
        text: 'My Bids',
        onItemPressed: () {
          Router.popAndPushNamed(context, MyBidsScreen.routeName);
        },
      ),
      const Divider(),
      DrawerItemView(
        iconData: Icons.power_settings_new,
        text: 'Logout',
        onItemPressed: () {
          logoutUser();
          Router.removeAllAndPopToHome(context);
        },
      ),
    ];
  }

  Widget _userAccountsDrawerHeader({@required User user}) {
    final name = isNull(user) ? 'Guest' : user.name;
    final emailId = isNull(user) ? '' : user.emailId;
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(color: AppColors.green),
      accountName: Text('Hello, $name', style: AppTheme.titleWhite),
      accountEmail: Text(emailId, style: AppTheme.subtitleWhite),
      currentAccountPicture: CircleAvatar(
          backgroundColor: AppColors.avatar_bg,
          child:
              Text(name.substring(0, 1).toUpperCase(), style: AppTheme.title)),
    );
  }

  Widget _homeDrawerItem(BuildContext context) {
    return DrawerItemView(
      iconData: Icons.home,
      text: 'Home',
      onItemPressed: () {
        Router.removeAllAndPush(context, MapScreen.routeName);
      },
    );
  }

  void closeDrawer(BuildContext context) {
    Navigator.of(context).pop();
  }
}
