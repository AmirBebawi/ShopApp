import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/modulus/register_screen/register_cubit/register_cubit.dart';
import 'package:shopapp/modulus/register_screen/register_cubit/states.dart';
import 'package:shopapp/shared/cubit/cubit.dart';
import 'package:shopapp/styles/colors.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../layout/shop_layout/shop_layout.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constant.dart';
import '../../shared/network/local/cache_helper.dart';

class RegisterScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            if (state.loginModel.status!) {
              CacheHelper.saveData(
                      key: 'token', value: state.loginModel.data!.token)
                  .then((value) {
                token = state.loginModel.data!.token;
                navigateAndFinish(
                  context,
                  const ShopLayout(),
                );
                showToast(
                    text: state.loginModel.message,
                    state: ToastStates.success);
              });
            } else {
              showToast(
                text: state.loginModel.message,
                state: ToastStates.error,
              );
            }
          }
        },
        builder: (context, state) {
          RegisterCubit cubit = RegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: defaultColor,
              elevation: 0.0,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: defaultColor,
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height,
                  maxWidth: MediaQuery.of(context).size.width,
                ),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      defaultColor,
                      defaultColor,
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Register",
                            style:
                                Theme.of(context).textTheme.headline5!.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 30,
                                    ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            "Register to use our Application",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: ShopCubit.get(context).isDark
                              ? HexColor("333739")
                              : Colors.white,
                          borderRadius: const BorderRadiusDirectional.only(
                            topStart: Radius.circular(40),
                            topEnd: Radius.circular(40),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 50,
                                ),
                                defaultFormField(
                                  isDark: ShopCubit.get(context).isDark,
                                  controller: nameController,
                                  type: TextInputType.name,
                                  validate: (value) {
                                    if (value.isEmpty) {
                                      return 'please enter your name';
                                    }
                                  },
                                  label: 'User Name',
                                  prefix: Icons.person,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                defaultFormField(
                                  isDark: ShopCubit.get(context).isDark,
                                  controller: emailController,
                                  type: TextInputType.emailAddress,
                                  validate: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter your Email address';
                                    }
                                  },
                                  label: 'Email',
                                  prefix: Icons.email_outlined,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                defaultFormField(
                                  isDark: ShopCubit.get(context).isDark,
                                  controller: phoneController,
                                  type: TextInputType.number,
                                  validate: (value) {
                                    if (value.isEmpty) {
                                      return 'please enter your phone number';
                                    }
                                  },
                                  label: 'Phone',
                                  prefix: Icons.phone,
                                ),
                                const SizedBox(
                                  height: 20,
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
                                      cubit.userRegister(
                                        name: nameController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                        phone: phoneController.text,
                                      );
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                ConditionalBuilder(
                                  condition: State is! RegisterLoadingState,
                                  builder: (context) => defaultButton(
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        cubit.userRegister(
                                          name: nameController.text,
                                          email: emailController.text,
                                          password: passwordController.text,
                                          phone: phoneController.text,
                                        );
                                      }
                                    },
                                    text: 'Register',
                                    isUpperCase: false,
                                  ),
                                  fallback: (context) =>
                                      const CircularProgressIndicator(),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
