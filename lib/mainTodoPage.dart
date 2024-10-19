import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_project/newtask.dart';

class mainTodopage extends StatefulWidget {
  const mainTodopage({super.key});

  @override
  State<mainTodopage> createState() => _mainTodopageState();
}

class _mainTodopageState extends State<mainTodopage> {
  TextEditingController taskName1 = TextEditingController();
  TextEditingController taskName2 = TextEditingController();
  List<String> taskname = [];
  List<String> taskdate = [];

  void initState() {
    
    super.initState();

    TodoListLoad();
  }

  Future<void> TodoListLoad() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? listofdata = prefs.getStringList('listoftask');
    List<String>? datelist = prefs.getStringList('listofdate');

    if (listofdata != null) {
      setState(() {
        taskname = listofdata;
      });
    }
    if (datelist != null) {
      setState(() {
        taskdate = datelist;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime? selectedDate;

    Future<void> taskload() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setStringList('listoftask', taskname!);
      await prefs.setStringList('listofdate', taskdate!);
    }

    Future<void> datefunction(BuildContext context) async {
      final DateTime? newdate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );
      if (newdate != null && newdate != selectedDate) {
        setState(() {
          taskName2.text = newdate.toString().substring(0, 10);
          selectedDate = newdate;
        });
      }
    }

    void showTaskDialog(String task, String date, int index) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              taskName1.text = task;
              taskName2.text = date;
              return AlertDialog(
                title: const Text(
                  "Add Task",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: taskName1,
                      decoration: const InputDecoration(labelText: 'Task Name'),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: taskName2,
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: "Select Date",
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.calendar_today,
                            color: Color.fromARGB(255, 94, 4, 146),
                          ),
                          onPressed: () => datefunction(context),
                        ),
                      ),
                    ),
                  ],
                ),
                actions: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 48, 188, 13),
                          textStyle: const TextStyle(
                              fontSize: 0, fontWeight: FontWeight.bold)),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 10,
                            color: Color.fromARGB(255, 255, 255, 255)),
                      )),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 52, 34, 63),
                          textStyle: const TextStyle(
                              fontSize: 0, fontWeight: FontWeight.bold)),
                      onPressed: () {
                        setState(() {
                          if (taskName1.text.isEmpty) {
                            taskName1.clear();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Add task details')),
                            );
                          } else {
                            taskname[index] = taskName1.text;
                            taskdate[index] = taskName2.text;
                            taskload();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const mainTodopage()));
                          }
                        });

                       
                      },
                      child: const Text(
                        "Add Task",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 10,
                            color: Color.fromARGB(255, 255, 255, 255)),
                      )),
                ],
              );
            },
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 94, 4, 146),
        title: const Center(
          child: Text("Todo App",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 30,
                  color: Color.fromARGB(255, 255, 255, 255))),
        ),
      ),
      body: Container(
        color: const Color.fromARGB(255, 168, 168, 166),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Row(
                children: [
                  Text(
                    "Hello",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 30,
                        color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                  Text(
                    " Neha",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 30,
                        color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  Text(
                    "Task List",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.60,
                        color: const Color.fromARGB(255, 168, 168, 166),
                        child: ListView.builder(
                            itemCount: taskdate.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color.fromARGB(255, 215, 215, 214),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(Icons.description,
                                                size: 50,
                                                color: Color.fromARGB(
                                                    255, 94, 4, 146)),
                                            Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(taskname[index]),
                                                  Text(taskdate[index]),
                                                ],
                                              ),
                                            ),
                                            const Spacer(),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Column(
                                                children: [
                                                  ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              backgroundColor:
                                                                  const Color
                                                                      .fromARGB(
                                                                          255,
                                                                          48,
                                                                          188,
                                                                          13),
                                                              textStyle: const TextStyle(
                                                                  fontSize: 0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                      onPressed: () {
                                                        showTaskDialog(
                                                            taskname[index],
                                                            taskdate[index],
                                                            index);
                                                      },
                                                      child: const Text(
                                                        "Edit",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 10,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    255)),
                                                      )),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              backgroundColor:
                                                                  const Color
                                                                      .fromARGB(
                                                                          255,
                                                                          146,
                                                                          97,
                                                                          96),
                                                              textStyle: const TextStyle(
                                                                  fontSize: 0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                      onPressed: () {
                                                        setState(() {
                                                          taskdate
                                                              .removeAt(index);
                                                          taskname
                                                              .removeAt(index);

                                                          taskload();
                                                        });
                                                      },
                                                      child: const Text(
                                                        "Delete",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 10,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    255)),
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 10),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 94, 4, 146),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            textStyle: const TextStyle(
                                fontSize: 0, fontWeight: FontWeight.bold)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const addnewtask()));
                        },
                        child: const Text(
                          "Add New Task",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: Color.fromARGB(255, 255, 255, 255)),
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
