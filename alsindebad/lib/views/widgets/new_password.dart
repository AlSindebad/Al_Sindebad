
import 'package:flutter/material.dart';

class NewPasswordForm extends StatefulWidget {
  @override
  _NewPasswordFormState createState() => _NewPasswordFormState();
}

class _NewPasswordFormState extends State<NewPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  String?  password, confirmPassword;

  @override
  Widget build(BuildContext context) {

    return Material(
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white60),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'New password*',
                      hintStyle: TextStyle(color: Colors.grey),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 17.0),
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (value) => password = value,
                  ),
                ),
              ),
              SizedBox(height: 40.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white60),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Confirm new password*',
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 17.0),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value != password) {
                        return 'Passwords do not match!';
                      }
                      return null;
                    },
                    onSaved: (value) => confirmPassword = value,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



