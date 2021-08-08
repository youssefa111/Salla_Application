import 'package:shop_application/modules/login/shop_login_screen.dart';
import 'package:shop_application/shared/components/componants.dart';
import 'package:shop_application/shared/network/local/cache_helper.dart';

void signOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) {
      navigateAndFinish(context, ShopLoginScreen());
    }
  });
}

String token = '';
