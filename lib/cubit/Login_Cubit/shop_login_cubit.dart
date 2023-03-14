
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingapp/cubit/Login_Cubit/ShopLoginStates.dart';
import 'package:shoppingapp/models/login_model.dart';
import 'package:shoppingapp/network/remote/end_points.dart';

import '../../network/remote/dio_helper.dart';


class ShoppLoginCubit extends Cubit<ShoppLoginStates> {
  ShoppLoginCubit() : super(ShopLoginInitialState());

  static ShoppLoginCubit get(context) => BlocProvider.of(context);
late ShopLoginModel loginModel ;

  void userLogin({
  required String email,
  required String password,
}) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
      methodUrl:LOGIN,
      data: {
        "email":email,
        "password":password,
      },
    ).then((value){
     //print(value.data);
     loginModel= ShopLoginModel.fromJson(value.data);
//print(loginModel!.data!.token);
print(loginModel.status);
//print(loginModel!.message);
emit(ShopLoginSuccessState(loginModel));

    }).catchError((error){
 print("the errrrrrrrrrorrrrrrrrr is ${error.toString()}");
      emit(ShopLoginErrorState(error.toString()));

      });
   }


IconData suffix=Icons.visibility_off_outlined;
  bool isPassword=true;
  void shopChangPasswordVisibility(){
    isPassword=!isPassword;
suffix=isPassword?Icons.visibility_outlined:Icons.visibility_off_outlined ;
    emit(ShopChangPasswordVisibilityState()) ;

  }

}
