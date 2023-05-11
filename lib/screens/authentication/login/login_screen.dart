import 'package:boom_mobile/di/app_bindings.dart';
import 'package:boom_mobile/screens/authentication/login/controllers/login_controller.dart';
import 'package:boom_mobile/screens/authentication/registration/registration_screen.dart';
import 'package:boom_mobile/screens/main_screen/main_screen.dart';
import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/constants.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

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
          key: controller.loginformKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // const Spacer(),
                        SizedBox(
                          height: getProportionateScreenHeight(120),
                        ),
                        Image(
                          width: SizeConfig.screenWidth * 0.6,
                          height: SizeConfig.screenHeight * 0.25,
                          image: const NetworkImage(
                            boomIconUrl,
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
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: getProportionateScreenWidth(50),
                                    height: getProportionateScreenHeight(50),
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          userIconUrl,
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
                                      fontSize:
                                          getProportionateScreenHeight(20),
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
                                      obscureText:
                                          controller.isPassVisible.value,
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
                                        contentPadding:
                                            const EdgeInsets.all(4.0),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color:
                                                Colors.white.withOpacity(0.1),
                                          ),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color:
                                                Colors.white.withOpacity(0.1),
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color:
                                                Colors.white.withOpacity(0.1),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color:
                                                Colors.white.withOpacity(0.1),
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
                                        Future.delayed(
                                          const Duration(milliseconds: 500),
                                        ).then((value) {
                                          Get.offAll(() => const MainScreen(),
                                              binding: AppBindings());
                                        });
                                      }
                                    },
                                    child: Container(
                                      width: SizeConfig.screenWidth * 0.5,
                                      height: getProportionateScreenHeight(40),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Colors.blue.withOpacity(0.8),
                                          borderRadius:
                                              BorderRadius.circular(8.0)),
                                      child: Text(
                                        "LOGIN",
                                        style: TextStyle(
                                          color: Colors.white54,
                                          fontSize:
                                              getProportionateScreenHeight(16),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: getProportionateScreenHeight(15),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: GestureDetector(
                                      onTap: () =>
                                          _showPasswordResetDialog(context),
                                      child: Text(
                                        "Forgot Password?",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              getProportionateScreenHeight(10),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: getProportionateScreenHeight(25),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: "Don't have an account? ",
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenHeight(14),
                                      ),
                                      children: [
                                        TextSpan(
                                          text: "Register",
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Get.off(
                                                  () =>
                                                      const RegistrationScreen(),
                                                  binding: AppBindings());
                                            },
                                          style: TextStyle(
                                            color: Colors.red.withOpacity(0.8),
                                            fontSize:
                                                getProportionateScreenHeight(
                                                    14),
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
                  Positioned(
                    top: SizeConfig.screenHeight * 0.07,
                    left: SizeConfig.screenWidth * 0.41,
                    child: WidgetAnimator(
                      incomingEffect:
                          WidgetTransitionEffects.incomingSlideInFromBottom(),
                      atRestEffect: WidgetRestingEffects.rotate(),
                      child: Image.asset(
                        "assets/icons/man-s-shoe-emoji-clipart-xl(1).png",
                        height: getProportionateScreenHeight(30),
                      ),
                    ),
                  ),
                  Positioned(
                    top: SizeConfig.screenHeight * 0.1,
                    right: SizeConfig.screenWidth * 0.13,
                    child: WidgetAnimator(
                      incomingEffect:
                          WidgetTransitionEffects.incomingSlideInFromBottom(),
                      atRestEffect: WidgetRestingEffects.rotate(),
                      child: Image.asset(
                        "assets/icons/running-shoe-emoji-clipart-xl(2).png",
                        height: getProportionateScreenHeight(30),
                      ),
                    ),
                  ),
                  Positioned(
                    top: SizeConfig.screenHeight * 0.1,
                    left: SizeConfig.screenWidth * 0.13,
                    child: WidgetAnimator(
                      incomingEffect:
                          WidgetTransitionEffects.incomingSlideInFromBottom(),
                      atRestEffect: WidgetRestingEffects.rotate(),
                      child: Image.asset(
                        "assets/icons/laughter-clipart-xl(1).png",
                        height: getProportionateScreenHeight(30),
                      ),
                    ),
                  ),
                  Positioned(
                    top: SizeConfig.screenHeight * 0.24,
                    right: SizeConfig.screenWidth * 0.04,
                    child: WidgetAnimator(
                      incomingEffect:
                          WidgetTransitionEffects.incomingSlideInFromBottom(),
                      atRestEffect: WidgetRestingEffects.rotate(),
                      child: Image.asset(
                        "assets/icons/t-shirt-emoji-clipart-xl(1).png",
                        height: getProportionateScreenHeight(30),
                      ),
                    ),
                  ),
                  Positioned(
                    top: SizeConfig.screenHeight * 0.24,
                    left: SizeConfig.screenWidth * 0.04,
                    child: WidgetAnimator(
                      incomingEffect:
                          WidgetTransitionEffects.incomingSlideInFromBottom(),
                      atRestEffect: WidgetRestingEffects.rotate(),
                      child: Image.asset(
                        "assets/icons/Handbag Emoji(1).png",
                        height: getProportionateScreenHeight(30),
                      ),
                    ),
                  ),
                  Positioned(
                    top: SizeConfig.screenHeight * 0.36,
                    left: SizeConfig.screenWidth * 0.04,
                    child: WidgetAnimator(
                      incomingEffect:
                          WidgetTransitionEffects.incomingSlideInFromBottom(),
                      atRestEffect: WidgetRestingEffects.rotate(),
                      child: Image.asset(
                        "assets/icons/422dress_100789(1).png",
                        height: getProportionateScreenHeight(30),
                      ),
                    ),
                  ),
                  Positioned(
                    top: SizeConfig.screenHeight * 0.36,
                    right: SizeConfig.screenWidth * 0.03,
                    child: WidgetAnimator(
                      incomingEffect:
                          WidgetTransitionEffects.incomingSlideInFromBottom(),
                      atRestEffect: WidgetRestingEffects.rotate(),
                      child: Image.asset(
                        "assets/icons/sun-glass-clipart-xl(1).png",
                        height: getProportionateScreenHeight(20),
                        width: getProportionateScreenWidth(50),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _showPasswordResetDialog(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(
              getProportionateScreenHeight(20),
            ),
          ),
        ),
        builder: (context) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(
                  getProportionateScreenHeight(20),
                ),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Reset Password",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Enter your email address and click Proceed to reset your password",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: controller.userNameController,
                  decoration: InputDecoration(
                    hintText: "Email",
                    hintStyle: const TextStyle(
                      color: Colors.black54,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () async {
                    final res = await controller.resetPassword();
                    if (res) {
                      controller.userNameController.clear();
                      Future.delayed(const Duration(milliseconds: 100))
                          .then((value) {
                        Navigator.pop(context);
                        _showChangePasswordDIalog(context);
                      });
                    } else {
                      Get.snackbar("Error", "Please enter a registered email");
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "Proceed",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  _showChangePasswordDIalog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            getProportionateScreenHeight(20),
          ),
        ),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(
                getProportionateScreenHeight(20),
              ),
            ),
          ),
          child: Form(
            key: controller.resetPasswordFormKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Change Password",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Enter your code then new password and click Proceed to change your password",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: controller.codeController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter the code";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Code",
                      hintStyle: const TextStyle(
                        color: Colors.black54,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: controller.newPasswordController,
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter the new password";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "New Password",
                      hintStyle: const TextStyle(
                        color: Colors.black54,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: controller.confirmPasswordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter the confirm password";
                      } else if (value !=
                          controller.newPasswordController.text) {
                        return "Passwords do not match";
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Confirm Password",
                      hintStyle: const TextStyle(
                        color: Colors.black54,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () async {
                      final res = await controller.changePassword();

                      if (res) {
                        controller.codeController.clear();
                        controller.newPasswordController.clear();
                        controller.confirmPasswordController.clear();
                        Future.delayed(const Duration(milliseconds: 100))
                            .then((value) => Navigator.pop(context));
                      } else {
                        Get.snackbar("Error", "Please enter a valid code");
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        "Proceed",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
