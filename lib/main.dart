import 'package:contacts/database/database_app.dart';
import 'package:contacts/provider/contact_provider.dart';
import 'package:contacts/provider/lang_getx/lang_getx_controller.dart';
import 'package:contacts/provider/lang_getx/shaerd_pref/shaerd_pref_controller.dart';
import 'package:contacts/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseApp().initDatabase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ContactProvider(),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
