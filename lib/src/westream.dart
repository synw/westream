import 'dart:async';
import 'package:flutter/material.dart';

class ListStreamBuilder extends StatelessWidget {
  ListStreamBuilder(
      {Key key, @required this.listTileBuilder, @required this.stream})
      : super(key: key);

  final Function listTileBuilder;
  final Stream stream;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<dynamic>(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              var item = snapshot.data[index];
              return listTileBuilder(item);
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
    ;
  }
}
