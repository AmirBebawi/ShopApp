import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/shared/cubit/states.dart';

import '../../models/categories_model/categories_model.dart';
import '../../models/change_favorites_model/change_favorites_model.dart';
import '../../models/favorites_model/favorites_model.dart';
import '../../models/home_model/home_model.dart';
import '../../models/user_model/user_model.dart';
import '../../modulus/categories_screen/categories_screen.dart';
import '../../modulus/favorite_screen/favorite_screen.dart';
import '../../modulus/products_screen/products_screen.dart';
import '../../modulus/settings_screen/settings_screen.dart';
import '../components/constant.dart';
import '../network/end_points/end_point.dart';
import '../network/local/cache_helper.dart';
import '../network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);
  bool isPassword = true;

  void passwordVisibility() {
    isPassword = !isPassword;
    emit(ShopPasswordVisibilityState());
  }

  bool isDark = true;

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(ShopChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.saveData(key: 'isDark', value: isDark).then((value) {
        emit(ShopChangeModeState());
      });
    }
  }

  int currentIndex = 0;
  List<Widget> items = [
    const Icon(
      Icons.home,
      size: 30,
    ),
    const Icon(Icons.apps_outlined, size: 30),
    const Icon(Icons.favorite, size: 30),
    const Icon(Icons.settings_outlined, size: 30),
  ];
  List<String> titles = [
    'Home',
    'Categories',
    'Favorites',
    'Settings',
  ];
  List<Widget> bottomScreens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoriteScreen(),
    const SettingsScreen(),
  ];

  void changeIndex(index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  bool? isFav;

  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: home,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      for (var element in homeModel!.data.products) {
        favorites.addAll({element.id: element.inFavorites});
      }
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      emit(ShopErrorHomeDataState(error.toString()));
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoriesData() {
    DioHelper.getData(
      url: getCategories,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      emit(ShopErrorCategoriesState(error.toString()));
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(
    int productId,
  ) {
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavoritesState());
    DioHelper.postData(
      url: favorite,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if (!changeFavoritesModel!.status) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavorites();
      }
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      emit(ShopErrorChangeFavoritesState(error.toString()));
    });
  }

  late FavoritesModel favoritesModel;

  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      url: favorite,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      emit(ShopErrorGetFavoritesState(error.toString()));
    });
  }

  UserModel? userModel;

  void getUserData() {
    emit(ShopLoadingGetUserDataState());
    DioHelper.getData(
      url: profile,
      token: token,
    ).then((value) {
      userModel = UserModel.fromJson(value.data);
      emit(ShopSuccessGetUserDataState(userModel!));
    }).catchError((error) {
      emit(ShopErrorGetUserDataState(error.toString()));
    });
  }


  void userUpdateProfile({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(ShopUpdateProfileLoadingState());
    DioHelper.putData(
      url: updateProfile,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
      },
    ).then((value) {
      userModel = UserModel.fromJson(value.data);
      emit(ShopUpdateProfileSuccessState(userModel!));
    }).catchError((error) {
      emit(ShopUpdateProfileErrorState(error.toString()));
    });
  }
}
