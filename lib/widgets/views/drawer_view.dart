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

class DrawerView extends StatelessWidget {
  DrawerView({UserRepository userRepository}) {
    _userRepository = userRepository ?? UserRepository();
    load();
  }

  UserRepository _userRepository;
  User _thisUser;

  Future<void> load() async {
    _thisUser = await _userRepository.getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: isNull(_thisUser)
            ? signedOutWidgets(context)
            : signedInWidgets(context));
  }

  List<Widget> signedOutWidgets(BuildContext context) {
    return [
      UserAccountsDrawerHeader(
        decoration: BoxDecoration(color: AppColors.green),
        accountName: Text('Hello, Guest', style: AppTheme.titleWhite),
        accountEmail: Text('', style: AppTheme.subtitleWhite),
        currentAccountPicture: CircleAvatar(
            backgroundColor: Colors.yellow,
            child: Text('G', style: AppTheme.title)),
      ),
      DrawerItemView(
        iconData: Icons.home,
        text: 'Home',
        onItemPressed: () {
          closeDrawer(context);
        },
      ),
      Divider(),
    ];
  }

  List<Widget> signedInWidgets(BuildContext context) {
    return [
      UserAccountsDrawerHeader(
        decoration: BoxDecoration(color: AppColors.green),
        accountName:
            Text('Hello, ${_thisUser.name}', style: AppTheme.titleWhite),
        accountEmail: Text(_thisUser.emailId, style: AppTheme.subtitleWhite),
        currentAccountPicture: CircleAvatar(
            backgroundColor: AppColors.avatar_bg,
            child: Text(_thisUser.name.substring(0, 1).toUpperCase(),
                style: AppTheme.title)),
      ),
      DrawerItemView(
        iconData: Icons.home,
        text: 'Home',
        onItemPressed: () {
          Router.removeAllAndPush(context, MapScreen.routeName);
        },
      ),
      DrawerItemView(
        iconData: Icons.casino,
        text: 'My Bids',
        onItemPressed: () {
          Router.popAndPushNamed(context, MyBidsScreen.routeName);
        },
      ),
      Divider(),
      DrawerItemView(
        iconData: Icons.power_settings_new,
        text: 'Logout',
        onItemPressed: () {
          closeDrawer(context);
        },
      ),
    ];
  }

  void closeDrawer(BuildContext context) {
    Navigator.of(context).pop();
  }
}
