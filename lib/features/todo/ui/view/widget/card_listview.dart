import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/todo/ui/view/widget/task_bottomS_sheet.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../manegar/todo_cubit.dart';
import 'hero_tage.dart';

class CardListview extends StatelessWidget {
  CardListview({super.key});

  @override
  Widget build(BuildContext context) {
    var tasks = context.read<TodoCubit>().tasks;

    return AnimationLimiter(
      child: ListView.separated(
        itemCount: tasks.length,

        separatorBuilder: (_, __) => Divider(height: 15, color: Colors.white70),
        itemBuilder: (context, index) {
          var task = tasks[index];
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 500),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 800),
                        pageBuilder: (_, __, ___) => TaskDetail(task: task),
                        transitionsBuilder: (_, animation, __, child) {
                          return ScaleTransition(
                            scale: CurvedAnimation(
                              parent: animation,
                              curve: Curves.easeOutBack,
                            ),
                            child: FadeTransition(
                              opacity: animation,
                              child: child,
                            ),
                          );
                        },
                      ),
                    );
                  },
                  child: Hero(
                    tag: "task-${task['id']}",
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      elevation: 5,
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                            ),
                            child:
                                task['image'] != null &&
                                    task['image'].toString().isNotEmpty
                                ? Image.file(
                                    File(task['image']),
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  )
                                : Container(
                                    width: 100,
                                    height: 100,
                                    color: Colors.teal.shade100,
                                    child: const Icon(
                                      Icons.image_not_supported,
                                      color: Colors.teal,
                                      size: 40,
                                    ),
                                  ),
                          ),
                          Expanded(
                            child: ListTile(
                              title: Text(
                                task['title'] ?? '',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              subtitle: Text(
                                "${task['date']} | ${task['time']}",
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.black,
                                      size: 24,
                                    ),
                                    onPressed: () {
                                      showModalBottomSheet(
                                        isScrollControlled: true,
                                        context: context,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(20),
                                          ),
                                        ),
                                        builder: (context) =>
                                            TaskBottomSheet(task: task),
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete_forever_rounded,
                                      color: Colors.red,
                                      size: 26,
                                    ),
                                    onPressed: () {
                                      context.read<TodoCubit>().deleteTask(
                                        task['id'],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
