import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/models/item.dart';
import 'package:wastexchange_mobile/utils/app_colors.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';
import 'package:wastexchange_mobile/utils/constants.dart';
import 'package:wastexchange_mobile/widgets/views/card_view.dart';

class SellerItemRow extends Row {

   SellerItemRow({this.text, this.hintText, this.textEditingController}) : super(
     mainAxisAlignment:
     MainAxisAlignment.spaceBetween,
     children: <Widget>[
       Flexible(
         flex: 3,
         child: Text(
             text,
             style: AppTheme.subtitle
         ),
       ),
       Flexible(
         flex: 1,
         child: TextFormField(
           controller: textEditingController,
           keyboardType: TextInputType.number,
           decoration: InputDecoration(
             hintText: hintText,
           ),
         ),
       ),
     ],
   );

   final TextEditingController textEditingController;
   final String text;
   final String hintText;

}
