import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';

class SellerItemRow extends Row {
  SellerItemRow(
      {this.isEditable, this.text, this.hintText, this.textEditingController})
      : super(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              flex: 3,
              child: Text(text, style: AppTheme.body1),
            ),
            Flexible(
              flex: 1,
              child: isEditable != null && isEditable
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child: Text(hintText, style: AppTheme.body1))
                  : TextFormField(
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
  final bool isEditable;
}
