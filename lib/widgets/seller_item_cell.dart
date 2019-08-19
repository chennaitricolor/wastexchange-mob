import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/models/item.dart';
import 'package:wastexchange_mobile/util/app_colors.dart';
import 'package:wastexchange_mobile/util/constants.dart';

class SellerItemCell extends StatelessWidget {
  const SellerItemCell(this.item);

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      item.name,
                      style: TextStyle(fontSize: 16.0, color: AppColors.secondary_text),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Flexible(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.black54),
                            children: [
                              TextSpan(
                                  text: '${item.qty.toString()}',
                                  style: TextStyle(
                                      fontSize: 18.0, color: Colors.brown)),
                              const TextSpan(text: ' kg(s) ('),
                              TextSpan(
                                text: '${Constants.INR_UNICODE} ',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.blueGrey,
                                ),
                              ),
                              TextSpan(
                                  text: item.price.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                      fontSize: 18.0, color: AppColors.text_black)),
                              const TextSpan(text: '/kg)', style: TextStyle(color: AppColors.text_black)),
                            ]),
                      ),
                    ],
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
