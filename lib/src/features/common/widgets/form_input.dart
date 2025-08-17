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
    this.onValidationChanged,
    this.enableRealTimeValidation = true,
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
  final void Function(String?)? onValidationChanged;
  final bool enableRealTimeValidation;

  @override
  createState() => _State();
}

class _State extends State<FormInput> {
  bool _obscure = true;
  bool get lightTheme => widget.theme == InputTheme.light;
  String? _currentValidationError;

  @override
  Widget build(BuildContext context) {
    return switch (widget.type) {
      FormInputType.normal => _contentInput(
        onChanged: _handleOnChanged,
        suffixIcon: widget.suffixIcon,
      ),
      FormInputType.password => _contentInput(
        onChanged: _handleOnChanged,
        prefixIcon: const Icon(Icons.lock_outline),
        isPassword: true,
        obscure: _obscure,
        suffixIcon: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () => setState(() => _obscure = !_obscure),
          icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
        ),
      ),
      FormInputType.email => _contentInput(
        prefixIcon: const Icon(Icons.email_outlined),
        onChanged: _handleOnChanged,
        keyboardType: TextInputType.emailAddress,
      ),
      FormInputType.phoneNumber => _contentInput(
        onChanged: _handleOnChanged,
        suffixIcon: Icon(Icons.phone),
        keyboardType: TextInputType.phone,
      ),
    };
  }

  void _handleOnChanged(String value) {
    widget.onChanged?.call(value);

    if (widget.enableRealTimeValidation && widget.validator != null) {
      final error = widget.validator!(value);
      if (error != _currentValidationError) {
        _currentValidationError = error;
        widget.onValidationChanged?.call(error);
      }
    }
  }

  Widget _contentInput({
    bool isPassword = false,
    bool obscure = false,
    Widget? suffixIcon,
    Widget? prefixIcon,
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
      style: widget.style ?? AppStyles.subtitle.withColor(AppColors.greyDark),
      obscureText: obscure,
      minLines: isPassword ? 1 : widget.minLines,
      maxLines: isPassword ? 1 : widget.maxLines,
      maxLength: isPassword
          ? AppMetrics.inputs.passwordInputMaxLength
          : widget.maxLength,
      keyboardType:
          keyboardType ??
          (isPassword ? TextInputType.visiblePassword : widget.keyboardType),
      validator: widget.validator,
      autovalidateMode: widget.enableRealTimeValidation
          ? AutovalidateMode.onUserInteraction
          : AppMetrics.inputs.inputsAutovalidationMode,
      focusNode: widget.focusNode,
      onChanged: onChanged,
      onFieldSubmitted: (_) => widget.onFieldSubmitted?.call(),
      onEditingComplete: () {
        widget.focusNode?.unfocus();
        widget.nextFocusNode?.requestFocus();
      },
      buildCounter:
          (_, {int? currentLength, int? maxLength, bool? isFocused}) =>
              widget.displayCounter
              ? Text(
                  "$currentLength/$maxLength",
                  style: AppStyles.indication.withColor(AppColors.greyRegular),
                )
              : null,
      inputFormatters: widget.inputFormatters,
      textAlign: widget.textAlign ?? TextAlign.start,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppMetrics.inputs.horizontalContentPadding,
          vertical: AppMetrics.inputs.verticalContentPadding,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.inputBorder,
            width: AppMetrics.inputs.borderWidth,
          ),
          borderRadius: BorderRadius.circular(AppMetrics.inputs.radius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.primary,
            width: AppMetrics.inputs.borderWidth + 0.5,
          ),
          borderRadius: BorderRadius.circular(AppMetrics.inputs.radius),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.error,
            width: AppMetrics.inputs.borderWidth,
          ),
          borderRadius: BorderRadius.circular(AppMetrics.inputs.radius),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.error,
            width: AppMetrics.inputs.borderWidth + 0.5,
          ),
          borderRadius: BorderRadius.circular(AppMetrics.inputs.radius),
        ),
        isDense: true,
        fillColor: widget.fillColor ?? AppColors.greyBackground,
        filled: true,
        labelText: widget.label,
        labelStyle: AppStyles.subtitle.withColor(AppColors.greyRegular),
        floatingLabelBehavior: widget.centerLabel
            ? FloatingLabelBehavior.always
            : FloatingLabelBehavior.auto,
        alignLabelWithHint: widget.centerLabel,
        hintText: widget.hint ?? "",
        hintStyle: AppStyles.subtitle.withColor(
          widget.hintColor ?? AppColors.hint,
        ),
        errorStyle: AppStyles.caption.withColor(AppColors.error),
        prefixIcon: prefixIcon ?? widget.prefixIcon,
        prefixIconConstraints:
            widget.prefixConstraints ?? AppMetrics.inputs.prefixIconConstraints,
        prefixIconColor: AppColors.greyRegular,
        suffixIcon: suffixIcon,
        suffixIconColor: AppColors.greyRegular,
      ),
    ).decorate(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppMetrics.inputs.radius),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
    );
  }
}
