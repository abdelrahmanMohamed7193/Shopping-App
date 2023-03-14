import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingapp/cubit/Login_Cubit/ShopLoginStates.dart';
import 'package:shoppingapp/cubit/Login_Cubit/shop_login_cubit.dart';
import 'package:shoppingapp/shared/constants.dart';

import '../network/local/cash_helper.dart';
import '../shared/component.dart';
import 'Shop_Register_Screen.dart';
import 'shop_layout.dart';

class ShopLoginScreen extends StatelessWidget {
  ShopLoginScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => ShoppLoginCubit(),
      child: BlocConsumer<ShoppLoginCubit, ShoppLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
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
                token=state.loginModel.data!.token ;

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
        print(state.loginModel.message.toString()+'this is LOGIN ERROR');

            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("LOGIN",
                            style: TextStyle(
                              fontSize: 35.0,
                              fontWeight: FontWeight.bold,
                            )),
                        const SizedBox(
                          height: 20.0,
                        ),
                        const Text("Login Now To get our Hot Offers",
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.grey,
                            )),
                        const SizedBox(
                          height: 30,
                        ),
                        myTextField(
                          onSubmit: (){},
                          prefixIcon: Icons.email,
                          validateText: "Please Enter Your Email Address",
                          controller: emailController,
                          label: " Email Address",
                          onChanged: () {},
                          onTap: () {},
                          type: TextInputType.emailAddress,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        myTextField(
                          prefixIcon: Icons.lock_clock_outlined,
                          suffixIcon: ShoppLoginCubit.get(context).suffix,
                          validateText: "Please Enter Your PassWord",
                          controller: passwordController,
                          label: " Password",
                          isPassword: ShoppLoginCubit.get(context).isPassword,
                          SuffixPressed: () {
                            ShoppLoginCubit.get(context)
                                .shopChangPasswordVisibility();
                          },
                          onChanged: () {},
                          onTap: () {},
                          type: TextInputType.visiblePassword, onSubmit: (){},
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) => myButton(
                              text: "LOGIN",
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  ShoppLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              }),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't Have An Account?"),
                            myDefaultTextButton(
                                function: () {
                                  navigateAndFinish(
                                    context: context,
                                    widget:  ShopRegisterScreen(),
                                  );
                                },
                                text: "Register Now"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
