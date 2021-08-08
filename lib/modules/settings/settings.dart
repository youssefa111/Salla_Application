import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/layout/cubit/shop_cubit.dart';

import 'package:shop_application/shared/components/componants.dart';
import 'package:shop_application/shared/components/constants.dart';

// ignore: must_be_immutable
class SettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;
        emailController.text = model.data.email;
        phoneController.text = model.data.phone;
        nameController.text = model.data.name;
        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder: (ctx) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    if (state is ShopLoadingUpdateUserState)
                      LinearProgressIndicator(),
                    TextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return ' name must not be empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Name",
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return ' email must not be empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Email Address",
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return ' phont must not be empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Phone",
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultButton(
                        function: () {
                          if (formKey.currentState.validate()) {
                            ShopCubit.get(context).updateUserData(
                              name: nameController.text,
                              phone: phoneController.text,
                              email: emailController.text,
                            );
                          }
                        },
                        text: 'UPDATE'),
                    SizedBox(
                      height: 20,
                    ),
                    defaultButton(
                        function: () {
                          signOut(context);
                        },
                        text: 'Logout'),
                  ],
                ),
              ),
            ),
          ),
          fallback: (ctx) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
