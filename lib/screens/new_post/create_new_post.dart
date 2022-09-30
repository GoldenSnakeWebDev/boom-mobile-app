import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CreateNewPost extends StatelessWidget {
  const CreateNewPost({Key? key}) : super(key: key);

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
          'New Post',
          style: TextStyle(
            color: Colors.black,
            fontSize: getProportionateScreenHeight(16),
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              "Import NFT",
              style: TextStyle(
                fontSize: getProportionateScreenHeight(14),
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
        backgroundColor: kContBgColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: SizeConfig.screenWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blueAccent),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 20),
                    child: Column(
                      children: [
                        Text(
                          "Upload File",
                          style: TextStyle(
                              fontSize: getProportionateScreenHeight(15),
                              fontWeight: FontWeight.w900,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(15),
                        ),
                        Text(
                          "Accepted file types (JPG, PNG, MOV, MP4, GIF)",
                          style: TextStyle(
                              fontSize: getProportionateScreenHeight(12),
                              color: Colors.grey,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(5),
                        ),
                        Text(
                          "Max upload size 30MB",
                          style: TextStyle(
                              fontSize: getProportionateScreenHeight(12),
                              color: Colors.grey,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(40),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: kBlueColor.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(12, 6, 12, 6),
                                child: Row(
                                  children: [
                                    const Icon(
                                      MdiIcons.plus,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: getProportionateScreenWidth(5),
                                    ),
                                    const Text(
                                      "Add File",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: getProportionateScreenWidth(15),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.blueAccent,
                                ),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(12, 6, 12, 6),
                                child: Row(
                                  children: [
                                    const Icon(
                                      MdiIcons.plus,
                                      color: Colors.blueAccent,
                                    ),
                                    SizedBox(
                                      width: getProportionateScreenWidth(5),
                                    ),
                                    const Text(
                                      "Instagram Import",
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                Text(
                  "Number of versions",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: getProportionateScreenHeight(14),
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(15),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(4),
                    hintText: "Enter number of copies you want to create",
                    hintStyle:
                        TextStyle(fontSize: getProportionateScreenHeight(12)),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(15),
                ),
                SizedBox(
                  width: SizeConfig.screenWidth * 0.5,
                  child: TextFormField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(4),
                      hintText: "\$ Fixed Price",
                      hintStyle: TextStyle(
                        fontSize: getProportionateScreenHeight(12),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(15),
                ),
                Text(
                  "Price",
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: getProportionateScreenHeight(15)),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(15),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(4),
                    hintText: "40\$ price for one piece",
                    hintStyle: TextStyle(
                      fontSize: getProportionateScreenHeight(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    suffixIcon: SizedBox(
                      width: SizeConfig.screenWidth * 0.36,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(
                            MdiIcons.arrowDownDropCircle,
                          ),
                          SizedBox(
                            width: getProportionateScreenWidth(4),
                          ),
                          Image.asset(
                            height: getProportionateScreenHeight(16),
                            "assets/icons/bnb.png",
                          ),
                          SizedBox(
                            width: getProportionateScreenWidth(4),
                          ),
                          Text(
                            "29.7 BNB",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: getProportionateScreenHeight(12),
                            ),
                          )
                        ],
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                RichText(
                  text: TextSpan(
                    text: 'Service Fee ',
                    children: const [
                      TextSpan(
                        text: ' 4%',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                        ),
                      )
                    ],
                    style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: getProportionateScreenHeight(12),
                    ),
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                Container(
                  width: SizeConfig.screenWidth,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "NFT Details",
                          style: TextStyle(
                            fontSize: getProportionateScreenHeight(15),
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(10),
                        ),
                        Text(
                          "Complete the following details before your post is listed on the marketplace",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                            fontSize: getProportionateScreenHeight(11),
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(15),
                        ),
                        Text(
                          "Apply title, category, description, hashtags to all posts",
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: getProportionateScreenHeight(11),
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(20),
                        ),
                        Text(
                          "Title",
                          style: TextStyle(
                              fontSize: getProportionateScreenHeight(13),
                              fontWeight: FontWeight.w900),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(10),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(4),
                            hintText: "Enter title about your art",
                            hintStyle: TextStyle(
                              fontSize: getProportionateScreenHeight(12),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              borderSide: BorderSide(
                                color: Colors.grey.shade100,
                                width: 0.1,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(20),
                        ),
                        Text(
                          "Caption",
                          style: TextStyle(
                              fontSize: getProportionateScreenHeight(13),
                              fontWeight: FontWeight.w900),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(10),
                        ),
                        TextFormField(
                          maxLines: 5,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(4),
                            hintText: "Enter some description about your post",
                            hintStyle: TextStyle(
                              fontSize: getProportionateScreenHeight(12),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              borderSide: BorderSide(
                                color: Colors.grey.shade100,
                                width: 0.1,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(20),
                        ),
                        Text(
                          "Add At-Tags",
                          style: TextStyle(
                              fontSize: getProportionateScreenHeight(13),
                              fontWeight: FontWeight.w900),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(10),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(4),
                            // hintText: "Enter title about your art",
                            hintStyle: TextStyle(
                              fontSize: getProportionateScreenHeight(12),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              borderSide: BorderSide(
                                color: Colors.grey.shade100,
                                width: 0.1,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                Center(
                  child: Container(
                    height: getProportionateScreenHeight(40),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(4, 8),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Text(
                        "Create Post",
                        style: TextStyle(
                          fontSize: getProportionateScreenHeight(16),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(40),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
