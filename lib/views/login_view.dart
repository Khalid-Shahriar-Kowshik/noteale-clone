import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:noteale_clone/utils/colors.dart';
import 'package:noteale_clone/viewmodels/auth_viewmodel.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _canSubmit = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_updateCanSubmit);
    _passwordController.addListener(_updateCanSubmit);
    _updateCanSubmit();
  }

  void _updateCanSubmit() {
    final next =
        _emailController.text.trim().isNotEmpty &&
        _passwordController.text.isNotEmpty;
    if (next != _canSubmit) {
      setState(() => _canSubmit = next);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final authVM = context.read<AuthViewModel>();

    // Local guard: prevent submitting empty fields
    if (_emailController.text.trim().isEmpty ||
        _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter email and password.')),
      );
      return;
    }

    final success = await authVM.login(
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (!success) {
      if (!mounted) return;
      final message = authVM.errorMessage ?? 'Login failed. Please try again.';
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
      return; // stay on login screen
    }

    if (mounted) {
      GoRouter.of(context).go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtil.backgroundColor,
      appBar: AppBar(
        backgroundColor: ColorsUtil.backgroundColor,
        title: const Text('Log In', style: TextStyle(fontSize: 18)),
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
                      'Welcome back ! ',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Please login with your credentials",
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
              controller: _emailController,
              decoration: InputDecoration(
                filled: true,
                fillColor: ColorsUtil.secondaryColor,
                contentPadding: const EdgeInsets.all(16),
                labelText: 'Email',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text("Forgot Password ?", style: TextStyle(fontSize: 18)),
              ],
            ),
            const SizedBox(height: 60),
            const Text(
              "Don't have an account yet ?",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 2),
            GestureDetector(
              onTap: () {
                GoRouter.of(context).push('/createAccount');
              },
              child: Text(
                "Create an account here",
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
            Consumer<AuthViewModel>(
              builder: (context, authVM, _) {
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsUtil.primaryColor,
                    ),
                    onPressed: _canSubmit ? _handleLogin : null,
                    child: const Text(
                      "Log In",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
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
