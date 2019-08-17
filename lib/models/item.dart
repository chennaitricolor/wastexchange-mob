import 'dart:convert';

//Removing json.decoded(str) since the string is already decoded by the parent.
Item itemFromJson(String itemName, dynamic str) => Item.fromJson(str, itemName);

String itemToJson(Item data) => json.encode(data.toJson());

class Item {
  Item({
    this.name,
    this.qty,
    this.price,
  });

  factory Item.fromJson(Map<dynamic, dynamic> json, String itemName) {
    return Item(
      name: itemName,
      qty: json['quantity'],
      price: json['cost'].toDouble(),
    );
  }

  String name;
  int qty;
  double price;

  Map<String, dynamic> toJson() => {
        'qty': qty,
        'price': price,
      };
}
