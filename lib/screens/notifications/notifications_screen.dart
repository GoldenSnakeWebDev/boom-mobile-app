import 'package:boom_mobile/screens/notifications/controllers/notifications_controller.dart';
import 'package:boom_mobile/screens/other_user_profile/other_user_profile.dart';
import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:boom_mobile/widgets/bottom_navigation_bar.dart';
import 'package:boom_mobile/widgets/fab_button.dart';
import 'package:boom_mobile/widgets/single_boom_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class NotificationScreen extends GetView<NotificationsController> {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationsController>(
      init: NotificationsController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              "Notifications",
              style: TextStyle(
                color: Colors.black,
                fontSize: getProportionateScreenHeight(20),
              ),
            ),
            centerTitle: true,
          ),
          bottomNavigationBar: const CustomBottomNavBar(currIndex: 2),
          floatingActionButton: const FabButton(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          resizeToAvoidBottomInset: false,
          extendBody: false,
          body: controller.isLoading
              ? const Center(
                  //TODO: Use Shimmer loading instead of this boring shit
                  child: CircularProgressIndicator(),
                )
              : SafeArea(
                  child: controller.notificationsModel!.notifications!.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.notifications_off_outlined,
                              size: getProportionateScreenHeight(100),
                              color: kPrimaryColor,
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(20),
                            ),
                            Center(
                              child: Text(
                                'No notifications at the moment',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: getProportionateScreenHeight(14),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RefreshIndicator(
                            onRefresh: () => controller.fetchAllNotifications(),
                            child: SizedBox(
                              width: SizeConfig.screenWidth,
                              height: SizeConfig.screenHeight,
                              child: ListView.builder(
                                itemCount: controller
                                    .notificationsModel!.notifications!.length,
                                reverse: false,
                                itemBuilder: ((context, index) {
                                  var reversedList = controller
                                      .notificationsModel!
                                      .notifications!
                                      .reversed
                                      .toList();
                                  var d12 = DateFormat('MM-dd-yyyy, hh:mm a')
                                      .format(DateTime.parse(reversedList[index]
                                          .timestamp
                                          .toString()));
                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: kContBgColor,
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 0.5,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          4.0, 8, 12, 8),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Icon(
                                            reversedList[index]
                                                        .notificationType ==
                                                    "user"
                                                ? MdiIcons.account
                                                : reversedList[index]
                                                            .notificationType ==
                                                        "transfer"
                                                    ? MdiIcons.transfer
                                                    : Icons.notifications,
                                            color: kPrimaryColor,
                                          ),
                                          SizedBox(
                                            width:
                                                getProportionateScreenWidth(10),
                                          ),
                                          Expanded(
                                            flex: 5,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 4.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        width: SizeConfig
                                                                .screenWidth *
                                                            0.5,
                                                        child: Text(
                                                          reversedList[index]
                                                              .message!,
                                                          maxLines: 3,
                                                          overflow:
                                                              TextOverflow.clip,
                                                          style: TextStyle(
                                                              fontSize:
                                                                  getProportionateScreenHeight(
                                                                      13),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800),
                                                        ),
                                                      ),
                                                      Text(
                                                        d12,
                                                        style: TextStyle(
                                                          color: Colors.black54,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize:
                                                              getProportionateScreenHeight(
                                                            10,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        getProportionateScreenHeight(
                                                            10),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: GestureDetector(
                                                        onTap: () {
                                                          switch (reversedList[
                                                                  index]
                                                              .notificationType) {
                                                            case "user":
                                                              Get.to(
                                                                  () =>
                                                                      const OtherUserProfileScreen(),
                                                                  arguments:
                                                                      reversedList[
                                                                              index]
                                                                          .user!
                                                                          .id!);
                                                              break;

                                                            case "boom":
                                                              Get.to(
                                                                  () =>
                                                                      const SingleBoomPage(),
                                                                  arguments: [
                                                                    reversedList[
                                                                            index]
                                                                        .boom!
                                                                        .id!,
                                                                    reversedList[
                                                                            index]
                                                                        .boom!
                                                                        .title!,
                                                                  ]);
                                                              break;

                                                            default:
                                                              Get.to(
                                                                  () =>
                                                                      const OtherUserProfileScreen(),
                                                                  arguments:
                                                                      reversedList[
                                                                              index]
                                                                          .user!
                                                                          .id!);
                                                          }
                                                        },
                                                        child: Wrap(
                                                          children: [
                                                            Text(
                                                              'View',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800,
                                                                  color: Colors
                                                                      .blueAccent
                                                                      .shade200),
                                                            ),
                                                            const Icon(
                                                              Icons
                                                                  .arrow_forward_ios_outlined,
                                                              color:
                                                                  kPrimaryColor,
                                                              size: 16,
                                                            )
                                                          ],
                                                        )),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );

                                  // Container(
                                  //   child: Padding(
                                  //     padding: const EdgeInsets.all(8.0),
                                  //     child: Column(
                                  //       crossAxisAlignment:
                                  //           CrossAxisAlignment.start,
                                  //       children: [
                                  //         Text(
                                  //           controller
                                  //               .notificationsModel!
                                  //               .notifications![index]
                                  //               .user!
                                  //               .username!,
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ),
                                  // );
                                }),
                              ),
                            ),
                          ),
                        ),
                ),
        );
      },
    );
  }
}
