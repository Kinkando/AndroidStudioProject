import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_food/pages/food/food_page.dart';
import 'package:flutter_food/pages/profile/profile_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _subPageIndex = 0;
  FoodPage? _currentPage = FoodPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: _buildAppBarTitle(),
        actions: [
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(40.0),
                      child: Container(
                        width: 80.0,
                        height: 80.0,
                        child: Image.asset('assets/images/profile.png'),
                      )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Text(
                      'Tanawat Yuwansiri',
                        style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  Text(
                    'TY_Sage@hotmail.com',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
            ),
            ListTile(
              title: _buildDrawerItem(
                  Icons.fastfood,
                  'Food', 0
              ),
              onTap: (){
                _showSubPage(context, 0);
              },
            ),
            ListTile(
              title: _buildDrawerItem(
                  Icons.person,
                  'Profile', 1
              ),
              onTap: () => _showSubPage(context, 1),
            ),
          ],
        ),
      ),
      body: _buildSubPage(),
    );
  }

  Text _buildAppBarTitle() {
    switch(_subPageIndex) {
      case 0 : return Text('Food');
      default : return Text('Profile');
    }
  }

  dynamic _buildSubPage() {
    switch(_subPageIndex) {
      case 0 :
        return _currentPage;
      default :
        return ProfilePage();
    }
  }

  void _showSubPage(BuildContext context, int page) {
    setState(() {
      _subPageIndex = page;
      _currentPage = page==0 ? FoodPage() : null;
    });
    Navigator.of(context).pop();
    //Navigator.of(context).pushNamed(LoginPage.routeName);
  }

  Row _buildDrawerItem(IconData icon, String title, int onFocus) {
    return Row(
      children: [
        Icon(icon, color: _subPageIndex==onFocus ? Colors.blue : null),
        SizedBox(width: 8.0),
        Text(
          title,
          style: _subPageIndex==onFocus
              ? Theme.of(context).textTheme.headline5
              : Theme.of(context).textTheme.bodyText2),
      ],
    );
  }
}
