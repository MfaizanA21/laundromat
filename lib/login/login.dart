import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFBAEAF8),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 26.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
                'Welcome to',
                style: TextStyle(
                    fontFamily: 'IrishGrover',
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                ),
              ),
            Padding(padding: EdgeInsets.only(top: 8)),
            Text(
              'Soft',
              style: TextStyle(
                fontFamily: 'kodchasan',
                fontSize: 32,
                fontWeight: FontWeight.w400,
                color: Color(0xFF2596BE),
              )
            ),
            Padding(padding: EdgeInsets.only(top: 8)),
            Expanded(
              child: Image(
                  image: AssetImage('lib/assets/images/welcome.png'),
                fit: BoxFit.contain,
              ),
            )
          ],
        ),
      )
    );
  }
}
