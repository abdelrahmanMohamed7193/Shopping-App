import 'package:shoppingapp/models/login_model.dart';

abstract class ShoppLoginStates{}
class ShopLoginInitialState extends ShoppLoginStates{}

class ShopLoginLoadingState extends ShoppLoginStates{}
class ShopLoginSuccessState extends ShoppLoginStates
{
final ShopLoginModel loginModel;

  ShopLoginSuccessState(this.loginModel);
}
class ShopLoginErrorState extends ShoppLoginStates{
  final String error ;

  ShopLoginErrorState(this.error);

}

class ShopChangPasswordVisibilityState extends ShoppLoginStates{}
