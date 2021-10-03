import 'package:flutter/material.dart';

class FoodListPages extends StatefulWidget {
  const FoodListPages({Key? key}) : super(key: key);

  @override
  _FoodListPageState createState() => _FoodListPageState();
}

class _FoodListPageState extends State<FoodListPages> {
  //final items = List<String>.generate(1000, (index) => 'Item $index');
  var items = [
    {
      "id" : 1,
      "name" : "ข้าวไข่เจียว",
      "price" : 25,
      "image" : 2
    },
    {

    }
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: const EdgeInsets.all(8.0), // const for once create in first time of 1000 loops
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/profile.png',
                    width: 60.0,
                    height: 60.0),
                  SizedBox(width: 8.0),
                  Text(
                    '${items[index]}',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
