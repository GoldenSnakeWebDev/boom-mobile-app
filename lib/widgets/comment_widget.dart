import 'package:boom_mobile/screens/home_screen/models/all_booms.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:boom_mobile/widgets/single_comment_widget.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CommentWidget extends StatefulWidget {
  const CommentWidget({
    Key? key,
    required this.comments,
    required this.myUserId,
    required this.postId,
    required this.isDisabled,
  }) : super(key: key);

  final List<Comment>? comments;
  final String myUserId;
  final String postId;
  final bool isDisabled;

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  TextEditingController _commentController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoggedIn = false;
  @override
  void initState() {
    super.initState();
    _commentController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, state2) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Material(
              borderRadius: BorderRadius.circular(16),
              child: Column(
                children: [
                  SizedBox(
                    // decoration: BoxDecoration(
                    //   color: Colors.white,
                    //   borderRadius: BorderRadius.only(
                    //     topLeft: Radius.circular(16),
                    //     topRight: Radius.circular(16),
                    //   ),
                    // ),
                    height: SizeConfig.screenHeight * 0.52,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: getProportionateScreenHeight(8),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Spacer(),
                              Center(
                                child: Text(
                                  "${widget.comments?.length} Comments",
                                  style: TextStyle(
                                    fontSize: getProportionateScreenWidth(14),
                                    fontFamily: "Quicksand",
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Icon(
                                    MdiIcons.close,
                                    size: 20,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(20),
                          ),
                          SizedBox(
                            height: SizeConfig.screenHeight * 0.41,
                            child: widget.comments != null
                                ? ListView.builder(
                                    itemCount: widget.comments!.length,
                                    itemBuilder: (context, index) {
                                      return SingleComment(
                                        comment:
                                            widget.comments![index].message!,
                                        userName: widget
                                            .comments![index].user!.username!,
                                        createdAt: widget
                                            .comments![index].createdAt
                                            .toString(),
                                        imageUrl:
                                            "https://icon-library.com/images/no-user-image-icon/no-user-image-icon-25.jpg",
                                        userId:
                                            widget.comments![index].user!.id!,
                                      );
                                    },
                                  )
                                : Container(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
