import 'package:flutter/material.dart';
import 'tabs/ircommandslisttab.dart';

class IrCommandsPage extends StatefulWidget {
  @override
  State<IrCommandsPage> createState() => _IrCommandsPageState();
}

class _IrCommandsPageState extends State<IrCommandsPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Commands'),
                Tab(icon: Icon(Icons.directions_transit)),
                Tab(icon: Icon(Icons.directions_bike)),
              ],
            ),
            title: const Text('IR Commands'),
          ),
          body: TabBarView(
            children: [
              IrCommandsListTab.getWidgets(),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    );
  }
}
