import 'package:ecommerce_app/src/features/account/account_screen.dart';
import 'package:ecommerce_app/src/features/checkout/checkout_screen.dart';
import 'package:ecommerce_app/src/features/leave_review_page/leave_review_screen.dart';
import 'package:ecommerce_app/src/features/not_found/not_found_screen.dart';
import 'package:ecommerce_app/src/features/orders_list/orders_list_screen.dart';
import 'package:ecommerce_app/src/features/product_page/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/products_list/products_list_screen.dart';
import '../features/shopping_cart/shopping_cart_screen.dart';
import '../features/sign_in/email_password_sign_in_screen.dart';
import '../features/sign_in/email_password_sign_in_state.dart';

enum AppRoute {
  home,
  product,
  leaveReview,
  cart,
  checkout,
  orders,
  account,
  signIn,
}

final goRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      name: AppRoute.home.name,
      builder: (context, state) => const ProductsListScreen(),
      routes: [
        GoRoute(
            path: 'product/:id',
            name: AppRoute.product.name,
            builder: (context, state) {
              final productId = state.params['id']!;
              return ProductScreen(productId: productId);
            },
            routes: [
              //sub routes for product detail pages
              GoRoute(
                path: 'review',
                name: AppRoute.leaveReview.name,
                builder: (context, state) {
                  final productId = state.params['id']!;
                  return LeaveReviewScreen(productId: productId);
                },
              )
            ]),
        GoRoute(
            path: 'cart',
            name: AppRoute.cart.name,
            // builder: (context, state) => const ShoppingCartScreen(),
            ///for full screen dialog transition from bottom
            pageBuilder: (context, state) =>
                MaterialPage(fullscreenDialog: true, key: state.pageKey, child: const ShoppingCartScreen()),
            routes: [
              GoRoute(
                path: 'checkout',
                name: AppRoute.checkout.name,
                builder: (context, state) {
                  return const CheckoutScreen();
                },
              )
            ]),
        GoRoute(
          path: 'orders',
          name: AppRoute.orders.name,
          pageBuilder: (context, state) => MaterialPage(
            fullscreenDialog: true,
            key: state.pageKey,
            child: const OrdersListScreen(),
          ),
        ),
        GoRoute(
          path: 'account',
          name: AppRoute.account.name,
          pageBuilder: (context, state) => MaterialPage(
            fullscreenDialog: true,
            key: state.pageKey,
            child: const AccountScreen(),
          ),
        ),
        GoRoute(
          path: 'signIn',
          name: AppRoute.signIn.name,
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
  errorBuilder: (context, state) => const NotFoundScreen(),
);
