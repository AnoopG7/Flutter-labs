import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  static const String routeName = '/form';

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Welcome, ${_nameController.text}! Your details were saved.',
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Input & Forms')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Enter your details below. Every field is validated.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  hintText: 'e.g. Jane Doe',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Name is required';
                  }
                  if (value.trim().length < 3) {
                    return 'Name must be at least 3 characters long';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'e.g. jane@example.com',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Email is required';
                  }
                  final regex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
                  if (!regex.hasMatch(value.trim())) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Age',
                  hintText: 'e.g. 21',
                  prefixIcon: Icon(Icons.cake),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Age is required';
                  }
                  final age = int.tryParse(value.trim());
                  if (age == null) {
                    return 'Age must be a number';
                  }
                  if (age < 18 || age > 100) {
                    return 'Age must be between 18 and 100';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              FilledButton.icon(
                onPressed: _submit,
                icon: const Icon(Icons.check),
                label: const Text('Submit'),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}