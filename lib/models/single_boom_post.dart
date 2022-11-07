import 'package:boom_mobile/models/network_model.dart';

class SingleBoomPost {
  final String boomType;
  final String imgUrl;
  final String desc;
  final String location;
  final String chain;
  final int likes;
  final int loves;
  final int smiles;
  final int rebooms;
  final int reported;
  final int comments;
  final Network? network;
  final bool isLiked;

  SingleBoomPost({
    required this.boomType,
    required this.location,
    required this.chain,
    required this.imgUrl,
    required this.desc,
    required this.likes,
    required this.loves,
    required this.smiles,
    required this.rebooms,
    required this.reported,
    required this.comments,
    required this.network,
    required this.isLiked,
  });
}
