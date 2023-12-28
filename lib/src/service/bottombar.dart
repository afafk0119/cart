import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tgh_test/src/features/cart/cart_screen.dart';
import 'package:tgh_test/src/features/product/product_screen.dart';

class BottomBar extends StatefulWidget {
  int currentIndex;

  BottomBar({
    super.key,
    required this.currentIndex,
  });

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  bool? _isConnected;

  ValueNotifier<String> incrementvalue = ValueNotifier<String>("true");

  final List<Widget> _pages = [ProductScreen(), Cart()];
  late Timer _connectivityTimer;

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      widget.currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.currentIndex,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Carts',
          ),
        ],
      ),
      body: _pages[widget.currentIndex],
    );
  }
}
