import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tgh_test/src/features/cart/cart_model.dart';
import 'package:tgh_test/src/features/cart/cart_provider.dart';
import 'package:tgh_test/src/features/product/product_model.dart';
import 'package:tgh_test/src/features/product/productprovider.dart';
import 'package:tgh_test/src/service/bottombar.dart';

import 'src/features/product/product_screen.dart';

void main() async {
  runApp(const MyApp());
  await Hive.initFlutter();
  Hive.registerAdapter(ProductModelAdapter());
  Hive.registerAdapter(RatingModelAdapter());
  Hive.registerAdapter(AddItemModelAdapter());
  Hive.registerAdapter(RemoveItemModelAdapter());
  Hive.registerAdapter(DisplayItemModelAdapter());

  await Hive.openBox<ProductModel>("af1af");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Productprovider>(
            create: (context) => Productprovider()),
        ChangeNotifierProvider<Cartprovider>(
            create: (context) => Cartprovider()),
      ],
      child: ScreenUtilInit(
          designSize: const Size(390, 850),
          minTextAdapt: true,
          builder: (context, child) {
            return MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                // This is the theme of your application.
                //
                // TRY THIS: Try running your application with "flutter run". You'll see
                // the application has a blue toolbar. Then, without quitting the app,
                // try changing the seedColor in the colorScheme below to Colors.green
                // and then invoke "hot reload" (save your changes or press the "hot
                // reload" button in a Flutter-supported IDE, or press "r" if you used
                // the command line to start the app).
                //
                // Notice that the counter didn't reset back to zero; the application
                // state is not lost during the reload. To reset the state, use hot
                // restart instead.
                //
                // This works for code too, not just values: Most code changes can be
                // tested with just a hot reload.

                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              home: BottomBar(
                currentIndex: 0,
              ),
            );
          }),
    );
  }
}
