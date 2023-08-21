import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../ircommands/ircommandsdata.dart';
import '../myappstate.dart';

class IrCommandsPage extends StatefulWidget {
  @override
  State<IrCommandsPage> createState() => _IrCommandsPageState();
}

class _IrCommandsPageState extends State<IrCommandsPage> {
  var loadIrCommandsFuture = loadIrCommands();

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
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
              createIrCommandsWidget(),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    );
  }

  Widget createIrCommandsWidget() {
    return FutureBuilder(
      future: loadIrCommandsFuture,
      builder: (BuildContext context, AsyncSnapshot<IrCommandsData> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          children = makeTraceViewPage(snapshot.data!);
        } else if (snapshot.hasError) {
          children = <Widget>[
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('Error: ${snapshot.error}'),
            ),
          ];
        } else {
          children = const <Widget>[
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text('Awaiting result...'),
            ),
          ];
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: children,
          ),
        );
      },
    );
  }

  static Future<IrCommandsData> loadIrCommands() async {
    return Future.delayed(
      const Duration(seconds: 2),
      () => IrCommandsData(),
    );
  }

  List<Widget> makeTraceViewPage(IrCommandsData irCommandsData) {
    return [
      Tab(text: 'Commands'),
      Tab(icon: Icon(Icons.directions_transit)),
      Tab(icon: Icon(Icons.directions_bike)),
    ];
  }
}
