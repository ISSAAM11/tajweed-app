import 'package:flutter/services.dart';

import '../../../base/screens/exports.dart';

enum FormInputType { normal, password, email, phoneNumber }

enum InputTheme { light, dark }

class FormInput extends StatefulWidget {
  const FormInput({   
    super.key,
    this.theme = InputTheme.light,
    this.type = FormInputType.normal,
    this.fillColor,
    this.initialValue,
    this.enabled = true,
    this.controller,
    this.keyboardType,
    this.prefixIcon,
    this.prefixWidget,
    this.prefixConstraints,
    this.suffixIcon,
    this.suffixIconRightPadding = 0,
    this.label,
    this.hint,
    this.hintColor,
    this.minLines = 1,
    this.maxLines = 1,
    this.maxLength,
    this.onChanged,
    this.validator,
    this.focusNode,
    this.nextFocusNode,
    this.displayCounter = false,
    this.isCollapsed = false,
    this.textCapitalization = TextCapitalization.none,
    this.expands = false,
    this.inputFormatters,
    this.textAlign,
    this.style,
    this.centerLabel = false,
    this.onFieldSubmitted,
  });

  final InputTheme theme;
  final Color? fillColor;

  final String? initialValue;
  final bool enabled;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? prefixWidget;
  final BoxConstraints? prefixConstraints;
  final Widget? suffixIcon;
  final double suffixIconRightPadding;
  final String? label;

  final String? hint;
  final Color? hintColor;
  final bool displayCounter;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final bool isCollapsed;
  final TextCapitalization textCapitalization;
  final bool expands;
  final List<TextInputFormatter>? inputFormatters;

  final FormInputType type;
  final TextAlign? textAlign;
  final TextStyle? style;
  final bool centerLabel;
  final VoidCallback? onFieldSubmitted;

  @override
  createState() => _State();
}

class _State extends State<FormInput> {
  bool _obscure = true;
  bool get lightTheme => widget.theme == InputTheme.light;

  @override
  Widget build(BuildContext context) {
    return switch (widget.type) {
      FormInputType.normal => _contentInput(
          onChanged: widget.onChanged,
          suffixIcon: widget.suffixIcon,
        ),
      FormInputType.password => _contentInput(
          onChanged: widget.onChanged,
          isPassword: true,
          obscure: _obscure,
          suffixIcon: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () => setState(() => _obscure = !_obscure),
            icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility, size: 20),
          ),
        ),
      FormInputType.email => _contentInput(
          onChanged: widget.onChanged,
          suffixIcon: Icon(Icons.email),
          keyboardType: TextInputType.emailAddress,
        ),
      FormInputType.phoneNumber => _contentInput(
          onChanged: widget.onChanged,
          suffixIcon: Icon(Icons.phone),
          keyboardType: TextInputType.phone,
        ),
    };
  }

  TextFormField _contentInput({
    Widget? prefixIcon,
    bool isPassword = false,
    bool obscure = false,
    Widget? suffixIcon,
    TextInputType? keyboardType,
    void Function(String)? onChanged,
  }) {
    return TextFormField(
      cursorColor: lightTheme ? AppColors.primary : AppColors.scaffold,
      enabled: widget.enabled,
      initialValue: widget.initialValue,
      expands: widget.expands,
      textCapitalization: widget.textCapitalization,
      enableInteractiveSelection: true,
      controller: widget.controller,
      // TODO: Re-add when AppFonts class is implemented
      // style: widget.style ?? AppFonts.inter.withColor(lightTheme ? AppColors.textColor : AppColors.scaffold),
      style: widget.style,
      obscureText: obscure,
      minLines: isPassword ? 1 : widget.minLines,
      maxLines: isPassword ? 1 : widget.maxLines,
      maxLength: isPassword ? AppMetrics.inputs.passwordInputMaxLength : widget.maxLength,
      keyboardType: keyboardType ?? (isPassword ? TextInputType.visiblePassword : widget.keyboardType),
      validator: widget.validator,
      autovalidateMode: AppMetrics.inputs.inputsAutovalidationMode,
      focusNode: widget.focusNode,
      onChanged: onChanged ?? widget.onChanged,
      onFieldSubmitted: (_) => widget.onFieldSubmitted?.call(),
      onEditingComplete: () {
        widget.focusNode?.unfocus();
        widget.nextFocusNode?.requestFocus();
      },
      buildCounter: (_, {int? currentLength, int? maxLength, bool? isFocused}) => widget.displayCounter
          ? Text(
              "$currentLength/$maxLength",
              // style: AppFonts.inter.withSize(FontSizes.indication),
              style: widget.style,
            )
          : null,
      inputFormatters: widget.inputFormatters,
      textAlign: widget.textAlign ?? TextAlign.start,
      decoration: InputDecoration(
        
        enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder?.copyWith(
              borderSide: BorderSide(
                color: lightTheme ? AppColors.primary : AppColors.inputBorder,
                width: AppMetrics.inputs.borderWidth,
              ),
            ),
        focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder?.copyWith(
              borderSide: BorderSide(
                color: lightTheme ? AppColors.primary : AppColors.inputBorder,
                width: AppMetrics.inputs.borderWidth,
              ),
            ),
        isDense: true,
        fillColor: widget.fillColor,
        filled: widget.fillColor != null,
        labelText: widget.label,
        labelStyle:
        // TODO: Re-add when AppFonts class is implemented
            // AppFonts.inter.withSize(FontSizes.title).withColor(lightTheme ? AppColors.hint : AppColors.scaffold),
            widget.style,
        floatingLabelBehavior: widget.centerLabel ? FloatingLabelBehavior.always : FloatingLabelBehavior.auto,
        alignLabelWithHint: widget.centerLabel,
        hintText: widget.hint ?? "",
        // TODO: Re-add when AppFonts class is implemented
        //  hintStyle: AppFonts.inter.withColor(widget.hintColor ?? AppColors.hint),
        hintStyle: widget.style,
        // TODO: Re-add when AppFonts class is implemented
        // errorStyle: AppFonts.inter.withColor(AppColors.error),
        errorStyle: widget.style,
        prefixIcon: prefixIcon ?? widget.prefixIcon,
        prefixIconConstraints: widget.prefixConstraints ?? AppMetrics.inputs.prefixIconConstraints,
        prefixIconColor: lightTheme ? AppColors.hint : AppColors.scaffold,
        suffixIcon: suffixIcon,
        suffixIconColor: lightTheme ? AppColors.hint : AppColors.scaffold,
      ),
    );
  }
}
