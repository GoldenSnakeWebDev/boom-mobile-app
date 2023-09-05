import 'package:boom_mobile/widgets/bottom_navigation_bar.dart';
import 'package:boom_mobile/widgets/custom_app_bar.dart';
import 'package:boom_mobile/widgets/fab_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomErrorPage extends StatelessWidget {
  final FlutterErrorDetails? flutterErrorDetails;
  const CustomErrorPage({Key? key, this.flutterErrorDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leadingWidget: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currIndex: 0),
      floatingActionButton: const FabButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      resizeToAvoidBottomInset: false,
      extendBody: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/error.jpeg"),
              const SizedBox(height: 15),
              Text(
                kDebugMode
                    ? flutterErrorDetails?.summary.toString() ??
                        "Flutter null error"
                    : 'Sorry Something went wrong',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),
              kDebugMode
                  ? const SizedBox.shrink()
                  : const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        "An error has occurred. This has been noted by our team and will be fixed as soon as possible.\nThank you for your patience",
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
