import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/modulus/search_screen/cubit/states.dart';

import '../../../models/search_model/search_model.dart';
import '../../../shared/components/constant.dart';
import '../../../shared/network/end_points/end_point.dart';
import '../../../shared/network/remote/dio_helper.dart';


class ShopSearchCubit extends Cubit<SearchStates> {
  ShopSearchCubit() : super(SearchInitialState());

  static ShopSearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;

  void search(String text) {
    emit(SearchLoadingState());

    DioHelper.postData(
      url: productsSearch,
      token: token,
      data: {
        'text': text,
      },
    ).then((value) {
      model = SearchModel.fromJson(value.data);

      emit(SearchSuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }

      emit(SearchErrorState());
    });
  }
}