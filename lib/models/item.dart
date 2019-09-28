import 'dart:convert';

import 'package:wastexchange_mobile/utils/global_utils.dart';

bool isValidItem(dynamic json) =>
    isNotNull(json['quantity']) && isNotNull(json['cost']);

Item itemFromJson(String itemName, dynamic json) =>
    Item.fromJson(itemName, json);

String itemToJson(Item data) => json.encode(data.toJson());

class Item {
  // TODO(Sayeed): Return null if required field is missing
  Item({
    this.name,
    this.displayName,
    this.qty,
    this.price,
  }) {
    ArgumentError.checkNotNull(qty);
    ArgumentError.checkNotNull(price);
  }

  factory Item.fromJson(String itemName, Map<dynamic, dynamic> json) {
    return Item(
      name: itemName,
      displayName: itemDisplayNames[itemName],
      qty: json['quantity'],
      price: json['cost'],
    );
  }

  static Map<String, String> itemDisplayNames = {
    'hdp': 'HDP Waste',
    'shreddedPlastic': 'Shredded Plastic',
    'coconutShells': 'Coconut Shells',
    'cocoPit': 'Coco Pit',
    'slippers': 'Slippers',
    'foams': 'Foams',
    'thermocol': 'Thermocol',
    'bags': 'Bags',
    'mlp': 'Multi Level Plastic',
    'plasticBottles': 'Plastic Bottles',
    'glassBottles': 'Glass Bottles',
    'clothes': 'Clothes',
    'rubber': 'Tyre / Rubber',
    'lights': 'Tube / LED Lights',
    'compost': 'Compost (Manure)',
    'vermiCompost': 'Vermi Compost'
  };

  String name;
  String displayName;
  double qty;
  int price;

  Map<String, dynamic> toJson() => {
        'qty': qty,
        'price': price,
      };
}
