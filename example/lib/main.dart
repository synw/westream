import 'package:flutter/material.dart';
import 'package:westream/westream.dart';
import 'bloc.dart';
import 'models.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Westream Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final MyBloc bloc = MyBloc();

  @override
  dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListStreamBuilder(
      stream: bloc.items,
      listTileBuilder: (ModelItem item) {
        return ListTile(
          title: Text(item.name),
        );
      },
    ));
  }
}
