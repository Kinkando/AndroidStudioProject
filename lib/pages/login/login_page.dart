import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_food/pages/home/home_page.dart';
import 'package:flutter_food/service/api.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  static const routeName = '/login';
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static const _pinLength = 6;
  var _input = '';
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              /*stops: [
                0.0,
                0.95,
                1.0,
              ],*/
              colors: [
                Colors.white,
                //Color(0xFFD8D8D8),
                //Color(0xFFAAAAAA),
                Theme.of(context).colorScheme.background.withOpacity(0.5),
                //Theme.of(context).colorScheme.background.withOpacity(0.6),
                //Colors.white,
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.lock_outline,
                            size: 90.0,
                            color: Theme.of(context).textTheme.headline1?.color,
                          ),
                          Text(
                            'LOGIN',
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          SizedBox(height: 6.0),
                          Text(
                            'Enter PIN to login',
                            style: Theme.of(context).textTheme.bodyText2,
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (var i = 0; i < _input.length; i++)
                            Container(
                              margin: EdgeInsets.all(4.0),
                              width: 24.0,
                              height: 24.0,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  shape: BoxShape.circle),
                            ),
                          for (var i = _input.length; i < 6; i++)
                            Container(
                              margin: EdgeInsets.all(4.0),
                              width: 24.0,
                              height: 24.0,
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      )
                    ],
                  ),
                ),
                _buildNumPad(),
              ],
            ),
          ),
        ),
        if (_isLoading)
          Container(
            color: Colors.black.withOpacity(0.5),
            child: Center(
              child: SizedBox(
                width: 200.0,
                height: 200.0,
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNumPad() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          [1, 2, 3],
          [4, 5, 6],
          [7, 8, 9],
          [-2, 0, -1],
        ].map((row) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: row.map((item) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: LoginButton(
                  number: item,
                  onClick: () {
                    _handleClickButton(item);
                  },
                ),
              );
            }).toList(),
          );
        }).toList(),
      ),
    );
  }

 /* Future<void> _fetchPIN() async {
    var url = Uri.parse("https://cpsu-test-api.herokuapp.com/login");
    var response = await http.post(url, body: {   // post, send data to API
      'pin': input
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonBody = json.decode(response.body);
      String status = jsonBody['status'];
      String? message = jsonBody['message'];
      bool checkPIN = jsonBody['data'];
      print(status);
      print(message);
      print(checkPIN);
      setState(() {
        if (checkPIN) {
          *//*Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );*//*
          Navigator.pushReplacementNamed(context, HomePage.routeName);
        } else {
          _showMaterialDialog('ERROR', 'Invalid PIN. Please try again.');
        }

        input = '';
      });
    }
  }*/

  Future<bool?> _login(String pin) async {
    try {
      setState(() {
        _isLoading = true;
      });
      var isLogin = (await Api().submit('login', {'pin': pin})) as bool;
      print('LOGIN: $isLogin');
      return isLogin;
    } catch (e) {
      print(e);
      _showMaterialDialog('ERROR', e.toString());
      return null;
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _handleClickButton(int num) async {
    //print('You pressed $num');

    setState(() {
      if (num == -1) {
        if (_input.length > 0) _input = _input.substring(0, _input.length - 1);
      } else {
        _input = '$_input$num';
      }
    });

    if (_input.length == _pinLength) {
      // _fetchPIN();
      var isLogin = await _login(_input);

      if (isLogin == null) return;

      if (isLogin) {
        Navigator.pushReplacementNamed(context, HomePage.routeName);
      } else {
        setState(() {
          _input = '';
        });
        _showMaterialDialog('LOGIN FAILED', 'Invalid PIN. Please try again.');
      }
    }
  }

  void _showMaterialDialog(String title, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(msg, style: Theme.of(context).textTheme.bodyText2),
          actions: [
            // ???????????? OK ?????? dialog
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                // ????????? dialog
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class LoginButton extends StatelessWidget {
  final int number;
  final Function() onClick;

  const LoginButton({
    required this.number,
    required this.onClick,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: CircleBorder(),
      onTap: number == -2 ? null : onClick,
      child: Container(
        width: 75.0,
        height: 75.0,
        decoration: number == -2
            ? null
            : BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.5),
          border: Border.all(
            width: 3.0,
            color: Theme.of(context).textTheme.headline1!.color!,
          ),
        ),
        child: Center(
          child: number >= 0
              ? Text(
            '$number', // number.toString()
            style: Theme.of(context).textTheme.headline6,
          )
              : (number == -1
              ? Icon(
            Icons.backspace_outlined,
            size: 28.0,
          )
              : SizedBox.shrink()),
        ),
      ),
    );
  }
}


/*
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static const pin = '123456';
  var input = '';

  @override
  Widget build(BuildContext context) {
    //BuildContext ??????????????????????????????????????????????????? ??????????????????????????? Environment ??????????????????????????????/?????????
    return Scaffold(
      body: Container(

        decoration: BoxDecoration(
          gradient: LinearGradient(
            // ??????????????????????????????????????????????????????????????????????????????????????????????????? Container
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            // ???????????????????????????????????????????????????????????????????????????
            colors: [
              Colors.lightBlue.shade50,
              Colors.blueAccent.shade100,
            ],
          ),
        ),

        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon( //icon:png, background:jpg
                        Icons.lock_outlined,
                        size: 100.0,
                        color: Colors.black.withOpacity(0.5),
                      ),
                      Text(
                        'LOGIN',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      Text(
                        'Enter PIN to login',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      Container(
                        height: 40.0,
                        child: SizedBox.shrink(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for(var i=0;i<input.length;i++)
                            Icon(Icons.circle, color: Colors.blue, size: 30.0),
                          for(var i=input.length;i<pin.length;i++)
                            Icon(Icons.circle, color: Colors.blue.withOpacity(0.3), size: 30.0),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                //color: Colors.pink,
                child: Column(
                  children: [
                    [1, 2, 3],
                    [4, 5, 6],
                    [7, 8, 9],
                    [-2,0,-1],
                  ].map((row) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: row.map((item) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: LoginButton( //Right Click -> Refactor -> Extract Flutter Widget <Create new Class>
                            number: item,
                            onClick: _handleClickButton,
                          ),
                        );
                      }).toList(),
                    );
                  }).toList(),
                  */
/*children: [
                    for (int i = 0; i < 3; i++)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          for (var j = 1; j <= 3; j++)
                            LoginButton(number: 3 * i + j),
                          //Right Click -> Refactor -> Extract Flutter Widget <Create new Class>
                        ],
                      ),
                  ],*//*

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMaterialDialog(String title, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(msg),
          actions: [
            // ???????????? OK ?????? dialog
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                // ????????? dialog
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _handleClickButton(int num) {
    //print('hello $num');
    setState(() {
      input = num >= 0
          ? '$input$num'  // '$number' : interpolate
          : (input.length > 0
          ? input.substring(0, input.length-1)
          : input);
      if(input.length == pin.length) {
        if(input == pin)
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        else {
          _showMaterialDialog('ERROR', 'Invalid PIN. Please try again.');
          input = '';
        }
      }
    });
  }

*/
/*onPressed: () {
    Navigator.pushReplacement(  //can't go back to login page
      context,
      MaterialPageRoute(builder: (context) => SecondRoute()),     //go to homepage
    )

    //Navigator.push(...)  //can go back to homepage with homepage code within Navigator.pop()

  }*//*


}

class LoginButton extends StatelessWidget {
  final int number;
  final Function(int) onClick; //When call back function used, it will send parameter

  const LoginButton({
    required this.number,
    required this.onClick,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: CircleBorder(),
      onTap: number==-2 ? null : () => onClick(number),
      */
/*onTap: () {
        onClick(number);
      },*//*

      child: Container(
        width: 80.0,
        height: 80.0,
        decoration: number==-2 ? null : BoxDecoration(
          gradient: LinearGradient(
            // ??????????????????????????????????????????????????????????????????????????????????????????????????? Container
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            // ???????????????????????????????????????????????????????????????????????????
            colors: [
              Colors.white,
              Colors.grey.shade300,
            ],
          ),
          shape: BoxShape.circle,
          border: Border.all(width: 2.0),
          //border width 0.0 : 1px of device (hair line)
        ),
        child: Center(
          child: number >= 0
              ? Text(
            '$number',
            style: Theme.of(context).textTheme.headline6,
          )
              : (number == -1
              ? Icon(Icons.backspace_outlined, size: 28.0)
              : SizedBox.shrink()),
        ),
      ),
    );
  }
}
*/
