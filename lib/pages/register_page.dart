import 'package:flutter/material.dart';

import '../widgets/text_field.dart';
import 'profile_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      FocusScope.of(context).unfocus();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Регистрация прошла успешно')),
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => ProfilePage(
            fullName: _nameController.text.trim(),
            email: _emailController.text.trim(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 48),
                        const Text(
                          'Регистрация',
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 32),
                        CustomTextFormField(
                          inputType: InputFieldType.name,
                          labelText: 'ФИО',
                          hintText: 'Введите ваше ФИО',
                          prefixIcon: const Icon(Icons.person_outline),
                          controller: _nameController,
                        ),
                        const SizedBox(height: 16),
                        CustomTextFormField(
                          inputType: InputFieldType.email,
                          labelText: 'Email',
                          hintText: 'example@mail.com',
                          prefixIcon: const Icon(Icons.email_outlined),
                          controller: _emailController,
                        ),
                        const SizedBox(height: 16),
                        CustomTextFormField(
                          inputType: InputFieldType.password,
                          labelText: 'Пароль',
                          hintText: 'Буквы, цифры и символы (+, _, -)',
                          prefixIcon: const Icon(Icons.security),
                          controller: _passwordController,
                        ),
                        const SizedBox(height: 16),
                        CustomTextFormField(
                          inputType: InputFieldType.confirmPassword,
                          labelText: 'Повторите пароль',
                          hintText: 'Повторите пароль',
                          prefixIcon: const Icon(Icons.security),
                          controller: _confirmController,
                          passwordController: _passwordController,
                          textInputAction: TextInputAction.done,
                          onDone: _submit,
                        ),
                        const SizedBox(height: 32),
                        ElevatedButton(
                          onPressed: _submit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text('Зарегистрироваться',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Уже есть аккаунт? '),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Text(
                        'Войдите',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const RegisterPage(),
  ));
}