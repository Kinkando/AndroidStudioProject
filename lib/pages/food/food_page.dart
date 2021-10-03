import 'package:flutter/material.dart';
import 'package:flutter_food/pages/food/food_list_page.dart';

import 'food_order_page.dart';

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
}