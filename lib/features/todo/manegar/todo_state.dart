part of 'todo_cubit.dart';

sealed class TodoState {}

final class TodoInitial extends TodoState {}

final class TodoCreateDatabase extends TodoState {}

final class TodoInsertDatabase extends TodoState {}

final class TodoDelete extends TodoState {}

final class TodoUpdateDatabase extends TodoState {}

final class TodoGetDatabase extends TodoState {}
