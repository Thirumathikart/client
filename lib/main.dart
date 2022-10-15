import 'package:google_fonts/google_fonts.dart';
import 'package:thirumathikart_app/config/navigations.dart';
import 'package:thirumathikart_app/constants/navigation_routes.dart';
import 'package:thirumathikart_app/services/api_services.dart';
import 'package:thirumathikart_app/services/storage_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  runApp(const Thirumathikart());
}

Future<void> initServices() async {
  await Get.putAsync(() => StorageServices().initStorage());
  await Get.putAsync(() => ApiServices().initApi());
}

class Thirumathikart extends StatelessWidget {
  const Thirumathikart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => GetMaterialApp(
        themeMode: ThemeMode.light,
        theme: ThemeData(
            textTheme:
                GoogleFonts.brawlerTextTheme(Theme.of(context).textTheme)),
        debugShowCheckedModeBanner: false,
        initialRoute: NavigationRoutes.loginRoute,
        getPages: NavigationPages.getPages(),
      );
}
