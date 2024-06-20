import 'package:get/get.dart';
import 'package:venturelead/feathures/auth/model/user_model.dart';
import 'package:venturelead/feathures/auth/view/state/auth_state.dart';

class AuthController extends GetxController {
  var authState = AuthState.initialState().obs;

  void updateAuthState(AuthState newState) {
    authState.value = newState;
  }

  void setLoading(bool isLoading) {
    authState.value = authState.value.copyWith(isLoading: isLoading);
  }

  void setError(String? error) {
    authState.value = authState.value.copyWith(error: error);
  }

  void setShowMessage(bool showMessage) {
    authState.value = authState.value.copyWith(showMessage: showMessage);
  }

  void setAuthEntity(User authEntity) {
    authState.value = authState.value.copyWith(authEntity: authEntity);
  }

  void getAuthEntity() {
    authState.value = authState.value.copyWith(authEntity: authState.value.authEntity);
  }

  void clear() {
    authState.value = AuthState.initialState();
  }
}

class ApiStateController extends GetxController {
  final RxString apiError = RxString("");
  final RxString apiSuccess = RxString("");

  void updateApiError(String? error) {
    if (error != null) {
      apiError.value = error;
    }
  }

  void updateApiSuccess(String? successMessage) {
    if (successMessage != null) {
      apiSuccess.value = successMessage;
    }
  }
}
