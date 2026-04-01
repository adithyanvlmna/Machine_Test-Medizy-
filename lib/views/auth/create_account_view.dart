import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/app_colors.dart';
import '../../viewmodels/auth_viewmodel.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/primary_button.dart';

class CreateAccountView extends StatefulWidget {
  const CreateAccountView({super.key});

  @override
  State<CreateAccountView> createState() => _CreateAccountViewState();
}

class _CreateAccountViewState extends State<CreateAccountView> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _dobController = TextEditingController();
  final _mobileController = TextEditingController();
  final _locationController = TextEditingController();
  final _dojController = TextEditingController();
  final _passwordController = TextEditingController();
  
  void _onSave() async {
    final vm = context.read<AuthViewModel>();
    final success = await vm.createAccount({
      "first_name": _firstNameController.text,
      "last_name": _lastNameController.text,
      "email": _emailController.text,
      "address": _addressController.text,
      "dob": _dobController.text,
      "mobile_number": _mobileController.text,
      "location": _locationController.text,
      "doj": _dojController.text,
      "password": _passwordController.text,
    });
    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account CreatedSuccessfully!')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<AuthViewModel>().isLoading;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Create Account',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundColor: AppColors.primaryLight,
              child: Icon(Icons.person, color: Colors.white),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              CustomTextField(
                labelText: 'First Name',
                hintText: 'Enter First Name',
                controller: _firstNameController,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                labelText: 'Last Name',
                hintText: 'Enter Last Name',
                controller: _lastNameController,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                labelText: 'Email',
                hintText: 'Enter Email',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                labelText: 'Address',
                hintText: 'Enter Address',
                maxLines: 3,
                controller: _addressController,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                labelText: 'DOB',
                hintText: 'Enter DOB',
                controller: _dobController,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                labelText: 'Mobile Number',
                hintText: 'Enter Number',
                keyboardType: TextInputType.phone,
                controller: _mobileController,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                labelText: 'Location',
                hintText: 'Enter location',
                controller: _locationController,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                labelText: 'DOJ',
                hintText: 'Enter Date Of Joining',
                controller: _dojController,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                labelText: 'Password',
                hintText: 'Enter Password',
                obscureText: true,
                controller: _passwordController,
              ),
              const SizedBox(height: 32),
              if (isLoading)
                const CircularProgressIndicator()
              else
                PrimaryButton(
                  text: 'Save',
                  onPressed: _onSave,
                ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
