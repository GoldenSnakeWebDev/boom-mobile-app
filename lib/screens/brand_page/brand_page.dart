import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:boom_mobile/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class BrandPage extends StatelessWidget {
  final String title;
  const BrandPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: SizeConfig.screenWidth,
              decoration: const BoxDecoration(color: Colors.black),
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Text(
                  "$title: Home",
                  style: TextStyle(
                    color: kYellowTextColor,
                    fontSize: getProportionateScreenHeight(18),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.66,
                    crossAxisSpacing: 30,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Column(
                        children: [
                          Container(
                            height: getProportionateScreenHeight(200),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: const DecorationImage(
                                  image: NetworkImage(
                                    "https://s3-alpha-sig.figma.com/img/a0ed/d9fd/9d276f722b9431bca5bab749058cda8b?Expires=1665360000&Signature=IK71Bp3tI4DJJyi7OXS-ryXKIRcAFvXk9QxlbBsYp4YjijuFdrRIe604DH5Mb9NiCeh0iJ44ZjfmV0Q-KMqg~XBfAw80mb6riV4BDavlr5lnhFsLM6ejeOhN60BnDzqquU57fmrY2KdALCb7d4GuH0YWOgJlR8-xZnMjQLwvEEAxnFx4bXiKcB5viYBRYL~TA8qQ8q0NzqjRRKTSp3xZBQySMKaCvTe1kv95dSzw9unSm~BYG02z92~4aImySQMIR9FfQ8zVAMOhLPiaTwMy1uK~D-K-HsXv-kVtld2vZUOWF2fDFELCHVO-GWyHhU3YtldxjIj93eFz6XxFmrF~EA__&Key-Pair-Id=APKAINTVSUGEWH5XD5UA",
                                  ),
                                ),
                                border: Border.all(color: Colors.black)),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(7),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(6)),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "NFT",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
