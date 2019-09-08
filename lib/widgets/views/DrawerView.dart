import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/utils/app_colors.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';
import 'package:wastexchange_mobile/widgets/views/drawer_item_view.dart';

class DrawerView extends StatelessWidget {
  const DrawerView(
      {@required this.name, @required this.email, @required this.avatorText})
      : assert(name != null, 'Name should not be empty'),
        assert(email != null, 'Email should not be empty'),
        assert(avatorText != null,
            'At least one character should be passed for circle avator');

  final String name;
  final String email;
  final String avatorText;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(color: AppColors.green),
          accountName: Text(name ?? '', style: AppTheme.titleWhite),
          accountEmail: Text(email ?? '', style: AppTheme.subtitleWhite),
          currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.yellow,
              child: Text(avatorText ?? '', style: AppTheme.title)),
        ),
        DrawerItemView(
          iconData: Icons.home,
          text: 'Home',
          onItemPressed: () {
            closeDrawer(context);
          },
        ),
        DrawerItemView(
          iconData: Icons.casino,
          text: 'My Bids',
          onItemPressed: () {
            closeDrawer(context);
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
      ],
    );
  }

  void closeDrawer(BuildContext context) {
    Navigator.of(context).pop();
  }
}
