import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_project/cubit/states.dart';
import 'package:shop_project/models/profileModels/userModel.dart';
import 'package:shop_project/remoteNetwork/dioHelper.dart';
import 'package:shop_project/remoteNetwork/endPoints.dart';
import 'package:shop_project/shared/constants.dart';

class LoginCubit extends Cubit<ShopStates> {
  LoginCubit() : super(InitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  UserModel? loginModel;
  void signIn({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(url: LOGIN, token: token, data: {
      'email': '$email',
      'password': '$password',
    }).then((value) {
      loginModel = UserModel.fromJson(value.data);
      emit(LoginSuccessState(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorState());
    });
  }

  bool showPassword = false;
  IconData suffixIcon = Icons.visibility;
  void changeSuffixIcon(context) {
    showPassword = !showPassword;
    if (showPassword)
      suffixIcon = Icons.visibility_off;
    else
      suffixIcon = Icons.visibility;
    emit(ChangeSuffixIconState());
  }
}
