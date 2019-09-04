import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:wastexchange_mobile/blocs/sellert_Item_bloc.dart';
import 'package:wastexchange_mobile/models/item.dart';
import 'package:wastexchange_mobile/screens/seller_item_screen.dart';

class MockSellerItemListener extends Mock implements SellerItemListener {}

void main() {

  MockSellerItemListener mockSellerItemListener;

  setUp(() {
      mockSellerItemListener = MockSellerItemListener();
  });

  test('GIVEN items as null, THEN return quantity text editing controller as null', () async {
    final SellerItemBloc sellerItemBloc = SellerItemBloc(mockSellerItemListener, null);

    final textEditingController = sellerItemBloc.quantityTextEditingController(0);
    expect(textEditingController, null);
  });

  test('GIVEN items as empty, THEN return quantity text editing controller as null WHEN the text editing controllers size is empty', () async {
    final SellerItemBloc sellerItemBloc = SellerItemBloc(mockSellerItemListener, []);

    final quantityTextEditingController = sellerItemBloc.quantityTextEditingController(2);
    expect(quantityTextEditingController, null);
  });

  test('GIVEN items with size one, THEN return quantity text editing controller as null WHEN the text editing controllers size is one, but indx is more than the size', () async {
    final SellerItemBloc sellerItemBloc = SellerItemBloc(mockSellerItemListener, [Item()]);

    final quantityTextEditingController = sellerItemBloc.quantityTextEditingController(2);
    expect(quantityTextEditingController, null);
  });

  test('GIVEN items with size one, THEN return quantity text editing controller WHEN the text editing controllers is of size one', () async {
    final SellerItemBloc sellerItemBloc = SellerItemBloc(mockSellerItemListener, [Item()]);

    final quantityTextEditingController = sellerItemBloc.quantityTextEditingController(0);
    expect(quantityTextEditingController, isA<TextEditingController>());
    expect(quantityTextEditingController, isNotNull);
  });

  test('GIVEN items as null, THEN return price text editing controller as null', () async {
    final SellerItemBloc sellerItemBloc = SellerItemBloc(mockSellerItemListener, null);

    final textEditingController = sellerItemBloc.priceTextEditingController(0);
    expect(textEditingController, null);
  });

  test('GIVEN items as empty, THEN return price text editing controller as null WHEN the text editing controllers size is empty', () async {
    final SellerItemBloc sellerItemBloc = SellerItemBloc(mockSellerItemListener, []);

    final priceTextEditingController = sellerItemBloc.priceTextEditingController(2);
    expect(priceTextEditingController, null);
  });

  test('GIVEN items with size one, THEN return price text editing controller as null WHEN the text editing controllers size is one, but indx is more than the size', () async {
    final SellerItemBloc sellerItemBloc = SellerItemBloc(mockSellerItemListener, [Item()]);

    final priceTextEditingController = sellerItemBloc.priceTextEditingController(2);
    expect(priceTextEditingController, null);
  });

  test('GIVEN items with size one, THEN return price text editing controller WHEN the text editing controllers is of size one', () async {
    final SellerItemBloc sellerItemBloc = SellerItemBloc(mockSellerItemListener, [Item()]);

    final priceTextEditingController = sellerItemBloc.priceTextEditingController(0);
    expect(priceTextEditingController, isA<TextEditingController>());
    expect(priceTextEditingController, isNotNull);
  });

  test('GIVEN items as null, THEN show empty validation error', () async {
    final SellerItemBloc sellerItemBloc = SellerItemBloc(mockSellerItemListener, null);

    sellerItemBloc.onSubmitBids();
    final capturedData = verify(mockSellerItemListener.onValidationError(captureAny)).captured.single;

    expect(capturedData, 'Please fill all the values');
  });

  test('GIVEN items as null, THEN show empty validation error', () async {
    final SellerItemBloc sellerItemBloc = SellerItemBloc(mockSellerItemListener, null);

    sellerItemBloc.onSubmitBids();
    final capturedData = verify(mockSellerItemListener.onValidationError(captureAny)).captured.single;

    expect(capturedData, 'Please fill all the values');
  });
}
