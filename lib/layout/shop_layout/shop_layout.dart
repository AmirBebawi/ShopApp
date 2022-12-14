import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';


import '../../modulus/search_screen/search_screen.dart';
import '../../shared/components/components.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';
import '../../styles/colors.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.currentIndex],
              style:  TextStyle(
                color: ShopCubit.get(context).isDark ? Colors.white :Colors.black,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  navigateTo(
                    context,
                     const SearchScreen(),
                  );
                },
                icon: const Icon(
                  Icons.search,
                ),
              ),
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: CurvedNavigationBar(
            items: cubit.items,
            index: cubit.currentIndex,
            height: 60.0,
            color:ShopCubit.get(context).isDark ? HexColor("333739") : defaultColor,
            buttonBackgroundColor: ShopCubit.get(context).isDark ? HexColor("333739") :Colors.white,
            backgroundColor: ShopCubit.get(context).isDark ? HexColor("333739") :Colors.white,
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 600),
            onTap: (index) {
              cubit.changeIndex(index);
            },
            letIndexChange: (index) => true,
          ),
        );
      },
    );
  }
}
