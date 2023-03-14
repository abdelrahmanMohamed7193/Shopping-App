import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingapp/Screens/shop_layout.dart';
import 'package:shoppingapp/cubit/Login_Cubit/ShopLoginStates.dart';
import 'package:shoppingapp/cubit/Register_Cubit/ShopRegisertStates.dart';
import 'package:shoppingapp/cubit/Register_Cubit/shop_register_cubit.dart';
import 'package:shoppingapp/network/local/cash_helper.dart';
import 'package:shoppingapp/shared/component.dart';
import 'package:shoppingapp/shared/constants.dart';

class ShopRegisterScreen extends StatelessWidget {
   ShopRegisterScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
   var nameController = TextEditingController();
   var emailController = TextEditingController();
   var passwordController = TextEditingController();
   var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (BuildContext context) =>ShoppRegisterCubit() ,
      child: BlocConsumer<ShoppRegisterCubit,ShoppRegisterStates>(
        listener: (context ,state)
        {
          if (state is ShopRegisterSuccessState) {
            if (state.loginModel.status!) {
              navigateAndFinish(
                context: context,
                widget:   ShopLayout(),

              );

              print(state.loginModel.message);
              print(state.loginModel.data!.token);

              CashHelper.saveData(
                key: "token",
                value: state.loginModel.data!.token,


              ).then((value) {
                token =state.loginModel.data!.token! ;
                navigateAndFinish(
                  context: context,
                  widget:  const ShopLayout(),

                );
              });
            } else {

              showToast(
                text: state.loginModel.message!,
                state: ToastStates.ERROR,
              );
              print(state.loginModel.message.toString()+'this is Register ERROR');

            }
          }
        } ,
        builder: (context,state) {
        return  Scaffold(
          appBar: AppBar(
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Register",
                          style: TextStyle(
                            fontSize: 35.0,
                            fontWeight: FontWeight.bold,
                          )),
                      const SizedBox(
                        height: 20.0,
                      ),
                      const Text("Register Now To get our Hot Offers",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.grey,
                          )),
                      const SizedBox(
                        height: 30,
                      ),



                      myTextField(
                        onSubmit: (){},
                        prefixIcon: Icons.person,
                        validateText: "Please Enter Your name",
                        controller: nameController,
                        label: " Name",
                        onChanged: () {},
                        onTap: () {},
                        type: TextInputType.name,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      myTextField(
                        onSubmit: (){},
                        prefixIcon: Icons.email,
                        validateText: "Please Enter Your email",
                        controller: emailController,
                        label: "Email",
                        onChanged: () {},
                        onTap: () {},
                        type: TextInputType.emailAddress,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),


                      myTextField(
                        prefixIcon: Icons.lock_clock_outlined,
                        suffixIcon: ShoppRegisterCubit.get(context).suffix,
                        validateText: "Please Enter Your PassWord",
                        controller: passwordController,
                        label: " Password",
                        isPassword: ShoppRegisterCubit.get(context).isPassword,
                        SuffixPressed: () {
                          ShoppRegisterCubit.get(context)
                              .shopChangPasswordVisibility();
                        },
                        onChanged: () {},
                        onTap: () {},
                        type: TextInputType.visiblePassword, onSubmit: (){},
                      ),
                      myTextField(
                        prefixIcon: Icons.phone,
                        validateText: "Please Enter Your phone number",
                        controller: phoneController,
                        label: "phone",
                        onChanged: () {},
                        onTap: () {},
                        type: TextInputType.phone, onSubmit: (){},
                      ),
                      ConditionalBuilder(
                        condition: state is! ShopRegisterLoadingState  ,
                        builder: (context) => myButton(
                            text: "Register",
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                ShoppRegisterCubit.get(context).userRegister(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,

                                );
                              }
                            }),
                        fallback: (context) =>
                        const Center(child: CircularProgressIndicator()),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
        ) ;
        }

      ),
    );

  }
}
