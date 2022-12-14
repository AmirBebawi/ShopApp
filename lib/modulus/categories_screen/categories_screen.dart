import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/categories_model/categories_model.dart';
import '../../shared/components/components.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => categoriesBuilder(
              cubit.categoriesModel!.data.data[index], context),
          separatorBuilder: (context, index) => buildMyDivider(),
          itemCount: cubit.categoriesModel!.data.data.length,
        );
      },
    );
  }

  Widget categoriesBuilder(DataModel model, context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(
                model.image,
              ),
              width: 80.0,
              height: 80.0,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              width: 20.0,
            ),
            Text(
              model.name,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color:
                    ShopCubit.get(context).isDark ? Colors.white : Colors.black,
              ),
            ),
            const Spacer(),
             Icon(
              Icons.arrow_forward_ios,
              color: ShopCubit.get(context).isDark
                  ? Colors.white
                  : Colors.black,
            ),
          ],
        ),
      );
}
