import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  String password = '';

  bool _isEmailAlreadyRegistered = false;

  Future<void> signUp() async {
    final form = _formKey.currentState;
    if (form != null && form.validate()) {
      form.save();

      final prefs = await SharedPreferences.getInstance();
      String? storedEmail = prefs.getString('userEmail');

      if (storedEmail != null && storedEmail == email) {
        setState(() {
          _isEmailAlreadyRegistered = true;
        });
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email is already registered!')),
        );
        return; // Stop signing up
      }

      // Save new user info
      await prefs.setString('userName', name);
      await prefs.setString('userEmail', email);
      await prefs.setString('userPassword', password);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registered Successfully!')),
      );

      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please enter your name';
                  }
                  if (val.trim().length < 2) {
                    return 'Name must be at least 2 characters';
                  }
                  return null;
                },
                onSaved: (val) => name = val!.trim(),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  errorText:
                      _isEmailAlreadyRegistered ? 'Email already registered' : null,
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please enter email';
                  }
                  final emailRegex = RegExp(
                      r'^[a-zA-Z0-9]+([._%+-]?[a-zA-Z0-9]+)*@[a-zA-Z0-9]+\.[a-zA-Z]{2,}$');
                  if (!emailRegex.hasMatch(val.trim())) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
                onChanged: (_) {
                  if (_isEmailAlreadyRegistered) {
                    setState(() {
                      _isEmailAlreadyRegistered = false;
                    });
                  }
                },
                onSaved: (val) => email = val!.trim(),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Please enter password';
                  }
                  if (val.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
                onSaved: (val) => password = val!,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: signUp,
                child: const Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
