import 'package:flutter/material.dart';
import 'package:task_app/services/database.dart';
import 'package:task_app/models/user.dart';
import 'package:provider/provider.dart';
import 'package:task_app/shared/constant.dart';
import 'package:date_time_picker/date_time_picker.dart';

class TaskForm extends StatefulWidget {
  const TaskForm({Key? key, required this.groupId}) : super(key: key);

  final String groupId;

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _formKey = GlobalKey<FormState>();

  //form values
  String? _taskName;
  String? _deadline;
  String? _taskType;
  String? _taskPriority;

  @override
  Widget build(BuildContext context) {
    BaseUser user = Provider.of<BaseUser>(context);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const Text(
                'Modifier votre Profil',
                style: TextStyle(fontSize: 18.0),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(
                    hintText: 'Nom de la Tâche',
                    prefixIcon: const Icon(Icons.article)),
                validator: (val) =>
                    val!.isEmpty ? 'Veuillez entrez un nom de groupe' : null,
                onChanged: (val) => setState(() => _taskName = val),
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextFormField(
                decoration: textInputDecoration.copyWith(
                    hintText: 'Importance de la tâche',
                    prefixIcon: const Icon(Icons.article)),
                validator: (val) => val!.isEmpty
                    ? 'Veuillez entrez l\'importance de la tâche'
                    : null,
                onChanged: (val) => setState(() => _taskPriority = val),
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextFormField(
                decoration: textInputDecoration.copyWith(
                    hintText: 'Type de tâche',
                    prefixIcon: const Icon(Icons.article)),
                validator: (val) =>
                    val!.isEmpty ? 'Veuillez entrez un type de tâche' : null,
                onChanged: (val) => setState(() => _taskType = val),
              ),
              const SizedBox(
                height: 10.0,
              ),
              DateTimePicker(
                type: DateTimePickerType.dateTimeSeparate,
                initialValue: DateTime.now().toString(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
                icon: const Icon(Icons.event),
                dateLabelText: 'Date',
                timeLabelText: "Heure",
                onChanged: (val) => setState(() => _deadline = val),
              ),
              MaterialButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await DatabaseService(uid: user.uid).addTask(_taskName,
                        _deadline, _taskType, widget.groupId, _taskPriority);
                    Navigator.pop(context);
                  }
                },
                color: Colors.purple[600],
                textColor: Colors.white,
                elevation: 5.0,
                child: const Text("Valider"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
