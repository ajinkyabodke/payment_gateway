import 'package:flutter/material.dart';
import 'package:payment_gateway/screens/welcome_screen_.dart';


void main() => runApp(Payment());

class Payment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.black54),
        ),
      ),
      home: PaymentScreen(),

    );
  }
}
