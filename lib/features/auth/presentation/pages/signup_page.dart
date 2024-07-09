import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/features/auth/presentation/pages/login_page.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  static route() => MaterialPageRoute(
      builder: (context) => const SignUpPage()
  );


  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();




  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const Text(
                "Sign Up",
                style: TextStyle(
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold
                ),
              ),

              const SizedBox(height: 20,),

              AuthField(
                hintText: "Name",
                controller: nameController,
              ),
              const SizedBox(height: 20,),

              AuthField(
                hintText: "Email",
                controller: emailController,
              ),

              const SizedBox(height: 20,),

              AuthField(
                hintText: "Password",
                controller: passwordController,
                isObscureText: true,
              ),
              const SizedBox(height: 20,),

              const AuthGradientButton(
                buttonText: "Sign Up",
              ),

              const SizedBox(height: 20,),

              GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        LoginPage.route()
                    );
                  },
                child: RichText(
                  text: TextSpan(
                      text:'Don\'t have an account? ',
                      style: Theme.of(context).textTheme.titleMedium,
                      children: [

                        TextSpan(
                          text: 'Sign In',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppPallete.gradient2,
                              fontWeight: FontWeight.bold
                          ),
                        )
                      ]
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
