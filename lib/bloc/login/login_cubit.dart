import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';


part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

}
