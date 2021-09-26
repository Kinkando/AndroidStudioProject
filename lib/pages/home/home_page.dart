import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_food/pages/login/login_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _subPageIndex = 0;
  var _selectedBottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('FLUTTER FOOD'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.person,
                    size: 50.0,
                    color: Colors.white
                  ),
                  Text(
                    'Firstname Lastname',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    )
                  ),
                ],
              ),
            ),
            ListTile(
              title: _buildDrawerItem(Icon(Icons.home), 'Home'),
              onTap: (){
                _showSubPage(context, 0);
              },
            ),
            ListTile(
              title: _buildDrawerItem(Icon(Icons.person), 'Page 1'),
              onTap: () => _showSubPage(context, 1),
            ),
            ListTile(
              title: _buildDrawerItem(Icon(Icons.file_copy), 'Page 2'),
              onTap: () => _showSubPage(context, 2),
            ),
            ListTile(
              title: _buildDrawerItem(Icon(Icons.settings), 'Setting'),
              onTap: (){},
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'PAGE 1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'SETTINGS',
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
        child: _buildSubPage(),
      ),
    );
  }

  Widget _buildSubPage() {
    switch(_subPageIndex) {
      case 0 :
        return Center(
          child : Text(
              'THIS IS A HOME PAGE',
              style: Theme.of(context).textTheme.headline1
          ),
        );
        break;
      case 1 :
        return Center(
            child: Text(
                'PAGE 1',
                style: Theme.of(context).textTheme.headline1
            )
        );
      case 2 :
        return Center(
            child: Text(
                'PAGE 2',
                style: Theme.of(context).textTheme.headline1
            )
        );
      default :
        return SizedBox.shrink();
    }
  }

  void _showSubPage(BuildContext context, int page) {
    setState(() {
      _subPageIndex = page;
    });
    Navigator.of(context).pop();
    //Navigator.of(context).pushNamed(LoginPage.routeName);
  }

  Row _buildDrawerItem(Widget icon, String title) {
    return Row(
      children: [
        icon,
        SizedBox(width: 8.0),
        Text(title),
      ],
    );
  }
}
