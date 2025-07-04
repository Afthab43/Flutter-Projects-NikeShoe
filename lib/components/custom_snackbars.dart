import 'package:flutter/material.dart';

class CustomSnackbars {
  CustomSnackbars._();
  static successSnackbar() => SnackBar(
    backgroundColor: Colors.green[400],
    content: const Text('Successfully added to your cart!'),
    action: SnackBarAction(textColor: Colors.white, label: 'Got it', onPressed: (){}),
    );

  static failedSnackbar() => SnackBar(
    backgroundColor: Colors.red[400],
    content: const Text('Item already added to your cart!'),
    action: SnackBarAction(textColor: Colors.white, label: 'Got it', onPressed: (){}),
    );
}