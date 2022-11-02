/*
FUNCTION:
DESCRIPTION: Service to handle any string manipulation or validation
PARAMETERS: input - string
 */


class StringService {
  /// Custom validator that looks for specific features in a string
  /// Specify the things you want (notEmpty, containsUppercase, etc)
  Function(String?) customStringValidator(
    String value, {
    String label = 'Value',
    bool notEmpty = false,
    bool includesUppercase = false,
    bool includesLowercase = false,
    bool includesSpecial = false,
    bool includesNumber = false,
  }) {
    return (value) {
      if (notEmpty && (value == null || value.trim() == '')) {
        return '$label cannot be empty';
      } else if (includesUppercase && !containsUppercase(value)) {
        return '$label must contain an uppercase letter';
      } else if (includesLowercase && !containsLowercase(value)) {
        return '$label must contain a lowercase letter';
      } else if (includesSpecial && !containsSpecialCharacter(value)) {
        return '$label must contain a special character';
      } else if (includesNumber && !containsNumber(value)) {
        return '$label must contain a number';
      } else {
        return null;
      }
    };
  }

  String? passwordIsValid(String? password) {
    if (isEmpty(password)) {
      return 'Value cannot be empty';
    } else if (!containsUppercase(password)) {
      return 'Password must contain a capital letter';
    } else if (!containsLowercase(password)) {
      return 'Password must contain a lowercase letter';
    } else if (!containsNumber(password)) {
      return 'Password must contain a number';
    } else if (!containsSpecialCharacter(password)) {
      return 'Password must contain a special character';
    } else if (!contains6Characters(password)) {
      return 'Password must contain at least 6 characters';
    }else {
      return null;
    }
  }

  bool isEmpty(String? value) {
    return (value == null || value.trim() == '');
  }

  bool containsUppercase(String? value) {
    return RegExp(r'(?=.*[A-Z])').hasMatch(value ?? '');
  }

  bool containsLowercase(String? value) {
    return RegExp(r'(?=.*[a-z])').hasMatch(value ?? '');
  }

  bool containsNumber(String? value) {
    return RegExp(r'(?=.*?[0-9])').hasMatch(value ?? '');
  }

  bool containsSpecialCharacter(String? value) {
    return RegExp(r'(?=.*?[!@#\$&*~]).{8,}').hasMatch(value ?? '');
  }

  bool contains6Characters(String? value) {
    return (value ??'').length >= 6;
  }

  //EMAIL VALIDATION
  String? emailIsValid(String? value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    if(value != null) {
      if (!regex.hasMatch(value.trim())) {
        return 'Email format is invalid';
      } else {
        return null;
      }
    } else{
      return 'Email is empty';
    }
  }
}
