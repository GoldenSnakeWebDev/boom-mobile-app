import 'package:boom_mobile/models/network_model.dart';

import 'package:boom_mobile/screens/home_screen/models/all_booms.dart';

class SingleBoomPost {
  final int index;
  final String boomType;
  final String imgUrl;
  final String desc;
  final String title;
  final String location;
  final String chain;
  final UserClass user;
  int likes;
  int loves;
  int smiles;
  int rebooms;
  int reported;
  final int comments;
  final Network network;
  bool isLiked;
  bool isLoves;
  bool isSmiles;
  bool isRebooms;
  bool isReported;

  SingleBoomPost({
    required this.user,
    required this.index,
    required this.boomType,
    required this.location,
    required this.chain,
    required this.imgUrl,
    required this.desc,
    required this.title,
    required this.likes,
    required this.loves,
    required this.smiles,
    required this.rebooms,
    required this.reported,
    required this.comments,
    required this.network,
    required this.isLiked,
    required this.isLoves,
    required this.isSmiles,
    required this.isRebooms,
    required this.isReported,
  });
}
