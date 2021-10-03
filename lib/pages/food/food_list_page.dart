import 'package:flutter/material.dart';
import 'package:flutter_food/pages/food/food_details_page.dart';

import 'food_item.dart';

class FoodListPage extends StatefulWidget {
  static const routeName = '/food_list';
  const FoodListPage({Key? key}) : super(key: key);

  @override
  _FoodListPageState createState() => _FoodListPageState();
}

class _FoodListPageState extends State<FoodListPage> {
  //final items = List<String>.generate(1000, (index) => 'Item $index');
  var items = [
    FoodItem(
        id: 1,
        name: "ข้าวไข่เจียว",
        price: 25,
        image: 'kao_kai_jeaw.jpg',
    ),
    FoodItem(
        id: 2,
        name: "ข้าวหมูแดง",
        price: 30,
        image: 'kao_moo_dang.jpg',
    ),
    FoodItem(
        id: 3,
        name: "ข้าวมันไก่",
        price: 30,
        image: 'kao_mun_kai.jpg',
    ),
    FoodItem(
        id: 4,
        name: "ข้าวหน้าเป็ด",
        price: 40,
        image: 'kao_na_ped.jpg',
    ),
    FoodItem(
      id: 5,
      name: "ข้าวผัด",
      price: 30,
      image: 'kao_pad.jpg',
    ),
    FoodItem(
        id: 6,
        name: "ผัดซีอิ๊ว",
        price: 30,
        image: 'pad_sie_eew.jpg',
    ),
    FoodItem(
        id: 7,
        name: "ผัดไทย",
        price: 35,
        image: 'pad_thai.jpg',
    ),
    FoodItem(
        id: 8,
        name: "ราดหน้า",
        price: 30,
        image: 'rad_na.jpg',
    ),
    FoodItem(
        id: 9,
        name: "ส้มตำไก่ย่าง",
        price: 80,
        image: 'som_tum_kai_yang.jpg',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          //Map<String, dynamic> item = items[index];
          var item = items[index];
          return Card(
            margin: const EdgeInsets.all(10.0), // const for once create in first time of 1000 loops
            child: InkWell(
              onTap: () {
                print(item.toString());
                Navigator.pushNamed(
                  context,
                  FoodDetailsPage.routeName, //FoodDetails,
                  arguments: item,
                );
              },
              child: Row(
                children: [
                  Image.asset(
                    //'assets/images/${item["image"]}',
                    'assets/images/${item.image}',
                    width: 76.0,
                    height: 76.0,
                    fit: BoxFit.cover),
                  SizedBox(width: 8.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        //item["name"] as String,
                        item.name,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(
                        item.price.toString()+" บาท",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
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
