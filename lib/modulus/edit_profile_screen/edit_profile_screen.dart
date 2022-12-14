import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/shop_layout/shop_layout.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constant.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';
import '../../shared/network/local/cache_helper.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopUpdateProfileSuccessState) {
          if (state.userModel.status) {
            CacheHelper.saveData(
                    key: 'token', value: state.userModel.data.token)
                .then((value) {
              token = state.userModel.data.token;
              navigateAndFinish(
                context,
                const ShopLayout(),
              );
              showToast(
                  text: state.userModel.message, state: ToastStates.success);
            });
          } else {
            showToast(
              text: state.userModel.message,
              state: ToastStates.error,
            );
          }
        }
      },
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        nameController.text = cubit.userModel!.data.name.toString();
        emailController.text = cubit.userModel!.data.email.toString();
        phoneController.text = cubit.userModel!.data.phone.toString();
        return ConditionalBuilder(
          condition: cubit.userModel != null,
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: const Text(
                'Edit Profile',
              ),
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  width: double.infinity,
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Container(
                              width: 150.0,
                              height: 150.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      NetworkImage(cubit.userModel!.data.image),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(75.0)),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 2.0,
                                ),
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.black.withOpacity(.5),
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          isDark: ShopCubit.get(context).isDark,
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Name must not be empty';
                            } else {
                              return null;
                            }
                          },
                          label: 'Name',
                          prefix: Icons.person,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        defaultFormField(
                          isDark: ShopCubit.get(context).isDark,
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Email Address must not be empty';
                            } else {
                              return null;
                            }
                          },
                          label: 'Email Address',
                          prefix: Icons.email,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        defaultFormField(
                          isDark: ShopCubit.get(context).isDark,
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Phone Number must not be empty';
                            } else {
                              return null;
                            }
                          },
                          label: 'Phone Number',
                          prefix: Icons.phone,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        defaultFormField(
                          isDark: ShopCubit.get(context).isDark,
                          controller: passwordController,
                          isPassword: cubit.isPassword,
                          type: TextInputType.text,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'Password is too short';
                            }
                          },
                          label: 'Password',
                          prefix: Icons.lock_outline,
                          suffix: cubit.isPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          suffixPressed: () {
                            cubit.passwordVisibility();
                          },
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              cubit.userUpdateProfile(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                phone: phoneController.text,
                              );
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        ConditionalBuilder(
                          condition: State is! ShopUpdateProfileLoadingState,
                          builder: (context) => defaultButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                cubit.userUpdateProfile(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            text: 'Save',
                            isUpperCase: false,
                          ),
                          fallback: (context) =>
                              const CircularProgressIndicator(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
