// ignore_for_file: unused_local_variable, avoid_print, use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app_supabase_fullscale/widgets/wave_header.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../services/supabase/auth_service.dart';
import '../../services/supabase/client_service.dart';
import '../../utils/box_decorations.dart';
import '../../utils/validators.dart';
import '../../widgets/custom_password_textfield_widget.dart';

import '../../widgets/custom_textfield.dart';
import '../../widgets/oauth_button_widget.dart';
import '../../widgets/sized_box_widget.dart';
import '../../widgets/text_link_navigation.dart';

import '../profile_page.dart';
import 'forgot_password_page.dart';
import 'sign_up_page.dart';
//import 'package:sizer/sizer.dart';

class SignInPage extends StatefulWidget {
  static String routeName = '/sign_in';
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _redirecting = false;
  bool _obscureTextPassword = true;
  bool _rememberMe = false;
  late final _emailController = TextEditingController();
  late final _passwordController = TextEditingController();
  late final StreamSubscription<AuthState> _authStateSubscription;

  @override
  void initState() {
    _authStateSubscription =
        supabaseClient.auth.onAuthStateChange.listen((data) {
      if (_redirecting) return;
      final session = data.session;
      if (session != null) {
        _redirecting = true;
        Navigator.of(context).pushReplacementNamed('/profile');
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _authStateSubscription.cancel();
    super.dispose();
  }

  // Toggles the password show status
  void _togglePassword() {
    setState(() {
      _obscureTextPassword = !_obscureTextPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const WaveHeader(
                  height: 150,
                ),
                SafeArea(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              'Welcome',
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: const [
                            Text(
                              'Signin into your account',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30.0),
                        Container(
                          alignment: Alignment.center,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  child: OAuthButtonWidget(
                                    provider: Provider.google,
                                    page: ProfilePage(),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  child: OAuthButtonWidget(
                                    provider: Provider.facebook,
                                    page: ProfilePage(),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  child: OAuthButtonWidget(
                                    provider: Provider.twitter,
                                    page: ProfilePage(),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  child: OAuthButtonWidget(
                                    provider: Provider.github,
                                    page: ProfilePage(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 30.0),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                decoration: kRoundedBoxDecoration,
                                child: CustomTextField(
                                  key: const Key('email'),
                                  controller: _emailController,
                                  labelText: 'Email Address',
                                  hintText: 'Enter your email',
                                  validator: (value) => emailError(value),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                ),
                              ),
                              const SizedBox(height: 15.0),
                              Container(
                                decoration: kRoundedBoxDecoration,
                                child: CustomPasswordTextFieldWidget(
                                  key: const Key('password'),
                                  controller: _passwordController,
                                  labelText: 'Password',
                                  hintText: 'Enter your password',
                                  obscureText: _obscureTextPassword,
                                  validator: validatePassword,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  togglePasswordVisibility: _togglePassword,
                                ),
                              ),
                              const SizedBox(height: 15.0),
                              Wrap(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Material(
                                          borderRadius: BorderRadius.zero,
                                          child: Checkbox(
                                            value: _rememberMe,
                                            onChanged: (value) {
                                              setState(() {
                                                _rememberMe = value ?? false;
                                              });
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 6.0),
                                        const Text(
                                          "Remember Me",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                      onPressed: () {},
                                      child: const Text(
                                        "Forgot Password?",
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.0,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15.0),
                              Container(
                                decoration: kRoundedBoxDecoration,
                                child: Builder(builder: (BuildContext context) {
                                  return SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blue),
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            'Sign In',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                        onPressed: () async {
                                          setState(() {
                                            _isLoading = true;
                                          });

                                          if (_formKey.currentState!
                                              .validate()) {
                                            await authService.signUp(
                                              _emailController.text,
                                              _passwordController.text,
                                              context,
                                            );

                                            // Navigate to the next screen after successful sign-up
                                            Navigator.of(context)
                                                .pushReplacement(
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        const SignInPage(),
                                              ),
                                            );
                                          }
                                          setState(() {
                                            _isLoading = false;
                                          });
                                        }),
                                  );
                                }),
                              ),
                              const SizedBoxWidget(height: 30),
                              Container(
                                margin:
                                    const EdgeInsets.fromLTRB(10, 0, 10, 20),
                                alignment: Alignment.topRight,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ForgotPasswordPage()),
                                    );
                                  },
                                  child: const Text(
                                    "Forgot your password?",
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBoxWidget(height: 30),
                              const TextLinkNavigation(
                                page: SignUpPage(),
                                text1: "Don't have an account? ",
                                text2: 'Sign Up',
                                alignment: Alignment.center,
                              ),
                              const SizedBoxWidget(height: 30),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
