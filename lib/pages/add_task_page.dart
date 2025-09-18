import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/task.dart';

class AddTaskPage extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Nueva Tarea")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: "Título"),
            ),
            TextField(
              controller: descController,
              decoration: InputDecoration(labelText: "Descripción"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final task = Task(
                  title: titleController.text,
                  description: descController.text,
                  date: DateTime.now().toString(),
                );
                await DatabaseHelper.instance.insertTask(task);
                Navigator.pop(context);
              },
              child: Text("Guardar"),
            ),
          ],
        ),
      ),
    );
  }
}
