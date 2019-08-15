class Bid {
  Bid(this.orderNumber, this.orderDate, this.seller, this.amount,
      this.pickupDate, this.bidStatus);

  String orderNumber;
  DateTime orderDate;
  String seller;
  double amount;
  DateTime pickupDate;
  BidStatus bidStatus;
}

enum BidStatus { cancelled, pending, successful }
