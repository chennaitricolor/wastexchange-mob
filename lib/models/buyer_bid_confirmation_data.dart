import 'package:wastexchange_mobile/models/bid_item.dart';

String buyerBidDataToJson(dynamic data) => data.toJson();

class BuyerBidData {
  BuyerBidData(
      {this.id,
      this.sellerId,
      this.totalBid,
      this.pDateTime,
      this.contactName,
      this.status,
      this.bidItems});

  int id;
  List<BidItem> bidItems;
  int sellerId;
  int totalBid;
  DateTime pDateTime;
  String contactName;
  String status;
}
