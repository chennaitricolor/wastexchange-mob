class Bid{
  String orderNumber;
  DateTime orderDate;
  String seller;
  double amount;
  DateTime pickupDate;
  BidStatus bidStatus;

  Bid(this.orderNumber, this.orderDate, this.seller, this.amount, this.pickupDate, this.bidStatus);
}

enum BidStatus {
  cancelled, pending, successful
}