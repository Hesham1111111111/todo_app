import 'package:flutter/material.dart';
import 'dart:io';

class TaskDetail extends StatelessWidget {
  final Map task;

  const TaskDetail({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      appBar: AppBar(
        backgroundColor: Colors.tealAccent,
        title: const Text("Task Details"),
        centerTitle: true,
        elevation: 3,
      ),
      body: Center(
        child: Hero(
          tag: "task-${task['id']}",
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child:
                        task['image'] != null &&
                            task['image'].toString().isNotEmpty
                        ? Image.file(
                            File(task['image']),
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            height: 200,
                            width: double.infinity,
                            color: Colors.indigo.shade100,
                            child: const Icon(
                              Icons.image_not_supported_outlined,
                              color: Colors.indigo,
                              size: 80,
                            ),
                          ),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    task['title'] ?? "No Title",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        size: 20,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        task['date'] ?? "",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 15),
                      const Icon(
                        Icons.access_time,
                        size: 20,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        task['time'] ?? "",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "Status: ${task['status'] ?? 'new'}",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.indigo,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
