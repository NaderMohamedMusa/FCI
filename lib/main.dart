import 'package:facultyfci/screens/home_screen.dart';
import 'package:facultyfci/screens/login_screen.dart';
import 'package:facultyfci/provider/user_provider.dart';
import 'package:facultyfci/screens/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



void main() {
  //Returns an instance of the WidgetsBinding, creating and initializing it if necessary. If one is created, it will be a WidgetsFlutterBinding.
  // If one was previously initialized, then it will at least implement WidgetsBinding.
  //You only need to call this method if you need the binding to be initialized before calling runApp.
  WidgetsFlutterBinding.ensureInitialized();

  //A provider that merges multiple providers into a single linear widget tree.
  // It is used to improve readability and reduce boilerplate code of having to nest multiple layers of providers.
  runApp(MultiProvider(providers: [
    //is the widget that provides an instance of a ChangeNotifier to its descendants.
    // It comes from the provider package.
    // Simply wrap any widget with ChangeNotifierProvider widget(As everything is a widget in flutter!) whose descendants would need access to ChangeNotifierProvider.
    ChangeNotifierProvider.value(value: UserProvider.initialize()),
    ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Colors.green
        ),
        home: ScreensController(),
      )
  ),
  );
}

//here status user if ..... if..... if....
class ScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);      //define variable user to inherits state user,
    switch(user.status){
      case Status.Uninitialized:
        return Loading();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return LoginPage();
      case Status.Authenticated:
        return HomeScreen();
      default:
        return LoginPage();
    }
  }
}