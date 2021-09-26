import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  static const routeName = '/profile';
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(120.0),
              child: Container(
                width: 240.0,
                height: 240.0,
                child: Image.asset('assets/images/profile.png'),
              )
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Text(
              'Tanawat Yuwansiri',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          Text(
            'TY_Sage@hotmail.com',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }
}
