import 'package:ecommerce_app/src/features/account/account_screen.dart';
import 'package:ecommerce_app/src/features/orders_list/orders_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/products_list/products_list_screen.dart';
import '../features/shopping_cart/shopping_cart_screen.dart';
import '../features/sign_in/email_password_sign_in_screen.dart';
import '../features/sign_in/email_password_sign_in_state.dart';

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
        GoRoute(
          path: 'orders',
          pageBuilder: (context, state) => MaterialPage(
            fullscreenDialog: true,
            key: state.pageKey,
            child: const OrdersListScreen(),
          ),
        ),
        GoRoute(
          path: 'account',
          pageBuilder: (context, state) => MaterialPage(
            fullscreenDialog: true,
            key: state.pageKey,
            child: const AccountScreen(),
          ),
        ),
        GoRoute(
          path: 'signIn',
          pageBuilder: (context, state) => MaterialPage(
            fullscreenDialog: true,
            key: state.pageKey,
            child: const EmailPasswordSignInScreen(
              formType: EmailPasswordSignInFormType.signIn,
            ),
          ),
        )
      ],
    ),
  ],
);
