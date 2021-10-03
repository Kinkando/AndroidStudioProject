import 'package:flutter/material.dart';
import 'package:flutter_food/pages/food/food_details_page.dart';
import 'package:flutter_food/pages/food/food_list_page.dart';
import 'package:flutter_food/pages/food/food_order_page.dart';
import 'package:flutter_food/pages/food/food_page.dart';
import 'package:flutter_food/pages/login/login_page.dart';
import 'package:flutter_food/pages/profile/profile_page.dart';

import 'pages/home/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,

        textTheme: const TextTheme(
          headline1: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
          headline5: TextStyle(
            fontSize: 14.0,
            color: Colors.blue,
          ),
          headline6: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
          bodyText1: TextStyle(fontSize: 20.0),
          bodyText2: TextStyle(fontSize: 14.0),
        ),
      ),
      //home: MyHomePage(title: 'Flutter Demo Home Page'),
      //home: LoginPage(),
      routes: {   // {  ... : ... } => map { key : value }
        LoginPage.routeName: _test,  //ใช้แทน (context) => const LoginPage(), ได้ เมื่อต้องมีการ calculate ก่อนที่จะเปลี่ยน page
        HomePage.routeName: (context) => const HomePage(),    //ใช้ /login ในการ navigate แทนชื่อ class (ตั้งชื่อเป็นอะไรก็ได้ แต่ส่วนใหญ่ตั้งเป็น path)
        /*FoodPage.routeName: (context) => const FoodPage(),
        FoodListPage.routeName: (context) => const FoodListPage(),
        OrderPage.routeName: (context) => const OrderPage(),
        ProfilePage.routeName: (context) => const ProfilePage(),*/
        FoodDetailsPage.routeName: (context) => const FoodDetailsPage(),
      },
      initialRoute: LoginPage.routeName, //หน้าเริ่มต้น
    );
  }

  Widget _test(BuildContext context) {
    return const LoginPage();
  }
}