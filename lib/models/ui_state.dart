//source: https://medium.com/flutter-community/handling-network-calls-like-a-pro-in-flutter-31bd30c86be1

import 'package:wastexchange_mobile/utils/global_utils.dart';

enum UIStatus { LOADING, ERROR, COMPLETED }

class UIState<Data, Error> {
  UIState.loading(this.message) : status = UIStatus.LOADING;
  UIState.error(this.error)
      : status = UIStatus.ERROR,
        assert(isNotNull(error));
  UIState.completed(this.data)
      : status = UIStatus.COMPLETED,
        assert(isNotNull(data));

  UIStatus status;
  Data data;
  Error error;
  String message;
}
