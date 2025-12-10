import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:noteale_clone/utils/colors.dart';

class CreateAccountView extends StatelessWidget {
  const CreateAccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtil.backgroundColor,
      appBar: AppBar(
        backgroundColor: ColorsUtil.backgroundColor,
        title: const Text('Create Account', style: TextStyle(fontSize: 18)),
        leading: IconButton(
          onPressed: () => {GoRouter.of(context).pop()},
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
                      'Let’s get to know you !',
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
            SizedBox(height: 20),
            TextFormField(
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
            SizedBox(height: 10),
            Text("Already have an account?", style: TextStyle(fontSize: 18)),
            SizedBox(height: 5),
            Text(
              "Login here",
              style: TextStyle(
                fontSize: 18,
                color: ColorsUtil.primaryColor,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                decorationColor: ColorsUtil.primaryColor,
              ),
            ),
            SizedBox(height: 80),
            Text.rich(
              TextSpan(
                style: const TextStyle(fontSize: 18),
                children: [
                  const TextSpan(text: 'By clicking the “'),
                  const TextSpan(
                    text: 'CREATE ACCOUNT',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(text: '” button,\n you agree to '),
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
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsUtil.primaryColor,
                ),
                onPressed: () {
                  GoRouter.of(context).push('/login');
                },
                child: const Text("CREATE ACCOUNT"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
