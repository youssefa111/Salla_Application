part of 'shop_cubit.dart';

@immutable
abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottmNavState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSucessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {}

class ShopSucessCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {}

class ShopChangeFavoritesState extends ShopStates {}

class ShopSucessChangeFavoritesState extends ShopStates {
  final ChangeFavoritesModel model;

  ShopSucessChangeFavoritesState(this.model);
}

class ShopErrorChangeFavoritesState extends ShopStates {}

class ShopLoadingGetFavroitesState extends ShopStates {}

class ShopSucessGetFavroitesState extends ShopStates {}

class ShopErrorGetFavroitesState extends ShopStates {}

class ShopLoadingUserDataState extends ShopStates {}

class ShopSucessUserDataState extends ShopStates {
  final ShopLoginModel loginModel;

  ShopSucessUserDataState(this.loginModel);
}

class ShopErrorUserDataState extends ShopStates {}

class ShopLoadingUpdateUserState extends ShopStates {}

class ShopSucessUpdateUserState extends ShopStates {
  final ShopLoginModel loginModel;

  ShopSucessUpdateUserState(this.loginModel);
}

class ShopErrorUpdateUserState extends ShopStates {}
