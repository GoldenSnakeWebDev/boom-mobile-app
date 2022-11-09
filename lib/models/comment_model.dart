import 'package:boom_mobile/screens/authentication/login/models/user_model.dart';

class CommentList {
  CommentList({
    this.comment,
    this.createdAt,
    this.updatedAt,
    this.userDetails,
  });

  String? comment;

  String? createdAt;

  String? updatedAt;

  User? userDetails;

  factory CommentList.fromJson(Map<String, dynamic> json) => CommentList(
        comment: json["comment"] ?? '',
        createdAt: json["createdAt"] ?? '',
        updatedAt: json["updatedAt"] ?? '',
        userDetails: User.fromJson(json["userId"]),
      );

  Map<String, dynamic> toJson() => {
        "comment": comment,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "userId": userDetails!.toJson(),
      };
}
