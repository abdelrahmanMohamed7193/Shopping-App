import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingapp/Screens/categories_screen.dart';
import 'package:shoppingapp/Screens/favourite_screen.dart';
import 'package:shoppingapp/Screens/product_screen.dart';
import 'package:shoppingapp/Screens/settings_screen.dart';
import 'package:shoppingapp/cubit/shop_states.dart';
import 'package:shoppingapp/models/categories_model.dart';
import 'package:shoppingapp/models/change_favorites_model.dart';
import 'package:shoppingapp/models/favorites_model.dart';

import 'package:shoppingapp/models/home_model.dart';
import 'package:shoppingapp/models/login_model.dart';
import 'package:shoppingapp/network/remote/dio_helper.dart';
import 'package:shoppingapp/network/remote/end_points.dart';
import 'package:shoppingapp/shared/constants.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  List<Widget> bottomScreens = [
    ProductScreen(),
     CategoriesScreen(),
     FavoriteScreen(),
     SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;

  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      methodUrl: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      // print(homeModel!.data!.banners[1].image);
      // print(homeModel!.status);

      homeModel!.data!.products.forEach(
            (element) {
          favorites.addAll({
            element.id: element.inFavorites,
          });
        },
      );

     // print(favorites.toString(),);

      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print("errorrrrr is ${error.toString()}");
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategories() {
    DioHelper.getData(
      methodUrl: GET_CATEGORIES,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopSuccessGetCategoriesState());
    }).catchError((error) {
      print("errorrrrr is ${error.toString()}");
      emit(ShopErrorGetCategoriesState());
    });
  }



late ChangeFavoritesModel changeFavoritesModel ;

   void ChangeFavorites(int productId) {
     favorites[productId] = !favorites[productId]!;
     emit(ShopChangeFavoritesState()) ;

    DioHelper.postData(
      methodUrl: FAVORITES,
      data: {
        'product_id' : productId ,
      },
     token: token,

    ).then((value) {

      changeFavoritesModel=ChangeFavoritesModel.fromJson(value.data) ;
      print(value.data);
      if( !changeFavoritesModel.status!)
      {
        favorites[productId] = !favorites[productId]!;

      }else{
        getFavorites() ;
      }
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel)) ;

    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;

      emit(ShopErrorChangeFavoritesState()) ;

    });
  }


   FavoritesModel? favoritesModel;

  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      methodUrl: FAVORITES,
      token: token ,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
 //print(value.data.toString()) ;
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      print("errorrrrr is ${error.toString()}");
      emit(ShopErrorGetFavoritesState());
    });
  }


   ShopLoginModel? userModel;

  void getUserData() {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      methodUrl:PROFILE ,
      token: token ,
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);

      print(userModel!.data!.name) ;
      emit(ShopSuccessUserDataState(userModel!));
    }).catchError((error) {
      print("errorrrrr is ${error.toString()}");
      emit(ShopErrorUserDataState());
    });
  }


  void updateUserData({
  required String name ,
  required String email ,
  required String phone ,
}) {
    emit(ShopLoadingUpdateUserState());
    DioHelper.putData(
      methodUrl:UPDATR_PROFILE ,
      token: token,
      data: {
        "name" : name ,
        "email" : email ,
        "phone" : phone ,
      } ,
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);

      print(userModel!.data!.name) ;
      emit(ShopSuccessUpdateUserState(userModel!));
    }).catchError((error) {
      print("errorrrrr is ${error.toString()}");
      emit(ShopErrorUpdateUserState());
    });
  }
}

