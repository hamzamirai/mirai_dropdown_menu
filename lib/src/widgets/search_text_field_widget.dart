/*
* Created By Mirai Devs.
* On 9/10/2023.
*/

import 'package:flutter/material.dart';
import 'package:mirai_dropdown_menu/src/utils/mirai_outline_input_border.dart';

class SearchTextFieldWidget extends StatelessWidget {
  const SearchTextFieldWidget({
    super.key,
    required this.searchController,
    required this.searchDecoration,
    required this.searchValidator,
    required this.onChanged,
    required this.searchTextFormFieldStyle,
  });

  final TextEditingController? searchController;
  final InputDecoration? searchDecoration;
  final FormFieldValidator<String>? searchValidator;
  final ValueChanged<String>? onChanged;
  final TextStyle? searchTextFormFieldStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 8,
      ),
      child: TextFormField(
        controller: searchController,
        textAlignVertical: TextAlignVertical.center,
        style: searchTextFormFieldStyle ??
            Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).primaryColorDark,
                ),
        cursorColor: Theme.of(context).primaryColorDark,
        decoration: searchDecoration ??
            InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.all(12),
              hintText: 'Search...',
              border: miraiOutlineInputBorderForTextField(),
            ),
        validator: searchValidator,
        textInputAction: TextInputAction.done,
        onFieldSubmitted: (_) {},
        onChanged: onChanged,
        // onChanged: (String text) {
        //   searchSubscription(text);
        // },
      ),
    );
  }
}
