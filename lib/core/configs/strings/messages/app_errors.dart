

class AppErrors {
  static const String errorEmpty="Cannot be empty !";
  static const String emailAlready ="Registration failed, Email may have already been used !";
  static const String formatEmail = "Wrong-formatted emails";
  static const String checkMatch = "Passwords don't match";
  static const String loginFail = "Incorrect email or password !!!";
  static String minLength({required int minLength}) {
     return "Must not be less than $minLength characters";
  }
  
  static String maxLength({required int maxLength}) {
     return "No more than $maxLength characters";
  }


  static const String verifyFail = "Failed to send verification email."; 
  static const String noUerLogin ="No user logged in.";
}