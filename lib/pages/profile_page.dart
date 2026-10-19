import 'package:flutter/material.dart';

import '../widgets/text_field.dart';

class ProfilePage extends StatefulWidget {
  final String fullName;
  final String email;

  const ProfilePage({
    super.key,
    this.fullName = 'Чумак Д.Е.',
    this.email = 'test123@mail.ru',
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.fullName);
    _emailController = TextEditingController(text: widget.email);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState?.validate() ?? false) {
      FocusScope.of(context).unfocus();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Данные профиля сохранены')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          style: IconButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            shape: const CircleBorder(),
          ),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: const Text('Профиль',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Аватар
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    width: 120,
                    height: 120,
                    color: Colors.green.shade100,
                    child: const Icon(Icons.camera_alt_outlined,
                        size: 48, color: Colors.black54),
                  ),
                ),
                const SizedBox(height: 24),
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
                  onDone: _save,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 56, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('Сохранить',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const ProfilePage(),
  ));
}