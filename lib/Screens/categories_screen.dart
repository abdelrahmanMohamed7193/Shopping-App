import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingapp/cubit/shop_cubit.dart';
import 'package:shoppingapp/cubit/shop_states.dart';
import 'package:shoppingapp/models/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) => ListView.separated(
        itemBuilder: (context, index) => buildCatItem(ShopCubit.get(context).categoriesModel!.data.data[index]),
        separatorBuilder: (context, index) =>  const Divider(
          height: 10.0,
          thickness: 1.0,
        ),
        itemCount: ShopCubit.get(context).categoriesModel!.data.data.length,
      ),
    );
  }

  Widget buildCatItem(DataModel? model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children:  [
            Image(
              image: NetworkImage(model!.image),
              height: 100,
              width: 100,
            ),
            const SizedBox(
              width: 10.0,
            ),
            Text(
              model.name,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
            ),
          ],
        ),
      );
}
