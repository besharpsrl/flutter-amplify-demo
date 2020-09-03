class FormValidators {
  // In this static class we defines different common validators
  // with the forms in the applications. The common signature is with (value) and
  // return null when everything is ok.

  static requiredValidator(value) {
    if (value.isEmpty) {
      return 'Please fill the field';
    }
    return null;
  }

  static passwordValidator(value) {

    if (value == null || value.isEmpty) {
      return 'Please fill the field';
    }

    bool hasUppercase = value.contains(new RegExp(r'[A-Z]'));
    bool hasDigits = value.contains(new RegExp(r'[0-9]'));
    bool hasLowercase = value.contains(new RegExp(r'[a-z]'));
    bool hasSpecialCharacters = value.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    bool hasMinLength = value.length >= 8;

    if (!hasMinLength) {
      return 'Please use a password of >8 chars.';
    }
    if(!hasDigits) {
      return 'Please insert at least one number.';
    }
    if(!hasUppercase) {
      return 'Please insewrt at least one Upeercase letter.';
    }
    if(!hasLowercase) {
      return 'Please insert at least one lowercase letter.';
    }
    if(!hasSpecialCharacters) {
      return 'Please use at least one special character.';
    }

    return null;
  }

  static emailValidator(value) {
    if (value.isEmpty) {
      return 'Please fill the field';
    }
    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
      return 'Please insert a valid email';
    }
    return null;
  }
}