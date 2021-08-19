// ignore_for_file: prefer_const_constructors
import 'package:breakingbad_app/bloc/characters_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    CharactersCubit.get(context).getCharacters();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        var characterCubit = CharactersCubit.get(context);
        return SafeArea(
          child: Scaffold(
            body: characterCubit.isLoading
                ? Center(
                    child: CupertinoActivityIndicator(
                    animating: true,
                    radius: 24,
                  ))
                : ListView.builder(
                    itemCount: characterCubit.list.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(16),
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: Text(
                              characterCubit.list[index].charId.toString())),
                    ),
                  ),
          ),
        );
      },
    );
  }
}
