import 'package:wastexchange_mobile/models/bid_item.dart';

String buyerBidDataToJson(dynamic data) => data.toJson();

class BuyerBidData {
  BuyerBidData(
      {this.sellerId,
      this.totalBid,
      this.pDateTime,
      this.contactName,
      this.status,
      this.bidItems});

  List<BidItem> bidItems;
  int sellerId;
  int totalBid;
  DateTime pDateTime;
  String contactName;
  String status;

  Map<String, dynamic> toMap() => {
        'details': bidItems.map((item) => item.toJson()).toList().toString(),
        'sellerId': 1497,
        'buyerId': 2,
        'totalBid': 15,
        'pDateTime': pDateTime.toUtc().toString(),
        'contactName': contactName,
        'status': 'pending',
      };
}
