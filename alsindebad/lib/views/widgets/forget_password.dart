import 'package:flutter/material.dart';
import '../../utils/validators.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgetPasswordForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;

  const ForgetPasswordForm({
    Key? key,
    required this.formKey,
    required this.emailController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final localizations = AppLocalizations.of(context);
    if (localizations == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white60),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: localizations.email,
              hintText: localizations.email,
              hintStyle: TextStyle(color: Colors.grey),
              contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 17.0),
              border: OutlineInputBorder(),
            ),
            autofocus: true,
            validator: (value) => Validators.validateEmail(value, localizations),
          ),
        ),
      ),
    );
  }
}
