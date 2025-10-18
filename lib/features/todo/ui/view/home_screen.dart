import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/resours/styles.dart';
import 'package:todo_app/features/todo/ui/view/widget/app_bottom_navbar.dart';
import 'package:todo_app/features/todo/ui/view/widget/card_listview.dart';
import 'package:todo_app/features/todo/ui/view/widget/float_action.dart';
import '../../manegar/todo_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("ToDo App ", style: AppStayle.stayle1),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocBuilder<TodoCubit, TodoState>(
        builder: (context, state) {
          var tasks = context.read<TodoCubit>().tasks;
          if (tasks.isEmpty) {
            return Center(
              child: Text("No tasks yet", style: AppStayle.stayle1),
            );
          } else {
            return CardListview();
          }
        },
      ),
      floatingActionButton: const FloatinAction(),
      bottomNavigationBar: const AppBottomNavBar(),
    );
  }
}
