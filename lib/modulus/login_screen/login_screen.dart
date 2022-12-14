import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shopapp/layout/shop_layout/shop_layout.dart';
import 'package:shopapp/modulus/login_screen/login_cubit/login_cubit.dart';
import 'package:shopapp/modulus/login_screen/login_cubit/states.dart';
import 'package:shopapp/modulus/register_screen/register_screen.dart';
import 'package:shopapp/shared/components/constant.dart';
import 'package:shopapp/shared/network/local/cache_helper.dart';
import '../../shared/components/components.dart';
import '../../shared/cubit/cubit.dart';

class LoginScreen extends StatelessWidget {


 const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.loginModel.status!) {
              CacheHelper.saveData(
                      key: 'token', value: state.loginModel.data!.token)
                  .then((value) {
                    token = state.loginModel.data!.token ;
                navigateAndFinish(
                  context,
                  const ShopLayout(),
                );
                showToast(text: state.loginModel.message, state: ToastStates.success);
                if (kDebugMode) {
                  print(state.loginModel.message);
                }
                if (kDebugMode) {
                  print(state.loginModel.data!.token);
                }
              });
            } else {
              if (kDebugMode) {
                print(state.loginModel.message);
              }
              showToast(
                text: state.loginModel.message,
                state: ToastStates.error,
              );
            }
          }
        },
        builder: (context, state) {
          LoginCubit cubit = LoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.deepPurple,
              elevation: 0.0,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.deepPurple,
              ),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height,
                    maxWidth: MediaQuery.of(context).size.width,
                  ),
                  decoration:  const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.deepPurple,
                        Colors.deepPurple,
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
                              "Welcome",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 30,
                                  ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              "Login to use our Application",
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
                          decoration:  BoxDecoration(
                            color:ShopCubit.get(context).isDark
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
                                  const Image(
                                    image: AssetImage(
                                      'assets/login_screen/login4.png',
                                    ),
                                    width: 200,
                                    height: 200,
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
                                        cubit.userLogin(
                                            email: emailController.text,
                                            password: passwordController.text);
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  ConditionalBuilder(
                                    condition: State is! LoginLoadingState,
                                    builder: (context) => defaultButton(
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          cubit.userLogin(
                                              email: emailController.text,
                                              password:
                                                  passwordController.text);
                                        }
                                      },
                                      text: 'Sign in',
                                      isUpperCase: false,
                                    ),
                                    fallback: (context) =>
                                        const CircularProgressIndicator(),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Don\'t have an account ? ',
                                        style: TextStyle(
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                      defaultTextButton(
                                        onPressed: () {
                                          navigateAndFinish(
                                            context,
                                            RegisterScreen(),
                                          );
                                        },
                                        text: 'Register Now',
                                      ),
                                    ],
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
            ),
          );
        },
      ),
    );
  }
}
