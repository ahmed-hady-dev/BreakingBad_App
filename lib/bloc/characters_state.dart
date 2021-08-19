part of 'characters_cubit.dart';

@immutable
abstract class CharactersState {}

class CharactersInitial extends CharactersState {}

class CharactersLoading extends CharactersState {}

class CharactersSuccess extends CharactersState {}

class CharactersFailed extends CharactersState {}


