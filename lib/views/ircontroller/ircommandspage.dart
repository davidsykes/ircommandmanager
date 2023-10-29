import 'package:flutter/material.dart';
import '../../globalvariables.dart';
import 'tabs/ircommandstab/ircommandslisttabview.dart';
import 'tabs/statustab/ircontrollerstatustabview.dart';

class IrCommandsPage extends StatefulWidget {
  final GlobalVariables globalVariables;
  const IrCommandsPage(this.globalVariables, {super.key});

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
                Tab(text: 'Status'),
                Tab(text: 'Commands'),
                Tab(icon: Icon(Icons.directions_bike)),
              ],
            ),
            title: const Text('IR Controller'),
          ),
          body: TabBarView(
            children: [
              IrControllerStatusTabView(),
              IrCommandsListTabView(widget.globalVariables),
              Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    );
  }
}
