import 'package:email_validator/email_validator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Validators {
  static String? validateEmail(String? value, AppLocalizations localizations) {
    if (value == null || value.isEmpty) {
      return localizations.emailRequiredError;
    }
    if (!EmailValidator.validate(value)) {
      return localizations.invalidEmailFormatError;
    }
    return null;
  }

  static String? validatePassword(String? value, AppLocalizations localizations) {
    if (value == null || value.isEmpty) {
      return localizations.passwordRequiredError;
    }
    if (value.length < 8) {
      return localizations.passwordLengthError;

    }
    return null;
  }


  static String? validateName(String? value, AppLocalizations localizations) {
    if (value == null || value.isEmpty) {
      return localizations.nameRequiredError;
    }
    if (!RegExp(r"^[a-zA-Z\u0600-\u06FF\s]+$").hasMatch(value)) {
      return localizations.invalidNameFormatError;
    }
    return null;
  }
  static String? validatePasswordMatch(String? password, String? confirmPassword, AppLocalizations localizations) {
    if (password != confirmPassword) {
      return localizations.passwordsDoNotMatchError;
    }
    return null;
  }


}