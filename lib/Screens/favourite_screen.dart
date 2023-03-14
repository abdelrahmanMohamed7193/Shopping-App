import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingapp/cubit/shop_cubit.dart';
import 'package:shoppingapp/cubit/shop_states.dart';
import 'package:shoppingapp/models/favorites_model.dart';
import 'package:shoppingapp/shared/component.dart';
import 'package:shoppingapp/shared/styles/colors.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) => ConditionalBuilder(
        condition:state is! ShopLoadingGetFavoritesState ,
        builder:(context) => ListView.separated(
          itemBuilder: (context, index) => buildListProduct(ShopCubit.get(context).favoritesModel!.data!.data[index].product! ,context ),
          separatorBuilder: (context, index) =>  const Divider(
            height: 10.0,
            thickness: 1.0,
          ),
          itemCount: ShopCubit.get(context).favoritesModel!.data!.data.length,
        ),
        fallback: (BuildContext context)=>const Center(child:  CircularProgressIndicator()),

      ),
    );
  }

}
