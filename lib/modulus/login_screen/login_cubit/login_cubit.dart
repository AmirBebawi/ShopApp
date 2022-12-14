import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/login_model/login_model.dart';
import 'package:shopapp/modulus/login_screen/login_cubit/states.dart';
import 'package:shopapp/shared/network/end_points/end_point.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);
  bool isPassword = true;

  void passwordVisibility() {
    isPassword = !isPassword;
    emit(LoginPasswordVisibilityState());
  }
   LoginModel ? loginModel ;
  void userLogin({
    @required String? email,
    @required String? password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(url: login, data: {
      'email': email,
      'password': password,
    }).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(LoginSuccessState(loginModel!));

    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
    });
  }
}
