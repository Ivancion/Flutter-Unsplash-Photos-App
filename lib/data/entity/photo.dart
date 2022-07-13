import 'package:json_annotation/json_annotation.dart';
import 'package:unsplash_images/data/entity/links.dart';
import 'package:unsplash_images/data/entity/urls.dart';
import 'package:unsplash_images/data/entity/user.dart';

part 'photo.g.dart';

@JsonSerializable(explicitToJson: true)
class Photo {
  String id;
  @JsonKey(name: 'liked_by_user')
  bool likedByUser;
  Links links;
  Urls urls;
  User user;

  Photo({
    required this.id,
    required this.likedByUser,
    required this.links,
    required this.urls,
    required this.user,
  });

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoToJson(this);

  Photo copyWith({
    String? id,
    bool? likedByUser,
    Links? links,
    Urls? urls,
    User? user,
  }) {
    return Photo(
      id: id ?? this.id,
      likedByUser: likedByUser ?? this.likedByUser,
      links: links ?? this.links,
      urls: urls ?? this.urls,
      user: user ?? this.user,
    );
  }
}
