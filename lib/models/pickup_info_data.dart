class PickupInfoData {
  PickupInfoData({this.pickupDate, this.contactName}) {
    ArgumentError.checkNotNull(pickupDate);
    ArgumentError.checkNotNull(contactName);
  }
  final DateTime pickupDate;
  final String contactName;
}
