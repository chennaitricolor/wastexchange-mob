import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:wastexchange_mobile/blocs/sellert_Item_bloc.dart';
import 'package:wastexchange_mobile/models/bid_item.dart';
import 'package:wastexchange_mobile/models/item.dart';
import 'package:wastexchange_mobile/models/seller_info.dart';
import 'package:wastexchange_mobile/screens/seller_item_screen.dart';

class MockSellerItemListener extends Mock implements SellerItemListener {}

void main() {
  MockSellerItemListener mockSellerItemListener;

  setUp(() {
    mockSellerItemListener = MockSellerItemListener();
  });

  test(
      'GIVEN items as null, WHEN quantity and price values are null, THEN show validation empty message',
      () async {
    final SellerItemBloc sellerItemBloc =
        SellerItemBloc(mockSellerItemListener, null);

    sellerItemBloc.onSubmitBids(null, null);

    final errorMessage =
        verify(mockSellerItemListener.onValidationEmpty(captureAny))
            .captured
            .single;

    expect(errorMessage, 'Please fill all the values');
  });

  test(
      'GIVEN items as empty, WHEN quantity and price values are null, THEN show validation empty message',
      () async {
    final SellerItemBloc sellerItemBloc = SellerItemBloc(
        mockSellerItemListener, SellerInfo(items: [], seller: null));

    sellerItemBloc.onSubmitBids(null, null);

    final errorMessage =
        verify(mockSellerItemListener.onValidationEmpty(captureAny))
            .captured
            .single;

    expect(errorMessage, 'Please fill all the values');
  });

  test(
      'GIVEN items as size one, WHEN quantity and price values are null, THEN show validation empty message',
      () async {
    final SellerItemBloc sellerItemBloc = SellerItemBloc(
        mockSellerItemListener, SellerInfo(items: [Item()], seller: null));

    sellerItemBloc.onSubmitBids(null, null);

    final errorMessage =
        verify(mockSellerItemListener.onValidationEmpty(captureAny))
            .captured
            .single;

    expect(errorMessage, 'Please fill all the values');
  });

  test(
      'GIVEN items as size one, WHEN quantity is empty and price is null, THEN show validation empty message',
      () async {
    final SellerItemBloc sellerItemBloc = SellerItemBloc(
        mockSellerItemListener, SellerInfo(items: [Item()], seller: null));

    sellerItemBloc.onSubmitBids([], null);

    final errorMessage =
        verify(mockSellerItemListener.onValidationEmpty(captureAny))
            .captured
            .single;

    expect(errorMessage, 'Please fill all the values');
  });

  test(
      'GIVEN items as size one, WHEN quantity has value 0 and price is null THEN show validation error message',
      () async {
    final SellerItemBloc sellerItemBloc = SellerItemBloc(
        mockSellerItemListener, SellerInfo(items: [Item()], seller: null));

    sellerItemBloc.onSubmitBids(['0'], null);

    final errorMessage =
        verify(mockSellerItemListener.onValidationError(captureAny))
            .captured
            .single;

    expect(errorMessage, 'It is mandatory to provide both quantity and price');
  });

  test(
      'GIVEN items as size one, WHEN quantity has valid text and price is null THEN show validation error message',
      () async {
    final SellerItemBloc sellerItemBloc = SellerItemBloc(
        mockSellerItemListener, SellerInfo(items: [Item()], seller: null));

    sellerItemBloc.onSubmitBids(['something'], null);

    final errorMessage =
        verify(mockSellerItemListener.onValidationError(captureAny))
            .captured
            .single;

    expect(errorMessage, 'It is mandatory to provide both quantity and price');
  });

  test(
      'GIVEN items as size one, WHEN quantity has valid text and price is null THEN show validation error message',
      () async {
    final SellerItemBloc sellerItemBloc = SellerItemBloc(
        mockSellerItemListener, SellerInfo(items: [Item()], seller: null));

    sellerItemBloc.onSubmitBids(['something'], []);

    final errorMessage =
        verify(mockSellerItemListener.onValidationError(captureAny))
            .captured
            .single;

    expect(errorMessage, 'It is mandatory to provide both quantity and price');
  });

  test(
      'GIVEN items as size one, WHEN quantity has valid text and price has value 0 THEN show validation error message',
      () async {
    final SellerItemBloc sellerItemBloc = SellerItemBloc(
        mockSellerItemListener, SellerInfo(items: [Item()], seller: null));

    sellerItemBloc.onSubmitBids(['something'], ['0']);

    final errorMessage =
        verify(mockSellerItemListener.onValidationError(captureAny))
            .captured
            .single;

    expect(errorMessage, 'It is mandatory to provide both quantity and price');
  });

  test(
      'GIVEN items as size one, WHEN quantity and price is empty THEN show validation empty message',
      () async {
    final SellerItemBloc sellerItemBloc = SellerItemBloc(
        mockSellerItemListener, SellerInfo(items: [Item()], seller: null));

    sellerItemBloc.onSubmitBids([], []);

    final errorMessage =
        verify(mockSellerItemListener.onValidationEmpty(captureAny))
            .captured
            .single;

    expect(errorMessage, 'Please fill all the values');
  });

  test(
      'GIVEN items as size one, WHEN quantity and price has value 0 THEN show validation error message',
      () async {
    final SellerItemBloc sellerItemBloc = SellerItemBloc(
        mockSellerItemListener, SellerInfo(items: [Item()], seller: null));

    sellerItemBloc.onSubmitBids(['0'], ['0']);

    final errorMessage =
        verify(mockSellerItemListener.onValidationError(captureAny))
            .captured
            .single;

    expect(errorMessage, 'It is mandatory to provide both quantity and price');
  });

  test(
      'GIVEN items as more than one, WHEN quantity is null and price has valid value for second item THEN show validation error message',
      () async {
    final SellerItemBloc sellerItemBloc = SellerItemBloc(mockSellerItemListener,
        SellerInfo(items: [Item(), Item()], seller: null));

    sellerItemBloc.onSubmitBids([null, null], [null, '2']);

    final errorMessage =
        verify(mockSellerItemListener.onValidationError(captureAny))
            .captured
            .single;

    expect(errorMessage, 'It is mandatory to provide both quantity and price');
  });

  test(
      'GIVEN items as more than one, WHEN quantity is empty and price has valid value for second item THEN show validation error message',
      () async {
    final SellerItemBloc sellerItemBloc = SellerItemBloc(mockSellerItemListener,
        SellerInfo(items: [Item(), Item()], seller: null));

    sellerItemBloc.onSubmitBids([null, ''], [null, '2']);

    final errorMessage =
        verify(mockSellerItemListener.onValidationError(captureAny))
            .captured
            .single;

    expect(errorMessage, 'It is mandatory to provide both quantity and price');
  });

  test(
      'GIVEN items as more than one, WHEN quantity has valid value and price is null for second item THEN show validation error message',
      () async {
    final SellerItemBloc sellerItemBloc = SellerItemBloc(mockSellerItemListener,
        SellerInfo(items: [Item(), Item()], seller: null));

    sellerItemBloc.onSubmitBids([null, '2'], [null, null]);

    final errorMessage =
        verify(mockSellerItemListener.onValidationError(captureAny))
            .captured
            .single;

    expect(errorMessage, 'It is mandatory to provide both quantity and price');
  });

  test(
      'GIVEN items as more than one, WHEN quantity has valid value and price is empty for second item THEN show validation error message',
      () async {
    final SellerItemBloc sellerItemBloc = SellerItemBloc(mockSellerItemListener,
        SellerInfo(items: [Item(), Item()], seller: null));

    sellerItemBloc.onSubmitBids([null, '2'], [null, '']);

    final errorMessage =
        verify(mockSellerItemListener.onValidationError(captureAny))
            .captured
            .single;

    expect(errorMessage, 'It is mandatory to provide both quantity and price');
  });

  test(
      'GIVEN items as more than one, WHEN both quantity and price are not null, BUT quantity data type is not double for second item THEN show validation error message',
      () async {
    final SellerItemBloc sellerItemBloc = SellerItemBloc(mockSellerItemListener,
        SellerInfo(items: [Item(), Item()], seller: null));

    sellerItemBloc.onSubmitBids([null, 'not a double value'], [null, '']);

    final errorMessage =
        verify(mockSellerItemListener.onValidationError(captureAny))
            .captured
            .single;

    expect(errorMessage, 'It is mandatory to provide both quantity and price');
  });

  test(
      'GIVEN items as more than one, WHEN both quantity and price are not null, BUT price data type is not double for second item THEN show validation error message',
      () async {
    final SellerItemBloc sellerItemBloc = SellerItemBloc(mockSellerItemListener,
        SellerInfo(items: [Item(), Item()], seller: null));

    sellerItemBloc.onSubmitBids([null, ''], [null, 'not a double value']);

    final errorMessage =
        verify(mockSellerItemListener.onValidationError(captureAny))
            .captured
            .single;

    expect(errorMessage, 'It is mandatory to provide both quantity and price');
  });

  test(
      'GIVEN items as size one, WHEN both quantity and price has valid content THEN validation is success and bid items has size one',
      () async {
    final SellerItemBloc sellerItemBloc = SellerItemBloc(mockSellerItemListener,
        SellerInfo(items: [Item(), Item()], seller: null));

    sellerItemBloc.onSubmitBids([null, '2'], [null, '2']);

    final Map<String, dynamic> sellerInfo = verify(
            mockSellerItemListener.onValidationSuccess(sellerInfo: captureAny))
        .captured
        .single;

    expect(sellerInfo['bidItems'].length, 1);
  });

  test(
      'GIVEN items as more than one size, WHEN both quantity and price has valid content in first item, BUT invalid some invalid on second item THEN show validation error message',
      () async {
    final SellerItemBloc sellerItemBloc = SellerItemBloc(mockSellerItemListener,
        SellerInfo(items: [Item(), Item()], seller: null));

    sellerItemBloc.onSubmitBids([null, '2'], [null, null]);

    final errorMessage =
        verify(mockSellerItemListener.onValidationError(captureAny))
            .captured
            .single;

    expect(errorMessage, 'It is mandatory to provide both quantity and price');
  });
}
