import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:venturelead/feathures/home/model/connection_model.dart';

class UserModelController extends GetxController {
  final Rx<User> _user = Rx(User.dummy);

  User get user => _user.value;

  void setUser(User newUser) {
    _user.value = newUser;
  }
}

class User {
  @JsonKey(name: '_id')
  final String userid;
  final String username;
  final String email;
  final String password;
  final String? bio;
  final bool darkmode;
  final String? workDomain;
  final String? picture;

  final List<String>? favoriteCompanyIds;
  final List<FavoriteNews>? favoriteNews;
  final List<String>? interests;
  final List<String>? employeeCompanyIds;
  final List<Connections>? connections;

  User({
    required this.userid,
    required this.username,
    required this.email,
    required this.password,
    this.bio,
    this.darkmode = false,
    String? picture,
    this.workDomain,
    this.favoriteCompanyIds,
    this.favoriteNews,
    this.interests,
    this.employeeCompanyIds,
    this.connections,
  }) : picture = _validatePicture(picture ?? '');

  static String _validatePicture(String picture) {
    final RegExp urlRegExp = RegExp(
      r'^(https?|ftp):\/\/[^\s/$.?#].[^\s]*$',
      caseSensitive: false,
      multiLine: false,
    );
    return urlRegExp.hasMatch(picture)
        ? picture
        : 'https://res.cloudinary.com/dio3qwd9q/image/upload/fl_preserve_transparency/v1718868382/vecteezy_simple-user-default-icon_24983914_t6rahf.jpg';
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
      userid: json['_id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      bio: json['bio'] as String?,
      darkmode: json['darkmode'] as bool,
      workDomain: json['workDomain'] as String?,
      picture: json['picture'] as String?,
      favoriteCompanyIds: json['favroiteCompanies']
          ?.map<String>((e) => e['_id'] as String)
          ?.toList(),
      favoriteNews: (json['favroiteNews'] as List?)
          ?.map((e) => FavoriteNews.fromJson(e as Map<String, dynamic>))
          .toList(),
      interests: json['interests']?.cast<String>(),
      employeeCompanyIds:
          json['employeeOf']?.map<String>((e) => e['_id'] as String)?.toList(),
      connections: (json['connections'] as List?)
          ?.map((e) => Connections.fromJson(e as Map<String, dynamic>))
          .toList());

  Map<String, dynamic> toJson() => {
        'username': username,
        'email': email,
        'password': password,
        'bio': bio,
        'darkmode': darkmode,
        'workDomain': workDomain,
        'picture': picture,
        'favroiteCompanies':
            favoriteCompanyIds?.map((id) => {'_id': id}).toList(),
        'favroiteNews': favoriteNews?.map((e) => e.toJson()).toList(),
        'interests': interests,
        'employeeOf': employeeCompanyIds?.map((id) => {'_id': id}).toList(),
        'connections': connections?.map((id) => {'_id': id}).toList(),
      };

  static User dummy = User(
      userid: 'No User',
      username: 'No User',
      email: 'hello@nouser.com',
      password: '',
      darkmode: false);
}

class FavoriteNews {
  final String newsId;
  final DateTime date;

  const FavoriteNews({required this.newsId, required this.date});

  factory FavoriteNews.fromJson(Map<String, dynamic> json) => FavoriteNews(
        newsId: json['newsId']['_id'] as String,
        date: DateTime.fromMillisecondsSinceEpoch(json['date'] as int),
      );

  Map<String, dynamic> toJson() => {
        'newsId': {'_id': newsId},
        'date': date.millisecondsSinceEpoch,
      };
}
