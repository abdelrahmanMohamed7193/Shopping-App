import 'package:shoppingapp/Screens/shop_login_screen.dart';
import 'package:shoppingapp/network/local/cash_helper.dart';
import 'package:shoppingapp/shared/component.dart';

void SignOut(context){
  CashHelper.removeData (
    key: "token",
  ).then((value) {
    if (value !=null) {
      navigateAndFinish(
        context: context,
        widget: ShopLoginScreen(),
      );
    }
  });
}


String? token= "" ;