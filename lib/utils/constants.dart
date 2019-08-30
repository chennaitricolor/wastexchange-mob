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
  static const SEND_OTP_FAIL = 'Send OTP failed';
  static const SEND_OTP_SUCCESS = 'OTP sent';
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

  //Seller Information Screen
  static const String CHECKOUT = 'Checkout';

  // Seller Details Drawer
  static const String LOGIN_TO_BUY = 'Login to buy';
  static const String BID_TO_BUY = 'Bid to buy';
  static const String ANNOUNCEMENT_MESSAGE =
      '''We have listed all 210 Resource recovery points of Chennai Corporation. Buyers registration is increasing every day. Soon Platform will be open to all sellers.''';
  static const String USER_ENCOURAGE_LOGIN_MESSAGE =
      '''Join us and be a part of our effort to make Chennai an efficient net Zero Waste City.''';
  static const String TAP_SELLER_FOR_DETAILS = 'Tap on a seller to view their inventory details';

  // Response codes //TODO:: Move to enum, seems like dart does not support type enums out of the box
  static const int SUCCESS = 200;
  static const int MULTIPLE_CHOICE = 300;
  static const int BAD_REQUEST = 400;
  static const int UNAUTHORIZED = 401;
  static const int FORBIDDEN = 403;
  static const int NOT_FOUND = 404;
  static const int INTERNAL_SERVER_ERROR = 500;

  //Buyer's bid form
  static const TITLE_BUYER_BID = 'Buyer\'s Bid';
  static const DATE_FORMAT = 'yyyy-MM-dd';
  static const TIME_FORMAT = 'HH:mm a';
  static const FIELD_CONTACT_NAME = 'Contact name';
  static const FIELD_PICKUP_DATE = 'Pick up date';
  static const FIELD_PICKUP_TIME = 'Pick up time';
  static const FIELD_CONTACT_NAME_ERROR_MSG = 'Please enter contact name';
  static const FIELD_PICKUP_DATE_ERROR_MSG = 'Please enter pick up date';
  static const FIELD_PICKUP_TIME_ERROR_MSG = 'Please enter pick up time';
  static const BUTTON_HOME_PAGE = 'Home page';
  static const BUTTON_LIST_OF_BIDS = 'List of bids';
  static const BID_SUCCESS_MSG = 'Bid successful';
  static const BUTTON_SUBMIT = 'Submit';
}
