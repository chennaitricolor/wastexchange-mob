class Constants {
  static const APP_TITLE = 'India Waste Exchange';
  static const GENERIC_ERROR_MESSAGE =
      'Something went wrong. Please try again.';

  //Currency
  static const INR_UNICODE = '\u20B9';

  //login screen
  static const LOGIN_BUTTON = 'LOGIN';
  static const LOGIN_FORGOT_PASSWORD = 'Forgot Password?';
  static const LOGIN_UNAPPROVED = 'Your registration is not approved yet.';

  //registration screen
  static const FIELD_ALTERNATE_NUMBER = 'Alternate Number';
  static const FIELD_PINCODE = 'Pincode';
  static const FIELD_CITY = 'City';
  static const FIELD_ADDRESS = 'Address';
  static const FIELD_CONFIRM_PASSWORD = 'Confirm Password';
  static const FIELD_MOBILE = 'Mobile number';
  static const FIELD_NAME = 'Name';

  //field ids
  static const ID_ALTERNATE_NUMBER = 'alternate_number';
  static const ID_PINCODE = 'pincode';
  static const ID_CITY = 'city';
  static const ID_ADDRESS = 'address';
  static const ID_PASSWORD = 'password';
  static const ID_CONFIRM_PASSWORD = 'confirm_password';
  static const ID_MOBILE = 'mobile_number';
  static const ID_EMAIL = 'email_address';
  static const ID_NAME = 'name';
  static const ID_OTP = 'otp';

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
  static const LOADING = 'Loading';

  // user type
  static const USER_SELLER = 'seller';

  // Map configuration
  static const double CHENNAI_LAT = 12.9838;
  static const double CHENNAI_LONG = 80.2459;
  static const double DEFAULT_MAP_ZOOM = 12;
  static const String MAP_LOADING_FAILED = 'Failed to load map';

  //Seller Information Screen
  static const String CHECKOUT = 'Checkout';

  // Seller Details Drawer
  static const String LOGIN_TO_BUY = 'Login to buy';
  static const String BID_TO_BUY = 'Bid to buy';
  static const String ANNOUNCEMENT_MESSAGE =
      '''We have listed all 210 Resource recovery points of Chennai Corporation. Buyers registration is increasing every day. Soon Platform will be open to all sellers.''';
  static const String USER_ENCOURAGE_LOGIN_MESSAGE =
      '''Join us and be a part of our effort to make Chennai an efficient net Zero Waste City.''';
  static const String TAP_SELLER_FOR_DETAILS =
      'Tap on a blue pin\nto view seller inventory';
  static const String ITEMS_UNAVAILABLE = 'No items available';
  static const String SELLER_DETAILS_FETCH_FAILED =
      'Failed to get seller information';
  static const String PROFILE_FETCH_FAILED =
      'Failed to get profile information';
  static const String USER_FETCH_FAILED = 'Failed to get user information';

  //Buyer's bid form
  static const TITLE_ORDER_FORM = 'Order Form';
  static const FIELD_CONTACT_NAME = 'Contact name';
  static const FIELD_PICKUP_DATE = 'Pick up date';
  static const FIELD_PICKUP_TIME = 'Pick up time';
  static const FIELD_CONTACT_NAME_ERROR_MSG = 'Please enter contact name';
  static const FIELD_PICKUP_DATE_ERROR_MSG = 'Please enter pick up date';
  static const FIELD_PICKUP_TIME_ERROR_MSG = 'Please enter pick up time';
  static const CONFIRM_BUTTON = 'Confirm';
  static const MY_BIDS = 'Current Orders';
  static const PICKUP_AT = 'Pickup: ';
  static const LANGUAGE_SETTINGS = 'Choose Preferred Language';
  static const BUTTON_CANCEL = 'Cancel';
  static const BUTTON_CANCEL_BID = 'Cancel Bid';
  static const BUTTON_EDIT_BID = 'Edit Bid';

  static const BUTTON_HOME = 'Home';
  static const BUTTON_VIEW_ALL_BIDS = 'View All Bids';

  static const BIDS_FETCH_FAILED = 'Failed to get bids';
  static const NO_BIDS_MESSAGE = 'You do not have any bids';
  static const BID_CREATE_FAILED = 'Failed to create bid';
  static const BID_EDIT_FAILED = 'Failed to edit bids';

  static const BUTTON_SUBMIT = 'Submit';

  //error
  static const NO_INTERNET_CONNECTION = 'No Internet connection';
}
