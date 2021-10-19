import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/models/user.dart';
import 'package:task_app/screens/my_tasks/tasks_list.dart';
import 'package:task_app/screens/my_tasks/widgets/addgroupform.dart';
import 'package:task_app/services/database.dart';

class MyTasks extends StatefulWidget {
  const MyTasks({Key? key}) : super(key: key);

  @override
  State<MyTasks> createState() => _MyTasksState();
}

class _MyTasksState extends State<MyTasks> {
  @override
  Widget build(BuildContext context) {
    void _showProfilePanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
              child: const GroupForm(),
            );
          });
    }

    BaseUser user = Provider.of<BaseUser>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tâches"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: DatabaseService(uid: user.uid).getTaskGroup(),
        builder: (context, group) {
          if (group.hasError) {
            return Text(group.error.toString());
          } else if (group.hasData) {
            if (group.data!.docs.isEmpty) {
              return const Text("No Task Group Yet");
            } else {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: group.data!.docs.length,
                        itemBuilder: (context, index) {
                          return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            child: Column(
                              children: [
                                ListTile(
                                    title:
                                        Text(group.data!.docs[index]["group"]),
                                    subtitle:
                                        const Text("Nombres de Tâches: 1"),
                                    trailing:
                                        const Icon(Icons.keyboard_arrow_right),
                                    onTap: () {
                                      // Navigate to tasks Page
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => TasksList(
                                            groupId: group.data!.docs[index].id,
                                          ),
                                        ),
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
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showProfilePanel(),
      ),
    );
  }
}
