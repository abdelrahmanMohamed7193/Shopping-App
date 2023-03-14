import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingapp/cubit/search_Cubit/saerch_states.dart';
import 'package:shoppingapp/cubit/search_Cubit/search_cubit.dart';
import 'package:shoppingapp/shared/component.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var SearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(),
              body: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      myTextField(
                        onSubmit: (String text) {
                          if (formKey.currentState!.validate()) {
                            SearchCubit.get(context)
                                .Search(SearchController.text);
                          }
                        },
                        prefixIcon: Icons.search,
                        onTap: () {},
                        validateText: 'enter text to search',
                        controller: SearchController,
                        label: 'search',
                        type: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      if (state is SearchLoadingState)
                        LinearProgressIndicator(),
                      const SizedBox(
                        height: 10.0,
                      ),
                      if (state is SearchSuccessState)
                        Expanded(
                          child: ListView.separated(
                            itemBuilder: (context, index) => buildListProduct(
                              SearchCubit.get(context).model!.data!.data[index],
                              context,
                              isOldPrice: false,
                            ),
                            separatorBuilder: (context, index) => const Divider(
                              height: 10.0,
                              thickness: 1.0,
                            ),
                            itemCount: SearchCubit.get(context)
                                .model!
                                .data!
                                .data
                                .length,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
