class API {
  static const String prod = 'http://34.72.136.54:4067/api/v1';
  static const String dev = 'http://34.72.136.54:4067/api/v1';

  static const base = dev;

  static const String signIn = '/auth/login';
  static const String signUp = '/auth/signUp';
  static const String verifyOtp = '/auth/verifyOtp';
  static const String resendOtp = '/auth/resend-otp';
  static const String forgotPassword = '/auth/forget-password';
  static const String setNewPassword = '/auth/set-new-password';
  static const String changePassword = '/users/change-password';
  static const String updateProfile = '/users/profile/update';
  static const String user = '/users/';
  static const String logOut = '/auth/logout';
}
