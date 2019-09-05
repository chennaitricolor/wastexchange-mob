import 'package:test/test.dart';
import 'package:wastexchange_mobile/models/seller_item_details_response.dart';

void main() {
  test('sellerId key missing', () {
    expect(() => SellerItemDetails.fromJson({'id': 1}),
        throwsA(const TypeMatcher<ArgumentError>()));
  });

  test('id key missing', () {
    expect(() => SellerItemDetails.fromJson({'sellerId': 1}),
        throwsA(const TypeMatcher<ArgumentError>()));
  });

  test('details key missing', () {
    final SellerItemDetails details =
        SellerItemDetails.fromJson({'id': 1, 'sellerId': 2});
    expect(details.items.isEmpty, true);
  });

  test('valid', () {
    expect(SellerItemDetails.fromJson({'id': 1, 'sellerId': 2, 'details': {}}),
        const TypeMatcher<SellerItemDetails>());
  });
}
