import 'package:flutter/material.dart';

enum InputFieldType { name, email, password, confirmPassword }

class CustomTextFormField extends StatefulWidget {
  final InputFieldType inputType;
  final String labelText;
  final String hintText;
  final Widget prefixIcon;
  final TextEditingController controller;

  /// Контроллер основного пароля (нужен только для confirmPassword)
  final TextEditingController? passwordController;

  /// next — переход к следующему полю, done — завершение ввода
  final TextInputAction textInputAction;

  /// Вызывается, когда пользователь нажал "done" на клавиатуре
  final VoidCallback? onDone;

  const CustomTextFormField({
    super.key,
    required this.inputType,
    required this.labelText,
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
    this.passwordController,
    this.textInputAction = TextInputAction.next,
    this.onDone,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextFormField> {
  bool _hidePassword = true;

  bool get _isPassword =>
      widget.inputType == InputFieldType.password ||
          widget.inputType == InputFieldType.confirmPassword;

  String? _validator(String? value) {
    // Поле не может быть пустым и неопределенным
    if (value == null || value.trim().isEmpty) {
      return "Поле не может быть пустым";
    }

    switch (widget.inputType) {
      case InputFieldType.name:
      // только буквы и пробелы
        final reg = RegExp(r'^[A-Za-zА-Яа-яЁё\s]+$');
        if (!reg.hasMatch(value)) {
          return "Имя должно содержать только буквы и пробелы";
        }
        return null;

      case InputFieldType.email:
      // текст до @, текст после @, точка в домене
        final reg = RegExp(r'^[^@\s]+@[^@\s.]+(\.[^@\s.]+)+$');
        if (!reg.hasMatch(value)) {
          return "Введите корректный email (example@mail.com)";
        }
        return null;

      case InputFieldType.password:
      // минимум 6 символов, буквы, цифры и символы + _ -
        final reg =
        RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[+_\-])[A-Za-z\d+_\-]{6,}$');
        if (!reg.hasMatch(value)) {
          return "Не менее 6 символов: буквы, цифры и символы (+, _, -)";
        }
        return null;

      case InputFieldType.confirmPassword:
        if (value != widget.passwordController?.text) {
          return "Пароли не совпадают";
        }
        return null;
    }
  }

  OutlineInputBorder _border(Color color, double width) => OutlineInputBorder(
    borderSide: BorderSide(color: color, width: width),
    borderRadius: BorderRadius.circular(20.0),
  );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _isPassword && _hidePassword,
      keyboardType: widget.inputType == InputFieldType.email
          ? TextInputType.emailAddress
          : TextInputType.text,
      textInputAction: widget.textInputAction,
      // Переход фокуса к следующему доступному полю
      onFieldSubmitted: (_) {
        if (widget.textInputAction == TextInputAction.next) {
          FocusScope.of(context).nextFocus();
        } else {
          widget.onDone?.call();
        }
      },
      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: const TextStyle(color: Colors.black54, fontSize: 16),
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: _isPassword
            ? IconButton(
          icon: Icon(
            _hidePassword ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () => setState(() => _hidePassword = !_hidePassword),
        )
            : null,
        border: _border(Colors.green, 1.5),
        enabledBorder: _border(Colors.green, 1.5),
        focusedBorder: _border(Colors.green.shade700, 2.5),
        errorBorder: _border(Colors.red, 1.5),
        focusedErrorBorder: _border(Colors.red, 2.5),
      ),
      validator: _validator,
    );
  }
}