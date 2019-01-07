import 'dart:async';
import 'models.dart';

class MyBloc {
  MyBloc() {
    this._getItems();
  }

  final StreamController<List<ModelItem>> _itemController = StreamController();
  get items => _itemController.stream;

  dispose() {
    _itemController.close();
  }

  _getItems() async {
    // the business logic goes here
    List<ModelItem> items = [
      ModelItem("one"),
      ModelItem("two"),
      ModelItem("three"),
      ModelItem("four"),
    ];
    // update the ui data
    _itemController.sink.add(items);
  }
}
