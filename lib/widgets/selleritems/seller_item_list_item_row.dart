import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';
import 'package:wastexchange_mobile/utils/global_utils.dart';

class SellerItemRow extends Row {
  SellerItemRow(
      {@required this.isEditable, @required this.text, @required this.hintText, @required this.textEditingController})
      : assert(isNotNull(isEditable), 'A non-null Boolean must be provided to editable'),
        assert(isNotNull(hintText), 'The hint text should not be null'),
        assert(isNotNull(text), 'The text should not be null'),
        assert(textEditingController != null, 'The text editing controller should not be null'),
        super(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              flex: 3,
              child: Text(text, style: AppTheme.body1),
            ),
            Flexible(
                flex: 1,
                child: isEditable ?
                TextFormField(
                  controller: textEditingController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: hintText,
                  ),
                ) : Align(
                    alignment: Alignment.centerLeft,
                    child: Text(hintText, style: AppTheme.body1))
            ),
          ],
        );

  final TextEditingController textEditingController;
  final String text;
  final String hintText;
  final bool isEditable;
}
