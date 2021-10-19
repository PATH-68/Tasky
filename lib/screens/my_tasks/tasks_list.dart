import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/models/user.dart';
import 'package:task_app/screens/my_tasks/widgets/addtaskform.dart';
import 'package:task_app/services/database.dart';

class TasksList extends StatefulWidget {
  const TasksList({Key? key, required this.groupId}) : super(key: key);

  final String groupId;
  @override
  _TasksListState createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  @override
  Widget build(BuildContext context) {
    void _showProfilePanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
              child: TaskForm(groupId: widget.groupId),
            );
          });
    }

    BaseUser user = Provider.of(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showProfilePanel(),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Liste des Tâches"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: DatabaseService(uid: user.uid).getTask(widget.groupId),
        builder: (context, tasks) {
          if (tasks.hasError) {
            return Text(tasks.error.toString());
          } else if (tasks.hasData) {
            if (tasks.data!.docs.isEmpty) {
              return Container(
                height: 300.0,
                child: const Center(
                  child: Text("Vous n'avez enregistré aucune Tâches"),
                ),
              );
            } else {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: tasks.data!.docs.length,
                        itemBuilder: (context, index) {
                          return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            child: Column(
                              children: [
                                ListTile(
                                    title: Text(
                                        tasks.data!.docs[index]["designation"]),
                                    subtitle: Text(
                                        tasks.data!.docs[index]["deadline"]),
                                    trailing: tasks.data!.docs[index]["isDone"]
                                        ? const Icon(
                                            Icons.check,
                                            color: Colors.green,
                                          )
                                        : const Text("Valider"),
                                    onTap: () {
                                      !tasks.data!.docs[index]["isDone"]
                                          ? showDialog(
                                              context: context,
                                              barrierDismissible: true,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Center(
                                                      child:
                                                          Text('Validation')),
                                                  content: const Text(
                                                      'Avez vous accomplit cette tâches?!'),
                                                  actions: <Widget>[
                                                    CupertinoDialogAction(
                                                      child: const Text('Non'),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                    CupertinoDialogAction(
                                                      child: const Text('Oui'),
                                                      onPressed: () async {
                                                        DatabaseService(
                                                                uid: user.uid)
                                                            .validateTask(
                                                                widget.groupId,
                                                                tasks
                                                                    .data!
                                                                    .docs[index]
                                                                    .id);
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            )
                                          : showDialog(
                                              context: context,
                                              barrierDismissible: true,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Center(
                                                      child:
                                                          Text('Validation')),
                                                  content: const Text(
                                                      'Cette tâches est déjà terminé!'),
                                                  actions: <Widget>[
                                                    CupertinoDialogAction(
                                                      child: const Text('Ok!'),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                    }),
                              ],
                            ),
                          );
                        }),
                  ),
                ],
              );
            }
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
