import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_food/pages/food/food_list_page.dart';

import 'food_item.dart';
import 'food_order_page.dart';

import 'package:http/http.dart' as http;

class FoodPage extends StatefulWidget {
  static const routeName = '/food';
  const FoodPage({Key? key}) : super(key: key);

  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  var _selectedBottomNavIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchFoods,
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Your Order',
          ),
        ],
        currentIndex: _selectedBottomNavIndex,
        onTap: (index) {
          setState(() {
            _selectedBottomNavIndex = index;
          });
        },
      ),
      body: Container(
        child: currentItem(),
      ),
    );
  }
  Widget currentItem() {
    switch(_selectedBottomNavIndex) {
      case 0 : return FoodListPage();
      default : return OrderPage();
    }
  }
  Future<void> _fetchFoods() async {
    var url = Uri.parse("https://cpsu-test-api.herokuapp.com/foods");
    var response = await http.get(url);  // asynchronous

    if(response.statusCode == 200) {  // similarity then (without await)
      Map<String, dynamic> jsonBody = json.decode(response.body);

      // JSON Object {} -> Map (Dart)
      // JSON Array [] -> List (Dart)

      String status = jsonBody['status'];
      String? message = jsonBody['message'];
      List<dynamic> data = jsonBody['data'];
      print('STATUS: $status');
      print('MESSAGE: $message');
      //print('data: $data');

      var items = data.map((element) => FoodItem(
                    id: element['id'],
                    name: element['name'],
                    price: element['price'],
                    image: element['image'],
                  )).toList();    //Map from List of map to List of FoodItem

      /*data.forEach((element) {
        FoodItem(
          id: element['id'],
          name: element['name'],
          price: element['price'],
          image: element['image'],
        );
      });*/
    }



    //var futureResponse = http.get(url);  // asynchronous
    // futureResponse.then((response) => null);
    //futureResponse.then(_handleResponse);   // Run after because wait for response from request to url server (JSON API)

    //print('Run Before');  // (without await) Run before because it will add to queue first and fetch to loop event before
  }

  /*void _handleResponse(http.Response response) {
    // with await then wait for fetch and then add //print('Run Before');
    if(response.statusCode == 200) { // success
      //print(response.body);
      print("Run After");
    }
  }*/
}