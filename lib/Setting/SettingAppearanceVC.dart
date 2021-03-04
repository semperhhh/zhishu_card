import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zhishu_card/Tools/ColorUtil.dart';
import 'package:zhishu_card/Tools/Global.dart';
import 'package:zhishu_card/Tools/ThemeModel.dart';

class SettingAppearanceVC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget _buildListItem(String name, value) {
      return ListTile(
        title: Text(name),
        trailing: Provider.of<ThemeModel>(context).themeMode == value
            ? Icon(
                Icons.done,
                color: ColorUtil.main_app,
              )
            : null,
        onTap: () {
          Provider.of<ThemeModel>(context, listen: false).theme = value;
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "外观",
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: ListView(
        children: <Widget>[
          _buildListItem("浅色", ThemeMode.light),
          _buildListItem("深色", ThemeMode.dark),
          _buildListItem("跟随系统", ThemeMode.system)
        ],
      ),
    );
  }
}
