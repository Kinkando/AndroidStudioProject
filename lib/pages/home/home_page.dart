import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('FLUTTER FOOD'),
      ),
      body: Container(
        child: Center(
          child : Text(
              'THIS IS A HOME PAGE',
              style: Theme.of(context).textTheme.headline1
          ),
        )
        /*child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    'THIS IS A HOME PAGE',
                    style: Theme.of(context).textTheme.headline1
                  ),
                ),
              )
            ],
          ),
        ),*/
      ),
    );
  }
}
