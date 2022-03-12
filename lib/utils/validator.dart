class FieldValidator {
  static String validateFirstName(String value) {
    if (value.isEmpty) return "Please enter first name";
    if (value.length < 3) {
      return "First name is too short";
    }
    if (value.length >= 50) {
      return "First name must be less than 50 characters";
    }
    if (!RegExp(r"^([ \u00c0-\u01ffa-zA-Z'\-])+$").hasMatch(value)) {
      return 'Invalid Name';
    }
    return null;
  }

  static String validateLastName(String value) {
    if (value.isEmpty) return "Please enter last name";
    if (value.length < 3) {
      return "Last name is too short";
    }
    if (value.length >= 50) {
      return "Last name must be less than 50 characters";
    }
    if (!RegExp(r"^([ \u00c0-\u01ffa-zA-Z'\-])+$").hasMatch(value)) {
      return 'Invalid Name';
    }
    return null;
  }

  static String validateFullName(String value) {
    if (value.isEmpty) return "Please enter full name";
    if (value.length <= 2) {
      return "Full name is too short";
    }
    if (value.length >= 50) {
      return "Full mame must be less than 50 characters";
    }
    return null;
  }

  static String validatePhoneNumber(String value) {
    if (value.isEmpty) return "Please enter mobile number";
    if (value.length < 11) {
      return "Invalid Mobile Number";
    }
    if (value.length > 11) {
      return " Mobile number must be equal to 11";
    }
    return null;
  }

  static String validateEmail(String value) {
    if (value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]")
        .hasMatch(value)) {
      return 'Invalid email';
    }
    return null;
  }

  static String validatePassword(String value) {
    if (value.isEmpty) return "Please enter password";
    if (value.length < 8) return "Password should contain at least 8 character";
    if (!RegExp(r"^(?=.*[A-Za-z])(?=.*\d).{8,}$").hasMatch(value)) {
      return 'Password should be alphanumeric';
    }
    return null;
  }

  static String validateConfirmPassword(String value) {
    if (value.isEmpty) return "Please enter confirm password";
    if (value.length < 8)
      return "Confirm Password should contain at least 8 character";
    if (!RegExp(r"^(?=.*[A-Za-z])(?=.*\d).{8,}$").hasMatch(value)) {
      return 'Confirm Password should be alphanumeric';
    }
    return null;
  }

  static String validatePasswordMatch(String value, String pass2) {
    if (value.isEmpty) return "Please enter confirm password";
    if (value.length < 8)
      return "Confirm Password should contain at least 8 character";
    if (value != pass2) {
      return 'Password didn\'t match';
    }
    if (!RegExp(r"^(?=.*[A-Za-z])(?=.*\d).{8,}$").hasMatch(value)) {
      return 'Confirm Password should be alphanumeric';
    }

    return null;
  }

  static String validateOldPassword(String value) {
    if (value.isEmpty) return "Please enter old password";
    if (value.length < 8) return "Password should contain at least 8 character";
    if (!RegExp(r"^(?=.*[A-Za-z])(?=.*\d).{8,}$").hasMatch(value)) {
      return 'Old Password should be alphanumeric';
    }
    return null;
  }

  static String validateNewPassword(String value) {
    if (value.isEmpty) return "Please enter new password";
    if (value.length < 8) return "Password should contain at least 8 character";
    if (!RegExp(r"^(?=.*[A-Za-z])(?=.*\d).{8,}$").hasMatch(value)) {
      return 'New Password should be alphanumeric';
    }
    return null;
  }

  static String validatePin(String value) {
    print("validateName : $value ");

    if (value.isEmpty) return "Enter OTP";

    Pattern pattern = r'^(?=.*?[0-9])(?!.*?[!@#\$&*~+/.,():N]).{6,}$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value.trim())) {
      return "Invalid OTP";
    }

    return null;
  }

  static String thisField(String value) {
    if (value.isEmpty) return "Please enter this field";
    return null;
  }
}
