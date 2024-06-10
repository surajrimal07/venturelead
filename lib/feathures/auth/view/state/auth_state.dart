import 'package:venturelead/feathures/auth/model/user_model.dart';

class AuthState {
  final bool isLoading;
  final String? error;
  final bool showMessage;
  final User authEntity;

  AuthState({
    required this.isLoading,
    this.error,
    required this.showMessage,
    required this.authEntity,
  });

  factory AuthState.initialState() => AuthState(
        isLoading: false,
        error: null,
        showMessage: false,
        authEntity: User.dummy,
      );

  AuthState copyWith(
      {bool? isLoading,
      String? error,
      bool? showMessage,
      User? authEntity,
      String? userAmount}) {
    return AuthState(
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        showMessage: showMessage ?? this.showMessage,
        authEntity: authEntity ?? this.authEntity);
  }
}
