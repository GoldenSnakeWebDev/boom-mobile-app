import 'package:boom_mobile/screens/home_screen/controllers/single_boom_controller.dart';
import 'package:boom_mobile/screens/home_screen/models/single_boom_model.dart';
import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:boom_mobile/widgets/single_comment_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../models/single_boom_post.dart';

class SingleBoomPage extends StatefulWidget {
  final SingleBoomPost post;

  const SingleBoomPage({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  State<SingleBoomPage> createState() => _SingleBoomPageState();
}

class _SingleBoomPageState extends State<SingleBoomPage> {
  void _onShare(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox;

    await Share.share("You are sharing an NFT",
        subject: "NFT",
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  final box = GetStorage();
  final controller = SingleBoomController();
  final String boomId = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kContBgColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          "Boom",
          style: TextStyle(
            color: Colors.black,
            fontSize: getProportionateScreenHeight(18),
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: false,
        backgroundColor: kContBgColor,
        elevation: 0.5,
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: controller.getSingleBoom(),
          builder: (context, snapshot) {
            SingleBoom? boom = snapshot.data;
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.connectionState == ConnectionState.active ||
                snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text("Could not fecch boom"),
                );
              } else if (snapshot.hasData) {
                return Container(
                  padding: const EdgeInsets.all(12.0),
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.89,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: snapshot.data!.boom.boomType == "text"
                                  ? Text(widget.post.imgUrl)
                                  : CachedNetworkImage(
                                      // height: getProportionateScreenHeight(200),
                                      width: SizeConfig.screenWidth,
                                      imageUrl: widget.post.imgUrl,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(15),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          child: CachedNetworkImage(
                                            height:
                                                getProportionateScreenHeight(
                                                    45),
                                            width: getProportionateScreenHeight(
                                                45),
                                            imageUrl: boom!
                                                    .boom.user.photo.isNotEmpty
                                                ? boom.boom.user.photo
                                                : "https://bafkreihauwrqu5wrcwsi53fkmm75pcdlmbzcg7eorw6avmb3o3cx4tk33e.ipfs.nftstorage.link/",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(
                                          height:
                                              getProportionateScreenHeight(5),
                                        ),
                                        Text(
                                          "!${boom.boom.user.username}",
                                          style: TextStyle(
                                            fontSize:
                                                getProportionateScreenHeight(
                                                    11),
                                            fontWeight: FontWeight.w800,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width: getProportionateScreenWidth(8),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              MdiIcons.mapMarker,
                                              size: 18,
                                            ),
                                            Text(
                                              "Spain",
                                              style: TextStyle(
                                                  fontSize:
                                                      getProportionateScreenHeight(
                                                          15),
                                                  fontWeight: FontWeight.w800),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height:
                                              getProportionateScreenHeight(5),
                                        ),
                                        SizedBox(
                                          height:
                                              getProportionateScreenHeight(10),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            _onShare(context);
                                          },
                                          child: const Icon(
                                            MdiIcons.shareVariant,
                                            size: 18,
                                            color: Colors.black,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        showMenu(
                                          context: context,
                                          position: RelativeRect.fromLTRB(
                                            SizeConfig.screenWidth * 0.6,
                                            SizeConfig.screenHeight * 0.65,
                                            SizeConfig.screenWidth * 0.35,
                                            60,
                                          ),
                                          constraints: BoxConstraints(
                                              maxWidth: SizeConfig.screenWidth *
                                                  0.35),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          items: [
                                            PopupMenuItem(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: kBlueColor
                                                      .withOpacity(0.8),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          16.0, 4.0, 16.0, 4.0),
                                                  child: Text(
                                                    "Syn. NFT",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize:
                                                          getProportionateScreenHeight(
                                                              14),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            PopupMenuItem(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: kBlueColor
                                                      .withOpacity(0.8),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          16.0, 4.0, 16.0, 4.0),
                                                  child: Text(
                                                    "Mint NFT",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize:
                                                          getProportionateScreenHeight(
                                                              14),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: kPrimaryColor,
                                            border: Border.all(
                                                color: Colors.black)),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 4, 10, 4),
                                          child: Text(
                                            "Obtain",
                                            style: TextStyle(
                                              fontSize:
                                                  getProportionateScreenHeight(
                                                      12),
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: getProportionateScreenWidth(7),
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          boom.boom.fixedPrice,
                                          style: TextStyle(
                                            fontSize:
                                                getProportionateScreenHeight(
                                                    18),
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        Text(
                                          "(\$${boom.boom.price})",
                                          style: TextStyle(
                                              fontSize:
                                                  getProportionateScreenHeight(
                                                      11)),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width: getProportionateScreenWidth(5),
                                    ),
                                    CachedNetworkImage(
                                      height: getProportionateScreenHeight(20),
                                      imageUrl: widget.post.network.imageUrl,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        showMenu(
                                          context: context,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          position: RelativeRect.fromLTRB(
                                            SizeConfig.screenWidth,
                                            SizeConfig.screenHeight * 0.6,
                                            30,
                                            60,
                                          ),
                                          items: [
                                            PopupMenuItem(
                                              onTap: () {},
                                              child: Text(
                                                "View Contract",
                                                style: TextStyle(
                                                  fontSize:
                                                      getProportionateScreenHeight(
                                                          13),
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                            ),
                                            PopupMenuItem(
                                              onTap: () {},
                                              child: Text(
                                                "Report Post",
                                                style: TextStyle(
                                                  fontSize:
                                                      getProportionateScreenHeight(
                                                          13),
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                      icon: const Icon(
                                        MdiIcons.dotsHorizontal,
                                        color: Colors.black,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(10),
                            ),
                            Text(
                              widget.post.desc,
                              style: TextStyle(
                                  fontSize: getProportionateScreenHeight(16),
                                  fontWeight: FontWeight.w900),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(5),
                            ),
                            Text(
                              boom.boom.tags[0],
                              style: TextStyle(
                                  fontSize: getProportionateScreenHeight(11),
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(10),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  children: [
                                    CachedNetworkImage(
                                      height: getProportionateScreenHeight(26),
                                      color: kPrimaryColor,
                                      imageUrl:
                                          "https://bafybeigmmfylly4mfjdtgjmdca2whhzxw63g2acsfbsdi2yyvpwxrwarcu.ipfs.nftstorage.link/applaud.png",
                                    ),
                                    Text(
                                      "${boom.boom.reactions.likes.length}",
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenHeight(12),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SvgPicture.asset(
                                      height: getProportionateScreenHeight(18),
                                      "assets/icons/love.svg",
                                    ),
                                    Text(
                                      "${boom.boom.reactions.loves.length}",
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenHeight(12),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.network(
                                      height: getProportionateScreenHeight(22),
                                      "https://bafybeigmmfylly4mfjdtgjmdca2whhzxw63g2acsfbsdi2yyvpwxrwarcu.ipfs.nftstorage.link/ipfs/bafybeigmmfylly4mfjdtgjmdca2whhzxw63g2acsfbsdi2yyvpwxrwarcu/smile.png",
                                    ),
                                    Text(
                                      "${boom.boom.reactions.smiles.length}",
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenHeight(12),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    SvgPicture.asset(
                                      height: getProportionateScreenHeight(18),
                                      "assets/icons/reboom.svg",
                                    ),
                                    Text(
                                      "${boom.boom.reactions.rebooms.length}",
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenHeight(12),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Icon(
                                      MdiIcons.alert,
                                      color: kYellowTextColor,
                                    ),
                                    Text(
                                      "${boom.boom.reactions.reports.length}",
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenHeight(12),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Icon(
                                      MdiIcons.chatOutline,
                                      size: 24,
                                    ),
                                    Text(
                                      "${boom.boom.comments.length}",
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenHeight(12),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(15),
                            ),
                            Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: boom.boom.comments.length,
                                itemBuilder: (context, index) {
                                  return SingleComment(
                                    comment: boom.boom.comments[index].message,
                                    userName: boom.boom.comments[index].user,
                                    createdAt: boom
                                        .boom.comments[index].createdAt
                                        .toString(),
                                    imageUrl:
                                        "https://icon-library.com/images/no-user-image-icon/no-user-image-icon-25.jpg",
                                  );
                                },
                              ),
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(12.0),
                                fillColor: const Color(0xFFF8F8F8),
                                filled: true,
                                hintText: "Type a Comment...",
                                // prefixIcon: IconButton(
                                //   icon: const Icon(
                                //     MdiIcons.cameraOutline,
                                //     color: Color(0xFF454C4D),
                                //   ),
                                //   onPressed: () {},
                                // ),
                                suffixIcon: SizedBox(
                                  width: getProportionateScreenWidth(100),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: const [
                                      Icon(
                                        MdiIcons.send,
                                        color: Color(0xFF454C4D),
                                      ),
                                    ],
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.black45,
                                    width: 0.2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.black45,
                                    width: 0.2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.black45,
                                    width: 0.2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: Text("Loading..."),
                );
              }
            } else {
              return const Center(
                child: Text("Something went wrong"),
              );
            }
          },
        ),
      ),
    );
  }
}
