import 'package:flutter/material.dart';

class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.task, color: Colors.black87),
          label: "New Task",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.delete, color: Colors.black87),
          label: "Delete",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.archive, color: Colors.black87),
          label: "Archive",
        ),
      ],
    );
  }
}
