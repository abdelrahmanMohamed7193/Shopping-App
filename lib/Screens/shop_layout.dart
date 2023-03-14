import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingapp/Screens/search_screen.dart';
import 'package:shoppingapp/cubit/shop_cubit.dart';
import 'package:shoppingapp/cubit/shop_states.dart';
import 'package:shoppingapp/shared/component.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: const Center(
              child: Text(
                "SALLA",
                style: TextStyle(color: Colors.black),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {

                  navigateTo(
                    context: context,
                    widget:  SearchScreen(),
                  );
                },
                icon: const Icon(
                  Icons.search,
                ),
              ),
            ],
          ),
          body: ShopCubit.get(context).bottomScreens[ShopCubit.get(context).currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              ShopCubit.get(context).changeBottom(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.apps),
                label: "categories",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: "Favourite",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "Settings",
              ),
            ],
            currentIndex: ShopCubit.get(context).currentIndex,
          ),
        ),
      ) ;

  }
}
