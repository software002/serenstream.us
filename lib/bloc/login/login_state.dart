part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class UpdateLoginPasswordVisibilityState extends LoginState {
  bool isObsecure;
  String type;

  UpdateLoginPasswordVisibilityState(this.isObsecure, this.type);
}

class LoginStateLoaded extends LoginState{

}

class SavedLoginData extends LoginState {
  SavedLoginData();
}

