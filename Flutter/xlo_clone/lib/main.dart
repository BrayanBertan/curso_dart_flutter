import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_clone/stores/categoria_store.dart';
import 'package:xlo_clone/stores/connectivity_store.dart';
import 'package:xlo_clone/stores/favorite_store.dart';
import 'package:xlo_clone/stores/home_store.dart';
import 'package:xlo_clone/stores/page_store.dart';
import 'package:xlo_clone/stores/user_manager_store.dart';
import 'package:xlo_clone/teste.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeParse();
  setupLocators();
  runApp(MyApp());
}

Future<void> initializeParse() async {
  await Parse().initialize('X63RfSrhjyxd6xC6SkxjfVLyPOtIn4WLdhkazgEM',
      'https://parseapi.back4app.com/',
      clientKey: 'tXXerHtVnpiE021YzrVKCb4qMvpCEeUY7tq0yQAN',
      autoSendSessionId: true,
      debug: true);
}

void setupLocators() {
  GetIt.I.registerSingleton(ConnectivityStore());
  GetIt.I.registerSingleton(PageStore());
  GetIt.I.registerSingleton(HomeStore());
  GetIt.I.registerSingleton(UserManagerStore());
  GetIt.I.registerSingleton(CategoriaStore());
  GetIt.I.registerSingleton(FavoriteStore());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      theme: ThemeData(
          primaryColor: Colors.purple.shade500,
          scaffoldBackgroundColor: Colors.purple.shade500,
          appBarTheme: AppBarTheme(elevation: 0),
          cursorColor: Colors.orange),
      home: TestPage(),
    );
  }
}
