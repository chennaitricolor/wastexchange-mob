import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/models/user.dart';
import 'package:wastexchange_mobile/resources/user_repository.dart';
import 'package:wastexchange_mobile/routes/router.dart';
import 'package:wastexchange_mobile/screens/my_bids_screen.dart';
import 'package:wastexchange_mobile/utils/app_colors.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';
import 'package:wastexchange_mobile/utils/global_utils.dart';
import 'package:wastexchange_mobile/widgets/views/ThoughtWorksLogoPowered.dart';
import 'package:wastexchange_mobile/widgets/views/drawer_item_view.dart';

// TODO(Sayeed): Should this be a stateless widget?
class DrawerView extends StatelessWidget {
  // TODO(Sayeed): Add bloc for drawer view
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
    final user = isLoggedIn() ? thisUser() : guestUser();
    final name = isNull(user) ? 'Guest' : user.name;
    final emailId = isNull(user) ? '' : user.emailId;
    return Column(
      children: <Widget>[
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(color: AppColors.green),
          accountName: Text('Hello, $name', style: AppTheme.titleWhite),
          accountEmail: Text(emailId, style: AppTheme.subtitleWhite),
          currentAccountPicture: CircleAvatar(
              backgroundColor: AppColors.avatar_bg,
              child: Text(name.substring(0, 1).toUpperCase(),
                  style: AppTheme.title)),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                DrawerItemView(
                  iconData: Icons.home,
                  text: 'Home',
                  onItemPressed: () {
                    Router.removeAllAndPopToHome(context);
                  },
                ),
                DrawerItemView(
                  visibility: isLoggedIn(),
                  iconData: Icons.casino,
                  text: 'Current Orders',
                  onItemPressed: () {
                    Router.popAndPushNamed(context, MyBidsScreen.routeName);
                  },
                ),
                const Divider(),
                DrawerItemView(
                  visibility: isLoggedIn(),
                  iconData: Icons.power_settings_new,
                  text: 'Logout',
                  onItemPressed: () {
                    logoutUser();
                    Router.removeAllAndPopToHome(context);
                  },
                ),
              ],
            ),
          ),
        ),
        ThoughtWorksLogoPowered()
      ],
    );
  }

  void closeDrawer(BuildContext context) {
    Navigator.of(context).pop();
  }
}
