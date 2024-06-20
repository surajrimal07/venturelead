import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:venturelead/core/toast.dart';
import 'package:venturelead/core/utils/failure.dart';

class UserSharedPrefss extends GetxController {
  static final UserSharedPrefss _instance = UserSharedPrefss._internal();

  factory UserSharedPrefss() {
    return _instance;
  }

  UserSharedPrefss._internal();

  late SharedPreferences _sharedPreferences;

  Future<bool> saveData<T>(String key, T data) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();

      if (data is String) {
        await _sharedPreferences.setString(key, data);
      } else if (data is int) {
        await _sharedPreferences.setInt(key, data);
      } else if (data is double) {
        await _sharedPreferences.setDouble(key, data);
      } else if (data is bool) {
        await _sharedPreferences.setBool(key, data);
      } else {
        final errorMessage = 'Unsupported data type: ${T.toString()}';
        CustomToast.showToast(errorMessage);
        return false;
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<T?> getData<T>(String key) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();

      if (T == String) {
        return _sharedPreferences.getString(key) as T?;
      } else if (T == int) {
        return _sharedPreferences.getInt(key) as T?;
      } else if (T == double) {
        return _sharedPreferences.getDouble(key) as T?;
      } else if (T == bool) {
        return _sharedPreferences.getBool(key) as T?;
      } else {
        final errorMessage = 'Unsupported data type: ${T.toString()}';
        CustomToast.showToast(errorMessage);
        throw Failure(error: errorMessage);
      }
    } catch (e) {
      throw Failure(error: e.toString());
    }
  }

  Future<Either<Failure, bool>> deleteData(String key) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.remove(key);
      return right(true);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }
}
