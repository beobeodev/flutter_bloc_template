import 'package:flutter/material.dart';
import 'package:flutter_template/common/extensions/context_extension.dart';

class CommonTextFormField extends StatelessWidget {
  const CommonTextFormField({
    super.key,
    this.textController,
    this.isObscure = false,
    this.readOnly = false,
    this.extendField = true,
    this.enabled = true,
    this.isCenterText = false,
    this.hintText,
    this.errorText,
    this.labelText,
    this.initialValue,
    this.borderRadius = 6,
    this.borderColor = Colors.transparent,
    this.focusedBorderColor,
    this.fillColor,
    this.prefixIconColor,
    this.suffixIconColor,
    this.suffixIcon,
    this.prefixIcon,
    this.keyboardType,
    this.validator,
    this.onTap,
    this.onChanged,
    this.onFieldSubmitted,
    this.onTapPrefixIcon,
    this.onTapSuffixIcon,
    this.labelStyle,
    this.focusNode,
  });

  final TextEditingController? textController;

  final bool isObscure;
  final bool readOnly;
  final bool extendField;
  final bool enabled;
  final bool isCenterText;

  final String? hintText;
  final String? errorText;
  final String? labelText;
  final String? initialValue;

  final double borderRadius;

  final Color? focusedBorderColor;
  final Color borderColor;
  final Color? fillColor;
  final Color? prefixIconColor;
  final Color? suffixIconColor;

  final IconData? suffixIcon;
  final IconData? prefixIcon;

  final TextInputType? keyboardType;

  final String? Function(String?)? validator;

  final void Function()? onTap;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final VoidCallback? onTapPrefixIcon;
  final VoidCallback? onTapSuffixIcon;

  final TextStyle? labelStyle;

  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              labelText!,
              style: labelStyle ?? context.textStyles.textFieldLabel,
            ),
          ),
        TextFormField(
          controller: textController,
          focusNode: focusNode,
          textInputAction: TextInputAction.done,
          onChanged: onChanged,
          onTap: onTap,
          validator: validator,
          obscureText: isObscure,
          readOnly: readOnly,
          enableSuggestions: false,
          enabled: enabled,
          keyboardType: keyboardType,
          initialValue: initialValue,
          style: context.textStyles.textField,
          textAlign: isCenterText ? TextAlign.center : TextAlign.start,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: context.textStyles.hintTextField,
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: context.palette.errorButtonLabel,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: focusedBorderColor ?? context.palette.focusedBorderColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: borderColor,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: borderColor,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: context.palette.errorButtonLabel,
              ),
            ),
            // isDense: true,
            filled: true,
            fillColor: fillColor ?? context.palette.textFieldBackground,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            prefixIcon: prefixIcon != null
                ? GestureDetector(
                    onTap: onTapPrefixIcon,
                    behavior: HitTestBehavior.opaque,
                    child: Icon(
                      prefixIcon,
                      color: prefixIconColor,
                    ),
                  )
                : null,
            suffixIcon: suffixIcon != null
                ? GestureDetector(
                    onTap: onTapSuffixIcon,
                    behavior: HitTestBehavior.opaque,
                    child: Icon(
                      suffixIcon,
                      color: suffixIconColor,
                    ),
                  )
                : null,
            helperText: extendField ? '' : null,
            helperStyle: extendField ? context.textStyles.helperTexField : null,
            errorText: errorText == '' || errorText == null ? null : errorText,
            errorStyle: context.textStyles.errorTextField,
          ),
        ),
      ],
    );
  }
}
