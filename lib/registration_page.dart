import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'constants.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("registration_form".tr()),
        actions: [
          IconButton(
            icon: Icon(Icons.language),
            onPressed: () {
              context.locale = context.locale.languageCode == 'en'
                  ? Locale('ru')
                  : Locale('en');
            },
          )
        ],
      ),
      body: _selectedIndex == 0 ? _buildRegistrationForm() : _buildUserInfo(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'registration'.tr(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'user_info'.tr(),
          ),
        ],
      ),
    );
  }

  Widget _buildRegistrationForm() {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "full_name".tr(),
                prefixIcon: Icon(Icons.person),
              ),
              validator: (value) => value!.isEmpty ? "name_empty".tr() : null,
            ),
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: "phone".tr(),
                prefixIcon: Icon(Icons.phone),
              ),
              validator: (value) => value!.isEmpty || !RegExp(r'^[0-9]+$').hasMatch(value)
                  ? "invalid_phone".tr()
                  : null,
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "email".tr(),
                prefixIcon: Icon(Icons.email),
              ),
              validator: (value) => value!.isEmpty || !RegExp(r'^[\w-]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)
                  ? "invalid_email".tr()
                  : null,
            ),
            TextFormField(
              controller: _passwordController,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                labelText: "password".tr(),
                suffixIcon: IconButton(
                  icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                ),
              ),
              validator: (value) => value!.length < 6 ? "short_password".tr() : null,
            ),
            TextFormField(
              controller: _confirmPasswordController,
              obscureText: _obscureConfirmPassword,
              decoration: InputDecoration(
                labelText: "confirm_password".tr(),
                suffixIcon: IconButton(
                  icon: Icon(_obscureConfirmPassword ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                ),
              ),
              validator: (value) => value != _passwordController.text ? "password_mismatch".tr() : null,
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Handle form submission
                }
              },
              child: Text("submit".tr(), style: buttonTextStyle),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfo() {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("name".tr() + ": ${_nameController.text}", style: regularStyle),
          Text("email_text".tr() + ": ${_emailController.text}", style: regularStyle),
          Text("phone_text".tr() + ": ${_phoneController.text}", style: regularStyle),
        ],
      ),
    );
  }
}
