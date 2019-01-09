import 'dart:async';
import 'package:flutter/material.dart';

class GridStreamBuilder extends StatelessWidget {
  GridStreamBuilder(
      {Key key,
      @required this.gridTileBuilder,
      @required this.stream,
      this.crossAxisCount = 2})
      : super(key: key);

  final Function gridTileBuilder;
  final Stream stream;
  int crossAxisCount;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<dynamic>(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return GridView.builder(
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: this.crossAxisCount),
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              var item = snapshot.data[index];
              return gridTileBuilder(item);
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
