
import '../../models/change_favorites_model/change_favorites_model.dart';
import '../../models/user_model/user_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeModeState extends ShopStates {}

class ShopPasswordVisibilityState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {
  final String error;

  ShopErrorHomeDataState(this.error);
}

class ShopSuccessCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {
  final String error;

  ShopErrorCategoriesState(this.error);
}

class ShopSuccessGetFavoritesState extends ShopStates {}

class ShopLoadingGetFavoritesState extends ShopStates {}

class ShopErrorGetFavoritesState extends ShopStates {
  final String error;

  ShopErrorGetFavoritesState(this.error);
}

class ShopSuccessChangeFavoritesState extends ShopStates {
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavoritesState(this.model);
}

class ShopChangeFavoritesState extends ShopStates {}

class ShopErrorChangeFavoritesState extends ShopStates {
  final String error;

  ShopErrorChangeFavoritesState(this.error);
}

class ShopSuccessGetUserDataState extends ShopStates {
  final UserModel userModel;

  ShopSuccessGetUserDataState(this.userModel);
}

class ShopErrorGetUserDataState extends ShopStates {
  final String error;

  ShopErrorGetUserDataState(this.error);
}

class ShopLoadingGetUserDataState extends ShopStates {}
class ShopUpdateProfileLoadingState extends ShopStates {}

class ShopUpdateProfileSuccessState extends ShopStates {
  final UserModel userModel;

  ShopUpdateProfileSuccessState(this.userModel);
}

class ShopUpdateProfileErrorState extends ShopStates {
  final String error;

  ShopUpdateProfileErrorState(this.error);
}
