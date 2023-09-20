import 'package:flutter/material.dart';

class TheData2 extends Object {}

//class TheDataFetcher {
//  Future<TheData> getData() {
//    return Future<TheData>.value(TheData());
//  }
//}

class PageMaker<T extends Object> {
  Widget makePage(T theData) {
    return Text('Yo de yoereo');
  }
}

class MyFutureBuilder {
  static buildFuture<T extends Object>(
      Future<T> Function() dataFetcher, PageMaker<T> pageMaker) {
    return FutureBuilder(
      future: dataFetcher(),
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          return pageMaker.makePage(snapshot.data!);
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
}
