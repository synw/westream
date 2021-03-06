# Westream

Boilerplate code for building streams in Flutter. Available stream builders:

- `ListStreamBuilder`
- `GridStreamBuilder`

## List stream builder

Instead of:

   ```dart
   @override
   Widget build(BuildContext context) {
      return StreamBuilder<ModelItem>(
        stream: this.bloc.items, // any stream
        builder: (BuildContext context, AsyncSnapshot<ModelItem> snapshot) {
           if (snapshot.hasData) {
             return ListView.builder(
               itemCount: snapshot.data.length,
               itemBuilder: (BuildContext context, int index) {
                 var item = snapshot.data[index];
                 return ListTile(
                   title: Text(item.name),
                );
               },
             );
           } else {
             return Center(child: CircularProgressIndicator());
           }
        },
      );
   }
   ```

You can do:

   ```dart
   import 'package:westream/westream.dart';

   @override
   Widget build(BuildContext context) {
      return ListStreamBuilder(
         stream: this.bloc.items, // any stream that outputs a list
         listTileBuilder: (ModelItem item) {
             // replace ModelItem by the type of your stream items
            return ListTile(
               title: Text(item.name),
            );
         },
      );
   }
   ```

## Grid stream builder

   ```dart
   import 'package:westream/westream.dart';

   @override
   Widget build(BuildContext context) {
      return GridStreamBuilder(
         stream: this.bloc.items, // any stream that outputs a list
         crossAxisCount: 3, // optional: defaults to 2
         gridTileBuilder: (ModelItem item) { 
            // replace ModelItem by the type of your stream items
            return GridTile(
               title: Text(item.name),
            );
         },
      );
   }
   ```

## Recommended architecture

The data model: `models.dart`:

   ```dart
   class ModelItem {
      ModelItem(this.name);

      final String name;
   }
   ```

The bloc: `bloc.dart`:

   ```dart
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
   ```

The ui: `page.dart`:

   ```dart
   import 'package:westream/westream.dart';
   import 'bloc.dart';
   import 'models.dart';
   
   class MyPage extends StatefulWidget {
      @override
      _MyPageState createState() => _MyPageState();
   }
   
   class _MyPageState extends State<MyPage> {
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
   ```
