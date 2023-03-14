import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingapp/cubit/shop_cubit.dart';
import 'package:shoppingapp/cubit/shop_states.dart';
import 'package:shoppingapp/shared/component.dart';
import 'package:shoppingapp/shared/constants.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  var formKey =GlobalKey<FormState>() ;

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(listener: (context, state) {
      if (state is ShopSuccessUserDataState) {
        nameController.text = state.loginModel.data!.name!;
        emailController.text = state.loginModel.data!.email!;
        phoneController.text = state.loginModel.data!.phone!;
      }
    }, builder: (context, state) {
      var model = ShopCubit
          .get(context)
          .userModel;
      if (model != null) {
        nameController.text = model.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;
      }

      return ConditionalBuilder(
          condition: ShopCubit
              .get(context)
              .userModel != null,
          builder: (context) =>
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      if(state is ShopLoadingUpdateUserState)
                        const LinearProgressIndicator() ,
                      myTextField(
                        type: TextInputType.name,
                        prefixIcon: Icons.person,
                        onTap: () {},
                        validateText: " Name must not be empty",
                        onChanged: () {},
                        controller: nameController,
                        label: "name",
                        onSubmit:(){},
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      myTextField(
                        type: TextInputType.emailAddress,
                        prefixIcon: Icons.email,
                        onTap: () {},
                        validateText: " email must not be empty",
                        onChanged: () {},
                        controller: emailController,
                        label: "email", 
                        onSubmit: (){},
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      myTextField(
                        type: TextInputType.phone,
                        prefixIcon: Icons.phone,
                        onTap: () {},
                        validateText: " phone must not be empty",
                        onChanged: () {},
                        controller: phoneController,
                        label: "phone", onSubmit: (){},
                      ),
                      SizedBox(
                        height: 10.0,
                      ),

                      myButton(
                        text: 'LogOut',
                        onTap: () {
                         SignOut(context) ;
                        },
                      ),
                      SizedBox(height: 15.0,),
                      myButton(
                        text: 'Update',
                        onTap: () {
                          if(formKey.currentState!.validate())
                          {
                            ShopCubit.get(context).updateUserData(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                            );
                          }

                        },
                      ),
                    ],
                  ),
                ),
              ),
          fallback: (context) => Center(child: CircularProgressIndicator()));
    });
  }
}
