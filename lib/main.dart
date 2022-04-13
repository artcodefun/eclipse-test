import 'package:flutter/material.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:provider/provider.dart';
import 'package:testapp/helpers/AppModule.dart';
import 'package:testapp/helpers/NavigationInfo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Injector injector = await AppModule().initialise(Injector());
  runApp(Provider.value(value: injector, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eclipse Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: NavigationInfo.makeRoutes(),
      initialRoute: NavigationInfo.home,
    );
  }
}
