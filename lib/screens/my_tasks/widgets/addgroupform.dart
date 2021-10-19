import 'package:flutter/material.dart';
import 'package:task_app/services/database.dart';
import 'package:task_app/models/user.dart';
import 'package:provider/provider.dart';
import 'package:task_app/shared/constant.dart';

class GroupForm extends StatefulWidget {
  const GroupForm({Key? key}) : super(key: key);

  @override
  _GroupFormState createState() => _GroupFormState();
}

class _GroupFormState extends State<GroupForm> {
  final _formKey = GlobalKey<FormState>();

  //form values
  String? _groupName;

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
                  hintText: 'Nom du groupe',
                  prefixIcon: const Icon(Icons.article)),
              validator: (val) =>
                  val!.isEmpty ? 'Veuillez entrez un nom de groupe' : null,
              onChanged: (val) => setState(() => _groupName = val),
            ),
            const SizedBox(
              height: 10.0,
            ),
            MaterialButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await DatabaseService(uid: user.uid).addTaskGroup(_groupName);
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
    );
  }
}
