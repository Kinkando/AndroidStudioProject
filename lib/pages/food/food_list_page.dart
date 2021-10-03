import 'package:flutter/material.dart';

class FoodListPage extends StatefulWidget {
  const FoodListPage({Key? key}) : super(key: key);

  @override
  _FoodListPageState createState() => _FoodListPageState();
}

class _FoodListPageState extends State<FoodListPage> {
  final items = List<String>.generate(1000, (index) => 'Item $index');
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return Text(
            '${items[index]}',
            style: TextStyle(fontSize: 20.0),
          );
        },
      ),
    );
  }
}
