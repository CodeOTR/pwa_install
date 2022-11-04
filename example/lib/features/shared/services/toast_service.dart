import 'package:flutter/material.dart';
import 'package:pwa_install_example/app/router.dart';

/// Service for displaying toasts, snackbars, banners, or other
/// temporary info boxes
/// SimpleDialog can get you most of the way there

class ToastService {
  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
    ));
  }

  Future<bool> askConfirmation({
    required BuildContext context,
    required String title,
    String yes = 'Continue',
    String no = 'Cancel',
  }) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          actions: [
            TextButton(
              child: Text(no),
              onPressed: () {
                router.pop();
              },
            ),
            TextButton(
              child: Text(
                yes,
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                router.pop();
              },
            )
          ],
        );
      },
    ) ??
        false;
  }

  Future<bool> confirmLeave(
      BuildContext context, {
        String title = 'Exit the app?',
        String yes = 'Exit',
        String no = 'Stay',
      }) async {
    bool leave = false;
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(child: Text(title)),
          actions: [
            TextButton(
              child: Text(no),
              onPressed: () async {
                leave = false;
                router.pop();
              },
            ),
            TextButton(
              child: Text(
                yes,
                //style: TextStyle(color: Colors.red),
              ),
              onPressed: () async {
                leave = true;
                router.pop();
              },
            )
          ],
        );
      },
    );
    return leave;
  }

  /// Simple function to close the keyboard. Used before showing a snackbar
  void closeKeyboard(BuildContext context) {
    FocusScope.of(context)
        .requestFocus(FocusNode()); // Unfocus text fields on page change
  }

  bool isKeyBoardOpen(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom == 0;
  }

  void unfocusAll(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}
