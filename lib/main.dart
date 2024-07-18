import 'package:client_view_app/screen/client_view_screen.dart';
import 'package:client_view_app/screen/controller/client_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() {

  runApp(const MyApp());
}
final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ClientController>(
            create: (_) => ClientController()),
      ],
      child: ScreenUtilInit(
          // designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, child) {
            return  const GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Client View Screen',
              home: ClientViewScreen(),
            );
          }),
    );
  }
}
