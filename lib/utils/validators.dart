String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a password';
  }
  if (value.length < 6) {
    return 'Password must be at least 6 characters long';
  }
  if (!RegExp(r'[a-z]').hasMatch(value)) {
    return 'Password must contain at least one lowercase letter';
  }
  if (!RegExp(r'[A-Z]').hasMatch(value)) {
    return 'Password must contain at least one uppercase letter';
  }
  if (!RegExp(r'[0-9]').hasMatch(value)) {
    return 'Password must contain at least one number';
  }
  if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>~]').hasMatch(value)) {
    return 'Password must contain at least 1 special character';
  }

  return null;
}

String? validateConfirmPassword(String? value, String password) {
  if (value == null || value.isEmpty) {
    return 'Please confirm your password';
  }
  if (value != password) {
    return 'Passwords do not match';
  }
  return null;
}

bool isValidEmail(String email) {
  // A regular expression for validating an email address
  final RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  return emailRegExp.hasMatch(email);
}

String? emailError(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter an email address';
  }
  if (!isValidEmail(value)) {
    return 'Please enter a valid email address';
  }
  return null;
}
