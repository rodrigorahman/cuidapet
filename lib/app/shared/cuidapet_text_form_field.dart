import 'package:flutter/material.dart';

class CuidapetTextFormField extends TextFormField {
  CuidapetTextFormField({
    TextEditingController controller,
    @required String label,
    FormFieldValidator<String> validator,
  }) : super(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              gapPadding: 0,
            ),
          ),
          validator: validator,
        );
}
