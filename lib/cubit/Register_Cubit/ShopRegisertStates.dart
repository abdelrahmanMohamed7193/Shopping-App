import 'package:shoppingapp/models/login_model.dart';

abstract class ShoppRegisterStates{}
class ShopRegisterInitialState extends ShoppRegisterStates{}

class ShopRegisterLoadingState extends ShoppRegisterStates{}
class ShopRegisterSuccessState extends ShoppRegisterStates
{
final ShopLoginModel loginModel;

  ShopRegisterSuccessState(this.loginModel);
}
class ShopRegisterErrorState extends ShoppRegisterStates{
  final String error ;

  ShopRegisterErrorState(this.error);

}

class ShopRegisterChangPasswordVisibilityState extends ShoppRegisterStates{}
