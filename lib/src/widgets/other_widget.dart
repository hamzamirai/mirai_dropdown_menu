/*
* Created By Mirai Devs.
* On 9/10/2023.
*/
import 'package:flutter/material.dart';
import 'package:mirai_dropdown_menu/src/utils/mirai_outline_input_border.dart';

class OtherWidget extends StatelessWidget {
  const OtherWidget({
    super.key,
    required this.otherController,
    required this.otherDecoration,
    required this.otherValidator,
    required this.onFieldSubmitted,
    required this.height,
    required this.margin,
    required this.scrollController,
    required this.onTapOtherTextField,
  });

  final TextEditingController? otherController;
  final InputDecoration? otherDecoration;
  final FormFieldValidator<String>? otherValidator;
  final ValueChanged<String>? onFieldSubmitted;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final ScrollController? scrollController;
  final GestureTapCallback? onTapOtherTextField;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 100,
      margin: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 8,
      ),
      child: TextFormField(
        expands: true,
        maxLines: null,
        minLines: null,
        controller: otherController,
        textAlignVertical: TextAlignVertical.top,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).primaryColorDark,
            ),
        cursorColor: Theme.of(context).primaryColorDark,
        decoration: otherDecoration ??
            InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.all(12),
              hintText: 'Other:',
              border: miraiOutlineInputBorderForTextField(),
            ),
        validator: otherValidator,
        textInputAction: TextInputAction.done,
        onFieldSubmitted: onFieldSubmitted,
        onChanged: onFieldSubmitted,
        onTap: onTapOtherTextField,
      ),
    );
  }
}
