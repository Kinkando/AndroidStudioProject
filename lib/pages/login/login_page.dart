import 'package:flutter/material.dart';
import 'package:flutter_food/pages/home/home_page.dart';

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
    //BuildContext อยากรู้ขนาดหน้าจอ ให้ข้อมูล Environment ของเครื่อง/แอป
    return Scaffold(
      body: Container(

        decoration: BoxDecoration(
          gradient: LinearGradient(
            // ไล่เฉดจากมุมบนซ้ายไปมุมล่างขวาของ Container
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            // ไล่เฉดจากสีแดงไปสีน้ำเงิน
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
                  ],*/
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
            // ปุ่ม OK ใน dialog
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                // ปิด dialog
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

/*onPressed: () {
    Navigator.pushReplacement(  //can't go back to login page
      context,
      MaterialPageRoute(builder: (context) => SecondRoute()),     //go to homepage
    )

    //Navigator.push(...)  //can go back to homepage with homepage code within Navigator.pop()

  }*/

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
      /*onTap: () {
        onClick(number);
      },*/
      child: Container(
        width: 80.0,
        height: 80.0,
        decoration: number==-2 ? null : BoxDecoration(
          gradient: LinearGradient(
            // ไล่เฉดจากมุมบนซ้ายไปมุมล่างขวาของ Container
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            // ไล่เฉดจากสีแดงไปสีน้ำเงิน
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
