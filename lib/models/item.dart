import 'dart:convert';

//Removing json.decoded(str) since the string is already decoded by the parent.
Item itemFromJson(String itemName, dynamic str) => Item.fromJson(str, itemName);

String itemToJson(Item data) => json.encode(data.toJson());

class Item {
  // TODO(Sayeed): Return null if required field is missing
  Item({
    this.name,
    this.displayName,
    this.qty,
    this.price,
  });

  factory Item.fromJson(Map<dynamic, dynamic> json, String itemName) {
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
