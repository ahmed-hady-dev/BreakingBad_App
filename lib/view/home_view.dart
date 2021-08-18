// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      builder: (context, state) {
        return Scaffold(
          body: Center(child: const Text('Home')),
        );
      },
    );
  }
}
