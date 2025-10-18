import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_app/core/resours/styles.dart';
import '../../../manegar/todo_cubit.dart';

class TaskBottomSheet extends StatefulWidget {
  final Map task;

  const TaskBottomSheet({super.key, required this.task});

  @override
  State<TaskBottomSheet> createState() => _TaskBottomSheetState();
}

class _TaskBottomSheetState extends State<TaskBottomSheet> {
  final titleController = TextEditingController();
  final timeController = TextEditingController();
  final dateController = TextEditingController();
  final imageController = TextEditingController();
  File? _image;

  @override
  void initState() {
    super.initState();

    if (widget.task.isNotEmpty) {
      titleController.text = widget.task['title'] ?? '';
      timeController.text = widget.task['time'] ?? '';
      dateController.text = widget.task['date'] ?? '';
    }
  }

  pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        top: 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: timeController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: "Time",
                prefixIcon: const Icon(Icons.access_time),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onTap: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (pickedTime != null) {
                  timeController.text = pickedTime.format(context);
                }
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: dateController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: "Date",
                prefixIcon: const Icon(Icons.calendar_today),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                );
                if (pickedDate != null) {
                  dateController.text =
                      "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
                }
              },
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: pickImage,
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: _image == null
                    ? const Center(
                        child: Text(
                          "Pick an Image",
                          style: TextStyle(color: Colors.black54),
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(_image!, fit: BoxFit.cover),
                      ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isNotEmpty &&
                    timeController.text.isNotEmpty &&
                    dateController.text.isNotEmpty) {
                  final imagePath = _image?.path ?? widget.task['image'];

                  if (widget.task.isNotEmpty) {
                    context.read<TodoCubit>().updateTask(
                      id: widget.task['id'],
                      title: titleController.text,
                      date: dateController.text,
                      time: timeController.text,
                      image: imagePath,
                    );
                  } else {
                    context.read<TodoCubit>().insertTask(
                      title: titleController.text,
                      date: dateController.text,
                      time: timeController.text,
                      image: imagePath,
                    );
                  }

                  Navigator.pop(context);
                }
              },
              child: Text(
                widget.task.isNotEmpty ? "Edite Task" : "Done Task",
                style: AppStayle.stayle2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
