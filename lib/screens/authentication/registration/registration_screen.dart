import 'package:boom_mobile/di/app_bindings.dart';
import 'package:boom_mobile/screens/authentication/login/login_screen.dart';
import 'package:boom_mobile/screens/authentication/registration/controllers/signup_controller.dart';
import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationScreen extends GetView<RegisterController> {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF3BE686),
              Color(0xFF3BE686),
              kPrimaryColor,
            ],
          ),
        ),
        child: Form(
          key: controller.regFormKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // const Spacer(),
                  SizedBox(
                    height: getProportionateScreenHeight(60),
                  ),
                  Image(
                    width: SizeConfig.screenWidth * 0.45,
                    height: SizeConfig.screenHeight * 0.22,
                    image: const NetworkImage(
                      "https://bafybeigmmfylly4mfjdtgjmdca2whhzxw63g2acsfbsdi2yyvpwxrwarcu.ipfs.nftstorage.link/boom_logo.png",
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                  Text(
                    "The 🌍's First",
                    style: TextStyle(
                      fontSize: getProportionateScreenHeight(18),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                  Text(
                    "Web-3 Social Commerce Experience",
                    style: TextStyle(
                      fontSize: getProportionateScreenHeight(15),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  // const Spacer(),
                  SizedBox(
                    height: getProportionateScreenHeight(25),
                  ),
                  Container(
                    width: SizeConfig.screenWidth * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              width: getProportionateScreenWidth(50),
                              height: getProportionateScreenHeight(50),
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    "https://bafybeigmmfylly4mfjdtgjmdca2whhzxw63g2acsfbsdi2yyvpwxrwarcu.ipfs.nftstorage.link/ipfs/bafybeigmmfylly4mfjdtgjmdca2whhzxw63g2acsfbsdi2yyvpwxrwarcu/user_icon.png",
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(10),
                            ),
                            Text(
                              "Sign Up",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: getProportionateScreenHeight(20),
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.8,
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(10),
                            ),
                            TextFormField(
                              controller: controller.emailController,
                              decoration: InputDecoration(
                                hintText: "Email",
                                prefixIcon: const Icon(
                                  Icons.mail,
                                  color: Colors.black,
                                ),
                                fillColor: Colors.grey.shade300,
                                filled: true,
                                contentPadding: const EdgeInsets.all(4.0),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white.withOpacity(0.1),
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white.withOpacity(0.1),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white.withOpacity(0.1),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white.withOpacity(0.1),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(15),
                            ),
                            TextFormField(
                              controller: controller.usernameController,
                              decoration: InputDecoration(
                                hintText: "Username",
                                prefixIcon: const Icon(
                                  Icons.person,
                                  color: Colors.black,
                                ),
                                fillColor: Colors.grey.shade300,
                                filled: true,
                                contentPadding: const EdgeInsets.all(4.0),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white.withOpacity(0.1),
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white.withOpacity(0.1),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white.withOpacity(0.1),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white.withOpacity(0.1),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(15),
                            ),
                            Obx(
                              () => TextFormField(
                                controller: controller.passwordController,
                                obscureText: controller.isPassVisible.value,
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  helperText:
                                      "Must be over 6 characters long, contain an uppercase letter, special symbol and a number",
                                  helperStyle: const TextStyle(
                                      fontWeight: FontWeight.w800),
                                  prefixIcon: const Icon(
                                    Icons.lock,
                                    color: Colors.black,
                                  ),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      controller.changePassVisibility();
                                    },
                                    child: const Icon(
                                      Icons.remove_red_eye_outlined,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                  ),
                                  fillColor: Colors.grey.shade300,
                                  filled: true,
                                  hintMaxLines: 4,
                                  helperMaxLines: 4,
                                  contentPadding: const EdgeInsets.all(4.0),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white.withOpacity(0.1),
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white.withOpacity(0.1),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white.withOpacity(0.1),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white.withOpacity(0.1),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(15),
                            ),
                            Obx(
                              () => TextFormField(
                                controller:
                                    controller.confirmPasswordController,
                                obscureText:
                                    controller.isConfirmPassVisibe.value,
                                decoration: InputDecoration(
                                  hintText: "Confirm Password",
                                  prefixIcon: const Icon(
                                    Icons.lock,
                                    color: Colors.black,
                                  ),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      controller.changeConfirmPassVisibility();
                                    },
                                    child: const Icon(
                                      Icons.remove_red_eye_outlined,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                  ),
                                  fillColor: Colors.grey.shade300,
                                  filled: true,
                                  contentPadding: const EdgeInsets.all(4.0),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white.withOpacity(0.1),
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white.withOpacity(0.1),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white.withOpacity(0.1),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white.withOpacity(0.1),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(15),
                            ),
                            GestureDetector(
                              onTap: () async {
                                final res = await controller.registerUser();
                                if (res) {
                                  Get.to(() => const LoginScreen());
                                }
                              },
                              child: Container(
                                width: SizeConfig.screenWidth * 0.5,
                                height: getProportionateScreenHeight(40),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.blue.withOpacity(0.8),
                                    borderRadius: BorderRadius.circular(8.0)),
                                child: Text(
                                  "CREATE ACCOUNT",
                                  style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: getProportionateScreenHeight(16),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(20),
                            ),
                            RichText(
                              text: TextSpan(
                                text: "Already have an account? ",
                                style: TextStyle(
                                  fontSize: getProportionateScreenHeight(14),
                                ),
                                children: [
                                  TextSpan(
                                    text: "Login",
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Get.off(() => const LoginScreen(),
                                            binding: AppBindings());
                                      },
                                    style: TextStyle(
                                      color: Colors.red.withOpacity(0.8),
                                      fontSize:
                                          getProportionateScreenHeight(14),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
