import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../core/dioHelper/dio_helper.dart';
import '../model/character_model.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  CharactersCubit() : super(CharactersInitial());

  static CharactersCubit get(context) => BlocProvider.of(context);

  List<CharacterModel> list = [];
  bool isLoading = true;
  //===============================================================

  Future<List<CharacterModel>> getCharacters() async {
    emit(CharactersLoading());
    final response = await DioHelper.getData(url: 'characters');
    final data = response.data as List;
    data.forEach((element) {
      CharacterModel characterModel = CharacterModel.fromJson(element);
      list.add(characterModel);
    });
    emit(CharactersSuccess());
    isLoading = false;
    return list;
  }
}
