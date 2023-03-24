import 'package:boom_mobile/screens/profile_screen/controllers/boomBox_controller.dart';
import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class BoomBoxScreen extends StatefulWidget {
  const BoomBoxScreen({Key? key}) : super(key: key);

  @override
  State<BoomBoxScreen> createState() => _BoomBoxScreenState();
}

class _BoomBoxScreenState extends State<BoomBoxScreen> {
  @override
  void initState() {
    Get.put(BoomBoxController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BoomBoxController>(
      builder: (controller) {
        return SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      context: context,
                      builder: (context) {
                        return SizedBox(
                          height: SizeConfig.screenHeight * 0.25,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Text(
                                  'Create Your Box',
                                  style: TextStyle(
                                    fontSize: getProportionateScreenHeight(16),
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                SizedBox(
                                  height: getProportionateScreenHeight(20),
                                ),
                                TextFormField(
                                  controller: controller.boomBoxNameController,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(8.0),
                                    hintText: "Box Name",
                                    hintStyle: const TextStyle(
                                      color: Colors.black54,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: getProportionateScreenHeight(20),
                                ),
                                GestureDetector(
                                  onTap: () async {},
                                  child: Container(
                                    width: SizeConfig.screenWidth * 0.7,
                                    height: getProportionateScreenHeight(35),
                                    decoration: BoxDecoration(
                                      color: kPrimaryColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Create your box",
                                          style: TextStyle(
                                            fontSize:
                                                getProportionateScreenHeight(
                                                    14),
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(
                                          width: getProportionateScreenWidth(7),
                                        ),
                                        const Icon(
                                          MdiIcons.cog,
                                          size: 20,
                                          color: Colors.black,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    width: SizeConfig.screenWidth * 0.45,
                    height: getProportionateScreenHeight(35),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Create your box",
                          style: TextStyle(
                            fontSize: getProportionateScreenHeight(14),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          width: getProportionateScreenWidth(7),
                        ),
                        const Icon(
                          MdiIcons.cog,
                          size: 20,
                          color: Colors.black,
                        )
                      ],
                    ),
                  ),
                ),
                const Expanded(
                  child: SizedBox(),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
