import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/task.dart';
import '../services/hive_service.dart';
import 'add_task_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  void loadTasks() async {
    tasks = await DatabaseHelper.instance.getTasks();
    setState(() {});
  }

  void deleteTask(int id) async {
    await DatabaseHelper.instance.deleteTask(id);
    loadTasks();
  }

  void toggleStatus(Task task) async {
    final updatedTask = Task(
      id: task.id,
      title: task.title,
      description: task.description,
      date: task.date,
      status: task.status == "pendiente" ? "completada" : "pendiente",
    );
    await DatabaseHelper.instance.updateTask(updatedTask);
    loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gestor de Tareas"),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: () {
              String theme = HiveService.getTheme() == "dark"
                  ? "light"
                  : "dark";
              HiveService.setTheme(theme);
              setState(() {});
            },
          ),
        ],
      ),
      body: tasks.isEmpty
          ? Center(child: Text("No hay tareas 😴"))
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    title: Text(
                      task.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        decoration: task.status == "completada"
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 4),
                        Text(task.description),
                        SizedBox(height: 4),
                        Text("Estado: ${task.status}"),
                        SizedBox(height: 4),
                        Text(
                          "Fecha: ${task.date.split(' ')[0]}",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    trailing: Wrap(
                      spacing: 6,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.check_circle,
                            color: task.status == "completada"
                                ? Colors.green
                                : Colors.grey,
                          ),
                          onPressed: () => toggleStatus(task),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => deleteTask(task.id!),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskPage()),
          );
          loadTasks();
        },
      ),
    );
  }
}
