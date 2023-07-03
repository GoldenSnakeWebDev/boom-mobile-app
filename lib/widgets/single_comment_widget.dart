import 'package:boom_mobile/screens/other_user_profile/other_user_profile.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SingleComment extends StatelessWidget {
  final String userName;
  final String userId;
  final String comment;
  final String imageUrl;
  final String createdAt;
  const SingleComment({
    Key? key,
    required this.userName,
    required this.comment,
    required this.imageUrl,
    required this.createdAt,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var date = DateTime.fromMillisecondsSinceEpoch(int.parse(createdAt) * 1000);
    var d12 =
        DateFormat('MM-dd-yyyy, hh:mm a').format(DateTime.parse(createdAt));
    return StatefulBuilder(
      builder: (context, state2) {
        return Container(
          margin: const EdgeInsets.only(bottom: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0),
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => const OtherUserProfileScreen(),
                        arguments: userId);
                  },
                  child: SizedBox(
                    width: getProportionateScreenWidth(40),
                    height: getProportionateScreenHeight(40),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(8),
              ),
              Expanded(
                flex: 9,
                child: Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              userName,
                              style: TextStyle(
                                fontSize: getProportionateScreenHeight(14),
                                fontWeight: FontWeight.w800,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: getProportionateScreenWidth(4),
                          ),
                          Expanded(
                            child: Text(
                              d12,
                              style: TextStyle(
                                  fontSize: getProportionateScreenHeight(10),
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(8),
                      ),
                      Text(
                        comment,
                        style: TextStyle(
                          fontSize: getProportionateScreenHeight(12),
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(8),
                      ),
                      // Row(
                      //   children: [
                      //     Text(
                      //       "View replies (4)",
                      //       style: TextStyle(
                      //         fontFamily: "Quicksand",
                      //         fontSize: getProportionateScreenHeight(12),
                      //         fontWeight: FontWeight.w500,
                      //         color: const Color(0xFF86878B),
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       width: getProportionateScreenWidth(4),
                      //     ),
                      //     const Icon(
                      //       Icons.keyboard_arrow_down,
                      //       size: 18,
                      //       color: Color(0xFF86878B),
                      //     )
                      //   ],
                      // )
                    ],
                  ),
                ),
              ),
              // Expanded(
              //   child: Padding(
              //     padding: const EdgeInsets.only(top: 4),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: [
              //         const Icon(
              //           MdiIcons.heartOutline,
              //           size: 16,
              //           color: Color(0xFF86878B),
              //         ),
              //         SizedBox(
              //           height: getProportionateScreenHeight(2),
              //         ),
              //         Text(
              //           "234",
              //           style: TextStyle(
              //               fontFamily: "Quicksand",
              //               fontSize: getProportionateScreenHeight(12),
              //               fontWeight: FontWeight.w500,
              //               color: const Color(0xFF86878B)),
              //         )
              //       ],
              //     ),
              //   ),
              // )
            ],
          ),
        );
      },
    );
  }
}
