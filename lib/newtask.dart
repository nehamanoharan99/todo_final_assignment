import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_project/mainTodoPage.dart';

class addnewtask extends StatefulWidget {
  const addnewtask({super.key});

  @override
  State<addnewtask> createState() => _addnewtaskState();
}

class _addnewtaskState extends State<addnewtask> {
  TextEditingController timedate = TextEditingController();
  TextEditingController taskdetails = TextEditingController();

  Future<void> taskUpdate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> listofdata = prefs.getStringList('listoftask') ?? [];
    List<String> datelist = prefs.getStringList('listofdate') ?? [];

    listofdata.add(taskdetails.text);
    datelist.add(timedate.text);

    await prefs.setStringList('listoftask', listofdata);
    await prefs.setStringList('listofdate', datelist);

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const mainTodopage()));
  }

  Future<void> datefunction(BuildContext context) async {
    final DateTime? newdate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (newdate != null) {
      setState(() {
        print(newdate);
        timedate.text = newdate.toString().substring(0, 10);
        print(timedate.text);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 168, 168, 166),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Create New task",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color.fromARGB(255, 0, 0, 0)),
            ),
          ],
        ),
      ),
      body: Container(
          color: const Color.fromARGB(255, 168, 168, 166),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: taskdetails,
                      decoration: InputDecoration(
                        fillColor: const Color.fromARGB(255, 255, 255, 255),
                        filled: true,
                       
                        hintText: "Enter Notes",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              30.0),
                          borderSide:
                              const BorderSide(color: Colors.blue), 
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: timedate,
                      readOnly: true,
                      decoration: InputDecoration(
                        fillColor: const Color.fromARGB(255, 255, 255, 255),
                        filled: true,
                       
                        hintText: "Select Date",
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.calendar_today,
                            color: Color.fromARGB(255, 94, 4, 146),
                          ),
                          onPressed: () => datefunction(context),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              30.0), 
                          borderSide:
                              const BorderSide(color: Colors.blue), 
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 255, 255, 255),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          textStyle: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                      onPressed: () {
                        if (taskdetails.text.isEmpty || timedate.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Add task details or Date')),
                          );
                        } else {
                          setState(() {
                           
                            taskUpdate();
                          });
                        }
                      },
                      child: const Text(
                        "Create Task",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: Color.fromARGB(255, 94, 4, 146)),
                      ))
                ],
              ),
            ],
          )),
    );
  }
}
