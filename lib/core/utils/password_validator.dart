class PasswordValidationResult {
  final bool isValid;
  final String message;

  PasswordValidationResult({required this.isValid, required this.message});
}

class PasswordValidator {
  static PasswordValidationResult validate(String password) {
    if (password.isEmpty) {
      return PasswordValidationResult(
        isValid: false,
        message: 'Password cannot be empty',
      );
    }

    if (password.length < 8) {
      return PasswordValidationResult(
        isValid: false,
        message: 'Password must be at least 8 characters long',
      );
    }

    bool hasUpperCase = password.contains(RegExp(r'[A-Z]'));
    bool hasLowerCase = password.contains(RegExp(r'[a-z]'));
    bool hasDigits = password.contains(RegExp(r'[0-9]'));
    bool hasSpecialCharacters = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    List<String> missingCriteria = [];

    if (!hasUpperCase) missingCriteria.add('uppercase letter');
    if (!hasLowerCase) missingCriteria.add('lowercase letter');
    if (!hasDigits) missingCriteria.add('number');
    if (!hasSpecialCharacters) missingCriteria.add('special character');

    if (missingCriteria.isNotEmpty) {
      String message = 'Password must contain at least one: ${missingCriteria.join(', ')}';
      return PasswordValidationResult(
        isValid: false,
        message: message,
      );
    }

    return PasswordValidationResult(
      isValid: true,
      message: 'Password meets all requirements',
    );
  }

  static String getPasswordRequirements() {
    return '''Password must:
• Be at least 8 characters long
• Contain at least one uppercase letter
• Contain at least one lowercase letter
• Contain at least one number
• Contain at least one special character (!@#\$%^&*(),.?":{}|<>)''';
  }
}
