import 'package:flutter/material.dart';
import '../../ircommandsdata.dart';

class IrControllerStatusTabView extends StatefulWidget {
  @override
  State<IrControllerStatusTabView> createState() =>
      _IrControllerStatusTabView();
}

class _IrControllerStatusTabView extends State<IrControllerStatusTabView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: IrCommandsData().loadIrCommandsData(),
      builder: (BuildContext context, AsyncSnapshot<IrCommandsData> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          return makePage(snapshot.data!);
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

  Widget makePage(IrCommandsData irCommandsData) {
    var ipAddress = IrCommandsData.ipAddress;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('now then'),
      Text('ip address: $ipAddress'),
    ]);
  }
}
