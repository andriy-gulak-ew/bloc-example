import 'package:flutter/material.dart';
import 'package:blocweb/application_utils.dart';
import 'package:blocweb/conversations/conversations.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Home Screen"),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildNavBarItem(icon: Icon(Icons.filter_1)),
            _buildNavBarItem(icon: Icon(Icons.filter_2)),
            _buildNavBarItem(icon: Icon(Icons.filter_3)),
            _buildNavBarItem(icon: Icon(Icons.filter_4)),
          ],
        ),
      ),
      body: SizedBox(
        width: isTablet(context) ? kTabletMasterContainerWidth : MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ConversationListing(),
      ),
    );
  }

  Widget _buildNavBarItem({@required Widget icon}) {
    return IconButton(
      icon: icon,
      onPressed: () {},
    );
  }
}
