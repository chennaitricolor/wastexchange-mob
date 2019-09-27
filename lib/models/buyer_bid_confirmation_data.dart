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
  double totalBid;
  DateTime pDateTime;
  String contactName;
  String status;
}
