import 'package:flutter/material.dart';
import 'package:flutter_food/models/food_item.dart';

class FoodDetailsPage extends StatefulWidget {
  static const routeName = '/food_details';

  const FoodDetailsPage({Key? key}) : super(key: key);

  @override
  _FoodDetailsPageState createState() => _FoodDetailsPageState();
}

class _FoodDetailsPageState extends State<FoodDetailsPage> {
  @override
  Widget build(BuildContext context) {
    var item = ModalRoute.of(context)!.settings.arguments as FoodItem;
    return Scaffold(
      appBar: AppBar(
        title: Text(item.name),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 3 / 2,
              child: Image.asset(
                'assets/images/${item.image}',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'ชื่อเมนู: ${item.name}',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    'ราคา: ${item.price.toString()} บาท',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),


      /*body: Container(
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  child: Image.asset('assets/images/${item.image}'),
                  fit: BoxFit.fill,
                ),
                SizedBox(height: 20.0),
                Row(
                  children: [
                    SizedBox(
                      width: 20.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ชื่อเมนู: ${item.name}',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text(
                          'ราคา: ${item.price} บาท',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),*/
    );
  }
}
