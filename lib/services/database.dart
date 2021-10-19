import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference taskmanagerCollection =
      FirebaseFirestore.instance.collection('taskmanager');

  Future<void> updateUserData(String nom, String prenom, String tel) async {
    return await taskmanagerCollection.doc(uid).set({
      'nom': nom,
      'prenom': prenom,
      'telephone': tel,
    });
  }

  // Adding a New Task Group
  Future addTaskGroup(String? taskGroup) async {
    return await taskmanagerCollection
        .doc(uid)
        .collection('taskgroup')
        .add({'group': taskGroup});
  }

  // Adding a new tasks to the corresponding group
  Future addTask(String? designation, String? deadline, String? type,
      String? groupid, String? priority) async {
    return await taskmanagerCollection
        .doc(uid)
        .collection('taskgroup')
        .doc(groupid)
        .collection('tasks')
        .add({
      'designation': designation,
      'deadline': deadline,
      'type': type,
      'isDone': false,
      'priority': priority
    });
  }

  Future validateTask(String? groupid, String? taskid) async {
    return await taskmanagerCollection
        .doc(uid)
        .collection('taskgroup')
        .doc(groupid)
        .collection('tasks')
        .doc(taskid)
        .update({'isDone': true});
  }

  // getting the Streams
  Stream<QuerySnapshot> getTaskGroup() {
    return taskmanagerCollection.doc(uid).collection('taskgroup').snapshots();
  }

  Stream<QuerySnapshot> getTask(String groupid) {
    return taskmanagerCollection
        .doc(uid)
        .collection('taskgroup')
        .doc(groupid)
        .collection('tasks')
        .snapshots();
  }
}
