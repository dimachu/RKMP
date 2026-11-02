import 'package:flutter/material.dart';

import '../routes.dart';
import '../widgets/text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      FocusScope.of(context).unfocus();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Вход выполнен')),
      );
      // Успешная авторизация -> основной экран (экран входа убираем из стека)
      Navigator.pushReplacementNamed(context, Routes.home);
    }
  }

  /// Переход на регистрацию. После успешной регистрации экран
  /// возвращает email — подставляем его в поле.
  Future<void> _openRegister() async {
    final email = await Navigator.pushNamed(context, Routes.register);
    if (!mounted) return;
    if (email is String) {
      _emailController.text = email;
      _passwordController.clear();
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 80),
                        const Text(
                          'Добро пожаловать!\nВойдите в свой аккаунт\nИли создайте новый',
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(height: 48),
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
                          hintText: 'Не менее 6 символов',
                          prefixIcon: const Icon(Icons.security),
                          controller: _passwordController,
                          textInputAction: TextInputAction.done,
                          onDone: _submit,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Восстановление пароля')),
                              );
                            },
                            child: const Text('Забыли пароль?'),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Center(
                          child: ElevatedButton(
                            onPressed: _submit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 56, vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text('Войти',
                                style:
                                TextStyle(fontWeight: FontWeight.bold)),
                          ),
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
                    const Text('Нет аккаунта? '),
                    GestureDetector(
                      onTap: _openRegister,
                      child: const Text(
                        'Зарегистрируйтесь',
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

