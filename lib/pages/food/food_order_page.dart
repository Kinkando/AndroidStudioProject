import 'package:flutter/material.dart';

class OrderPage extends StatelessWidget {
  static const routeName = '/order';
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child : Text(
          'YOUR ORDER',
          style: Theme.of(context).textTheme.headline1
      ),
    );
  }
}
