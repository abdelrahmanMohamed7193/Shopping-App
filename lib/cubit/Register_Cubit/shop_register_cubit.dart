
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingapp/models/login_model.dart';
import 'package:shoppingapp/network/remote/end_points.dart';

import '../../network/remote/dio_helper.dart';
import 'ShopRegisertStates.dart';


class ShoppRegisterCubit extends Cubit<ShoppRegisterStates> {
  ShoppRegisterCubit() : super(ShopRegisterInitialState());

  static ShoppRegisterCubit get(context) => BlocProvider.of(context);

  late ShopLoginModel loginModel ;

  void userRegister({
  required String name,
  required String email,
  required String password,
  required String phone,
}) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
      methodUrl:REGISTER ,
      data: {
        "name":name,
        "email":email,
        "password":password,
        "phone":phone,
      },
    ).then((value){
     //print(value.data);
     loginModel= ShopLoginModel.fromJson(value.data);
//print(loginModel!.data!.token);

print(loginModel.status);
//print(loginModel!.message);
emit(ShopRegisterSuccessState(loginModel));

    }).catchError((error){
 print("the errrrrrrrrrorrrrrrrrr is ${error.toString()}");
      emit(ShopRegisterErrorState(error.toString()));

      });
   }


IconData suffix=Icons.visibility_off_outlined;
  bool isPassword=true;
  void shopChangPasswordVisibility(){
    isPassword=!isPassword;
suffix=isPassword?Icons.visibility_outlined:Icons.visibility_off_outlined ;
    emit(ShopRegisterChangPasswordVisibilityState()) ;

  }

}
