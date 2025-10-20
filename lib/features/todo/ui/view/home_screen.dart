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
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 50.0, end: 0.0),
                duration:  Duration(seconds: 1 ),
                curve: Curves.easeOutBack,
                builder: (context, value, child) {
                  return Opacity(
                    opacity: (1 - (value / 50)).clamp(0.0, 1.0),
                    child: Transform.translate(
                      offset: Offset(0, value),
                      child: child,
                    ),
                  );
                },
                child: AnimatedContainer(
                  duration: Duration(seconds: 1),
                  curve: Curves.bounceOut,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                       Icon(
                        Icons.checklist_rtl_rounded,
                        size: 80,
                        color: Colors.white70,
                      ),
                       SizedBox(height: 10),
                      Text(
                        "No tasks yet",
                        style: AppStayle.stayle1.copyWith(
                          fontSize: 28,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
