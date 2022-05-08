import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/products_list/products_list_screen.dart';
import '../features/shopping_cart/shopping_cart_screen.dart';

final goRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const ProductsListScreen(),
      routes: [
        GoRoute(
          path: 'cart',
          // builder: (context, state) => const ShoppingCartScreen(),
          ///for full screen dialog transition from bottom
          pageBuilder: (context, state) => MaterialPage(
            fullscreenDialog: true,
            key: state.pageKey,
            child: const ShoppingCartScreen(),
          ),
        ),
      ],
    ),
  ],
);
