import 'package:boom_mobile/screens/authentication/login/controllers/login_controller.dart';
import 'package:boom_mobile/screens/authentication/registration/registration_screen.dart';
import 'package:boom_mobile/screens/main_screen/main_screen.dart';
import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
          key: controller.formKey,
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
                    width: SizeConfig.screenWidth * 0.6,
                    height: SizeConfig.screenHeight * 0.3,
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
                    height: getProportionateScreenHeight(50),
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
                              "Sign In",
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
                              controller: controller.userNameController,
                              decoration: InputDecoration(
                                hintText: "Username or Email",
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
                                bool res = await controller.loginUser();
                                if (res) {
                                  Get.offAll(() => const MainScreen());
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
                                  "LOGIN",
                                  style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: getProportionateScreenHeight(16),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(15),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: getProportionateScreenHeight(10),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(25),
                            ),
                            RichText(
                              text: TextSpan(
                                text: "Don't have an account? ",
                                style: TextStyle(
                                  fontSize: getProportionateScreenHeight(14),
                                ),
                                children: [
                                  TextSpan(
                                    text: "Register",
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Get.to(
                                          () => const RegistrationScreen(),
                                        );
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
