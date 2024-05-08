
import 'package:flutter/material.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String? name, phone, country, password, confirmPassword;


  @override
  Widget build(BuildContext context) {

    List<String> countries = ['USA', 'Canada', 'Palestine', 'Australia', 'Germany'];

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
                      labelText: 'Name*',
                      hintText: 'Input your name!',
                      hintStyle: TextStyle(color: Colors.grey),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 17.0),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name!';
                      }
                      return null;
                    },
                    onSaved: (value) => name = value,
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white60),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Phone*',
                      hintText: 'Input your phone number!',
                      hintStyle: TextStyle(color: Colors.grey),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 17.0),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number!';
                      }
                      return null;
                    },
                    onSaved: (value) => phone = value,
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white60),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Country*',
                      hintText: 'Select your country!',
                      hintStyle: TextStyle(color: Colors.grey),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 17.0),
                      border: OutlineInputBorder(),
                    ),
                    value: country,
                    onChanged: (String? newValue) {
                      setState(() {
                        country = newValue!;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select your country!';
                      }
                      return null;
                    },
                    items: countries.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white60),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password*',
                      hintStyle: TextStyle(color: Colors.grey),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 17.0),
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (value) => password = value,
                ),
              ),
              ),
                SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white60),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Repeat Password*',
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



