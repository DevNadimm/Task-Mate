class Urls {
  static String baseUrl = 'http://152.42.163.176:2006/api/v1';
  static String registration = '$baseUrl/Registration';
  static String login = '$baseUrl/Login';
  static String recoverVerifyEmail = '$baseUrl/RecoverVerifyEmail/';
  static String recoverVerifyOtp = '$baseUrl/RecoverVerifyOtp/';
  static String recoverResetPassword = '$baseUrl/RecoverResetPassword';
  static String createTask = '$baseUrl/createTask';
  static String getNewTask = '$baseUrl/listTaskByStatus/New';
  static String getCompletedTask = '$baseUrl/listTaskByStatus/Completed';
  static String getCancelledTask = '$baseUrl/listTaskByStatus/Cancelled';
  static String getProgressTask = '$baseUrl/listTaskByStatus/Progress';
  static String getDeleteTask = '$baseUrl/deleteTask/';
}
