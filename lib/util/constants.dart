class Constants {
  static const APP_TITLE = 'India Waste Exchange';
  static const LOGO_SMART_CITY = 'assets/images/smart-city-logo.png';
  
  //Currency
  static const INR_UNICODE = '\u20B9';
  
  //login screen
  static const LOGIN_BUTTON = 'LOGIN';
  static const LOGIN_FORGOT_PASSWORD = 'Forgot Password?';
  static const LOGIN_NOT_MEMBER = 'Not a member ? ';
  static const SIGNUP_BUTTON = 'Join now';
  static const LOGIN_FAILED = 'Login failed';

  //registration screen
  static const FIELD_ALTERNATE_NUMBER = 'Alternate Number';
  static const FIELD_PINCODE = 'Pincode';
  static const FIELD_CITY = 'City';
  static const FIELD_ADDRESS = 'Address';
  static const FIELD_PASSWORD = 'Password';
  static const FIELD_CONFIRM_PASSWORD = 'Confirm Password';
  static const FIELD_MOBILE = 'Mobile number';
  static const FIELD_EMAIL = 'Email address';
  static const FIELD_NAME = 'Name';

  //OTP screen
  static const FIELD_OTP = 'OTP';
  static const OTP_TITLE = 'OTP Sent';
  static const OTP_MESSAGE =
      'Please enter the OTP sent to your mobile number / Email';
  static const RESEND_OTP = 'Resend OTP';
  static const RESEND_OTP_FAIL = 'Resend OTP failed';
  static const RESEND_OTP_SUCCESS = 'OTP sent';
  static const REGISTRATION_FAILED = 'Registration failed';

  //Forgot password screen
  static const FORGOT_TITLE = 'Forgot Password';
  static const FORGOT_MESSAGE = 'Please enter your registered email ID';

  // Loading messages
  static const LOADING_LOGIN = 'Logging In';
  static const LOADING_OTP = 'Sending OTP';
  static const LOADING_REGISTRATION = 'Registration OTP';

  // user type
  static const USER_SELLER = 'seller';

  // Map configuration
  static const double CHENNAI_LAT = 12.9838;
  static const double CHENNAI_LONG = 80.2459;
  static const double DEFAULT_ZOOM = 15;

  // Response codes
  static const int UNAUTHORIZED = 401;
  static const int FORBIDDEN = 403;
}
