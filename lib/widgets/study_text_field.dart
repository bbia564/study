import 'package:flutter/material.dart';

class StudyTextField extends StatelessWidget {
  final Function(String) onChange;
  final String hintText;
  final String value;
  final bool readOnly;
  final int? maxLength;
  final int? maxLines;
  final TextInputType keyboardType;
  final FocusNode? focusNode;
  final TextEditingController? textEditingController;
  final TextStyle? textStyle;
  final TextStyle? hintTextStyle;
  final TextAlign textAlign;
  final EdgeInsets? padding;

  const StudyTextField({
    super.key,
    required this.onChange,
    this.hintText = 'Please input',
    this.value = '',
    this.readOnly = false,
    this.maxLength,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.focusNode,
    this.textEditingController,
    this.textStyle,
    this.hintTextStyle,
    this.textAlign = TextAlign.start,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final ctr = TextEditingController(text: value);
    ctr.selection =
        TextSelection.fromPosition(TextPosition(offset: ctr.text.length));
    return Container(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 12),
      alignment: Alignment.center,
      color: Colors.transparent,
      child: TextField(
        maxLength: maxLength,
        keyboardType: keyboardType,
        readOnly: readOnly,
        controller: textEditingController ?? ctr,
        maxLines: maxLines,
        textAlign: textAlign,
        decoration: InputDecoration(
          counterText: '',
          hintText: hintText,
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          isDense: true,
          isCollapsed: false,
          hintStyle: hintTextStyle ??
              const TextStyle(
                color: Color(0xffadadad),
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
        ),
        style: textStyle ??
            const TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
        onChanged: (v) {
          onChange.call(v);
        },
      ),
    );
  }
}

