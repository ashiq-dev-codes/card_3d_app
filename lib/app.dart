import 'package:card_3d_app/feature/product/presentation/page/product_page.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Card 3D App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const ProductPage(),
    );
  }
}
