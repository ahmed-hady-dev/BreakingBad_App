// ignore_for_file: prefer_const_constructors
import 'package:breakingbad_app/bloc/characters_cubit.dart';
import 'package:breakingbad_app/core/constants.dart';
import 'package:breakingbad_app/core/router/router.dart';
import 'package:breakingbad_app/model/character_model.dart';
import 'package:breakingbad_app/view/character/character_view.dart';
import 'package:breakingbad_app/view/fallback/fallback_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

import 'widgets/loading_widget.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isSearch = false;
  List<CharacterModel> searchedCharactersList = [];
  TextEditingController searchController = TextEditingController();

  void addSearchedForItemsToSearchedList(String searchedCharacters) {
    searchedCharactersList = CharactersCubit.get(context)
        .list
        .where((charachter) =>
            charachter.name.toLowerCase().startsWith(searchedCharacters))
        .toList();
    setState(() {});
  }

  Widget buildSearchField() {
    return TextField(
      controller: searchController,
      cursorColor: MyColors.lightBlue,
      decoration: InputDecoration(
        hintText: 'Find a character...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: MyColors.lightBlue, fontSize: 18),
      ),
      style: TextStyle(color: MyColors.lightBlue, fontSize: 18),
      onChanged: (searchedCharacter) {
        addSearchedForItemsToSearchedList(searchedCharacter);
      },
    );
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      isSearch = true;
    });
  }

  void _stopSearching() {
    setState(() {
      searchController.clear();
      isSearch = false;
    });
  }

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
        var characterGetter =
            isSearch ? searchedCharactersList : characterCubit.list;
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: MyColors.darkBlue,
              title: isSearch
                  ? buildSearchField()
                  : Text('Breaking Bad Characters'),
              centerTitle: true,
              actions: isSearch
                  ? [
                      IconButton(
                          onPressed: () {
                            _stopSearching();
                            MagicRouter.pop();
                          },
                          icon: Icon(Icons.close))
                    ]
                  : [
                      IconButton(
                          onPressed: _startSearch,
                          icon: Icon(Icons.search_rounded))
                    ],
            ),
            body: OfflineBuilder(
              connectivityBuilder: (
                BuildContext context,
                ConnectivityResult connectivity,
                Widget child,
              ) {
                final bool connected = connectivity != ConnectivityResult.none;

                if (connected) {
                  return characterCubit.isLoading
                      ? LoadingWidget()
                      : GridView.builder(
                          itemCount: searchController.text.isEmpty
                              ? characterGetter.length
                              : searchedCharactersList.length,
                          // padding: EdgeInsets.all(24),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 1,
                            crossAxisSpacing: 1,
                            childAspectRatio: 2 / 3,
                          ),
                          itemBuilder: (context, index) => InkWell(
                            borderRadius: BorderRadius.circular(24),
                            onTap: () {
                              MagicRouter.navigateTo(CharacterView(
                                character: characterGetter[index],
                              ));
                            },
                            child: Container(
                              width: double.infinity,
                              margin:
                                  EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                              padding: EdgeInsetsDirectional.all(4),
                              decoration: BoxDecoration(
                                color: MyColors.lightBlue,
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Hero(
                                tag: characterGetter[index].charId,
                                child: GridTile(
                                  child: characterGetter[index].image.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(24),
                                          child: FadeInImage.assetNetwork(
                                            width: double.infinity,
                                            height: double.infinity,
                                            placeholder:
                                                'assets/images/loading.gif',
                                            placeholderCacheHeight: 200,
                                            placeholderCacheWidth: 200,
                                            image: characterGetter[index].image,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : Image.asset(
                                          'assets/images/placeholder.png'),
                                  footer: Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 10),
                                    // color: Colors.black54,
                                    decoration: BoxDecoration(
                                      color: MyColors.lightBlue,
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    alignment: Alignment.bottomCenter,
                                    child: Text(
                                      '${characterGetter[index].name}',
                                      style: TextStyle(
                                        height: 1.3,
                                        fontSize: 16,
                                        color: MyColors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                } else {
                  return FallbackView();
                }
              },
              child: LoadingWidget(),
            ),
          ),
        );
      },
    );
  }
}
