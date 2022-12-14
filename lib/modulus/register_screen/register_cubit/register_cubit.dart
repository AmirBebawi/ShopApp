import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/register_model/register_model.dart';
import 'package:shopapp/modulus/register_screen/register_cubit/states.dart';
import 'package:shopapp/shared/network/end_points/end_point.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);
  bool isPassword = true;

  void passwordVisibility() {
    isPassword = !isPassword;
    emit(RegisterPasswordVisibilityState());
  }
   RegisterModel? registerModel ;
  void userRegister(
  {
  required String name ,
  required String email ,
  required String password ,
  required String phone ,
}
      )
  {
    emit(RegisterLoadingState());
    DioHelper.postData(url: register, data:{
      'name':name ,
      'email':email ,
      'phone':phone ,
      'password':password ,
    }).then((value){
      registerModel = RegisterModel.fromJson(value.data);
      emit(RegisterSuccessState(registerModel!));
    }).catchError((error){
      emit(RegisterErrorState(error.toString()));
    });

  }
}

