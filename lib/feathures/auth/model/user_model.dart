import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class UserModelController extends GetxController {
  final Rx<User> _user = Rx(User.dummy);

  User get user => _user.value;

  void setUser(User newUser) {
    _user.value = newUser;
  }
}

class User {
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
  final List<String>? connectionIds;

  const User({
    required this.username,
    required this.email,
    required this.password,
    this.bio,
    this.darkmode = false,
    this.workDomain,
    this.picture,
    this.favoriteCompanyIds,
    this.favoriteNews,
    this.interests,
    this.employeeCompanyIds,
    this.connectionIds,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
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
        employeeCompanyIds: json['employeeOf']
            ?.map<String>((e) => e['_id'] as String)
            ?.toList(),
        connectionIds: json['connections']
            ?.map<String>((e) => e['_id'] as String)
            ?.toList(),
      );

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
        'connections': connectionIds?.map((id) => {'_id': id}).toList(),
      };

  static const dummy = User(
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
