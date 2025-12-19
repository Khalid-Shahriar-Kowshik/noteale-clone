import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:noteale_clone/utils/colors.dart';
import 'package:noteale_clone/viewmodels/auth_viewmodel.dart';

class CreateAccountView extends StatefulWidget {
  const CreateAccountView({Key? key}) : super(key: key);

  @override
  State<CreateAccountView> createState() => _CreateAccountViewState();
}

class _CreateAccountViewState extends State<CreateAccountView> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _canSubmit = false;

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(_updateCanSubmit);
    _emailController.addListener(_updateCanSubmit);
    _passwordController.addListener(_updateCanSubmit);
    _confirmPasswordController.addListener(_updateCanSubmit);
    _updateCanSubmit();
  }

  void _updateCanSubmit() {
    final fieldsFilled =
        _usernameController.text.trim().isNotEmpty &&
        _emailController.text.trim().isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty;
    if (fieldsFilled != _canSubmit) {
      setState(() => _canSubmit = fieldsFilled);
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleCreateAccount() async {
    final authVM = context.read<AuthViewModel>();

    // Local guard: prevent submitting empty fields
    if (_usernameController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete all fields.')),
      );
      return;
    }

    final success = await authVM.createUser(
      name: _usernameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      confirmPassword: _confirmPasswordController.text,
    );

    if (!success) {
      if (!mounted) return;
      final message =
          authVM.errorMessage ?? 'Account creation failed. Please try again.';
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
      return; // stay on create-account screen
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account created successfully!')),
      );
      GoRouter.of(context).go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtil.backgroundColor,
      appBar: AppBar(
        backgroundColor: ColorsUtil.backgroundColor,
        title: const Text('Create Account', style: TextStyle(fontSize: 18)),
        leading: IconButton(
          onPressed: () => GoRouter.of(context).pop(),
          icon: Icon(Icons.arrow_back, color: ColorsUtil.primaryColor),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(width: 8),
                    Text(
                      'Let\'s get to know you !',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Enter your details to continue",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Error message
            Consumer<AuthViewModel>(
              builder: (context, authVM, _) {
                if (authVM.errorMessage != null) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.red.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.error_outline, color: Colors.red),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              authVM.errorMessage!,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, color: Colors.red),
                            onPressed: () => authVM.clearError(),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                filled: true,
                fillColor: ColorsUtil.secondaryColor,
                contentPadding: const EdgeInsets.all(16),
                labelText: 'Username',
                prefixIcon: const Icon(
                  Icons.person,
                  color: ColorsUtil.primaryColor,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: ColorsUtil.primaryColor),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                filled: true,
                fillColor: ColorsUtil.secondaryColor,
                contentPadding: const EdgeInsets.all(16),
                labelText: 'Email',
                prefixIcon: const Icon(
                  Icons.email,
                  color: ColorsUtil.primaryColor,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: ColorsUtil.primaryColor),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                filled: true,
                fillColor: ColorsUtil.secondaryColor,
                contentPadding: const EdgeInsets.all(16),
                labelText: 'Password',
                prefixIcon: const Icon(
                  Icons.lock,
                  color: ColorsUtil.primaryColor,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: ColorsUtil.primaryColor),
                ),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                filled: true,
                fillColor: ColorsUtil.secondaryColor,
                contentPadding: const EdgeInsets.all(16),
                labelText: 'Confirm Password',
                prefixIcon: const Icon(
                  Icons.lock_outline,
                  color: ColorsUtil.primaryColor,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: ColorsUtil.primaryColor),
                ),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 10),
            const Text(
              "Already have an account?",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 5),
            GestureDetector(
              onTap: () => GoRouter.of(context).push('/login'),
              child: Text(
                "Login here",
                style: TextStyle(
                  fontSize: 18,
                  color: ColorsUtil.primaryColor,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  decorationColor: ColorsUtil.primaryColor,
                ),
              ),
            ),
            const SizedBox(height: 80),
            Text.rich(
              TextSpan(
                style: const TextStyle(fontSize: 18),
                children: [
                  const TextSpan(text: 'By clicking the "'),
                  const TextSpan(
                    text: 'CREATE ACCOUNT',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(text: '" button,\n you agree to '),
                  const TextSpan(
                    text: 'Terms of use',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(text: ' and '),
                  const TextSpan(
                    text: 'Privacy Policy',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Consumer<AuthViewModel>(
              builder: (context, authVM, _) {
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsUtil.primaryColor,
                    ),
                    onPressed: _canSubmit ? _handleCreateAccount : null,
                    child: const Text("CREATE ACCOUNT"),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
