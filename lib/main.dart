import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:spear_motors/Dashb/addCar.dart';
import 'package:spear_motors/Dashb/dashboard.dart';
import 'package:spear_motors/Dashb/help.dart';
import 'package:spear_motors/Dashb/profile.dart';
import 'package:spear_motors/Dashb/reqService.dart';
import 'package:spear_motors/Dashb/tips.dart';
import 'package:spear_motors/Login/ForgotPassword.dart';
import 'package:spear_motors/Login/Login.dart';
import 'package:spear_motors/Login/Register.dart';
import 'package:spear_motors/Storage.dart';
import 'package:spear_motors/data/LocalKeyValuePersistence.dart';
import 'package:spear_motors/models/CarStore.dart';
import 'package:spear_motors/models/Store.dart';
import 'package:spear_motors/models/User.dart';
import 'package:spear_motors/splash/SplashScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static Store store = Store([]);
  static var provider = CarStore(store, null);
  Widget fut() {
    return FutureBuilder<Storage>(
      future: Storage.create(repository: LocalKeyValuePersistence()),
      builder: (context, snapshot) {
        final repository = snapshot.data;
        provider = CarStore(store, repository);

        return MultiProvider(
          providers: [ChangeNotifierProvider.value(value: provider)],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(primarySwatch: Colors.blue),
            home: Scaffold(body: SplashScreen()),
            onGenerateRoute: (settings) {
              return MaterialPageRoute(
                  builder: (context) {
                    return _makeRoute(
                        context: context,
                        routeName: settings.name,
                        arguments: settings.arguments);
                  },
                  maintainState: true,
                  fullscreenDialog: false);
            },
          ),
        );
      },
    );
  }

  Widget _makeRoute(
      {@required BuildContext context,
      @required String routeName,
      Object arguments}) {
    final Widget child = _buildRoute(
      context: context,
      routeName: routeName,
      arguments: arguments,
    );
    return child;
  }

  Future<User> checkData(User user) async {
    return User(
        name: user.name,
        id: user.id,
        photoUrl: user.photoUrl,
        photo: user.photo,
        email: user.email,
        title: user.title,
        dob: user.dob,
        res: user.res,
        phone: user.phone);
  }

  Widget _buildRoute({
    @required BuildContext context,
    @required String routeName,
    Object arguments,
  }) {
    switch (routeName) {
      case '/tips':
      return MultiProvider(providers: [
        ChangeNotifierProvider.value(value: provider),
      ],
      child: Tips(),);
      case '/forgotPasswd':
        return MultiProvider(
          providers: [ChangeNotifierProvider.value(value: provider)],
          child: ForgotPassword(provider),
        );
      case '/register':
        return MultiProvider(
          providers: [ChangeNotifierProvider.value(value: provider)],
          child: Register(provider),
        );
      case '/login':
        return MultiProvider(
          providers: [
            ChangeNotifierProvider.value(
              value: provider,
            )
          ],
          child: LoginScreen(),
        );
      case '/dashboard':
        return MultiProvider(
          providers: [
            ChangeNotifierProvider.value(
              value: provider,
            )
          ],
          child: Dashboard(checkData(provider.user), provider),
        );
      case '/profile':
        return MultiProvider(
          providers: [
            ChangeNotifierProvider.value(
              value: provider,
            )
          ],
          child: Profile(provider.user.id, provider),
        );
      case '/addCar':
        return MultiProvider(
          providers: [
            ChangeNotifierProvider.value(
              value: provider,
            )
          ],
          child: AddCar(),
        );
      case '/splashScreen':
        return MultiProvider(
          providers: [ChangeNotifierProvider.value(value: provider)],
          child: SplashScreen(),
        );
      case '/reqService':
        return MultiProvider(
          providers: [
            ChangeNotifierProvider.value(
              value: provider,
            )
          ],
          child: ReqService(),
        );
      case '/help':
        return MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: provider),
          ],
          child: Help(provider.user.id),
        );
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black,
        statusBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Spear Motors Care',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: fut());
  }
}
