final _emailRegExp = RegExp(
    r'^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

class Validators {
  /// Validate if the [value] has some text
  static bool required(String value) => value.trim().isNotEmpty;

  /// Validate if the [value] matches with the specified [regex]
  static bool regex(String value, RegExp regex) => regex.hasMatch(value);

  /// Validate if the passed [email] is valid
  static bool email(String email) => regex(email, _emailRegExp);

  /// Validate if the current [value] has the specified [length]
  static bool length(String value, int length) {
    if (length < 0) {
      throw Exception('Length must be positive');
    }

    return value.length == length;
  }

  /// Validates length of a string
  static bool minLength(String value, int length) {
    if (length < 0) {
      throw Exception('Length must be positive');
    }

    return value.length >= length;
  }

  /// Nest many [validations] and returns the result
  static bool validationResult(List<bool> validations) {
    return validations.every((element) => element == true);
  }
}
