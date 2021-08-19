// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FallbackView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsetsDirectional.all(60),
          child: Image.asset('assets/images/error.png'),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Center(
            child: Text(
              'Connection lost, please connect to the internet',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                textStyle: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
        )
      ],
    ));
  }
}
