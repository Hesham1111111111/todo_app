import 'package:flutter/material.dart';
import 'package:todo_app/features/todo/ui/view/widget/task_bottomS_sheet.dart';
class FloatinAction extends StatelessWidget {
  const FloatinAction({super.key});

  @override
  Widget build(BuildContext context) {
    return   FloatingActionButton(
      backgroundColor: Colors.indigo,
      child: const Icon(Icons.add, color: Colors.white),
      onPressed: () {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (context) => const TaskBottomSheet(task: {}),
        );
      },
    );
  }
}
