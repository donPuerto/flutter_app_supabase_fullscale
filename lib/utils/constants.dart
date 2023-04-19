import 'package:flutter/material.dart';

// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const appName = 'Flutter Supabase App';
const footerText = 'Developed by Don Puerto';
const footerTextTwo = 'Inspired by myself';
const supportEmail = 'don.puerto.1003@gmail.com';

//print("Supabase Constant");
// Supabase

final navigatorKey = GlobalKey<NavigatorState>();

const supabaseImageBucket = 'public-images';

// bool isAuthenticated() {
//   return supabase.auth.currentUser != null;
// }

// bool isUnauthenticated() {
//   return isAuthenticated() == false;
// }

// String getCurrentUserId() {
//   return isAuthenticated() ? supabase.auth.currentUser!.id : '';
// }

Color? appBackgroundColor = Colors.grey.shade50;
Color? appForegroundColor = Colors.indigo;

// String getCurrentUserPhone() {
//   return isAuthenticated()
//       ? formatedPhoneNumber(supabase.auth.currentUser!.phone)
//       : '';
// }

// **Show a success snackbar with the default background color and duration
// context.showSnackBar(message: "Success!");

// **Show an info snackbar with a custom background color and duration
// context.showSnackBar(
//   message: "Information",
//   backgroundColor: Colors.yellow,
//   snackBarType: SnackBarType.info,
//   duration: const Duration(seconds: 4),
// );

// **Show an error snackbar with the default background color and a custom duration
// context.showSnackBar(
//   message: "Error!",
//   snackBarType: SnackBarType.error,
//   duration: const Duration(seconds: 3),
// );

// **Show a snackbar with OK and Cancel actions
// context.showSnackBar(
//   message: "Do you want to proceed?",
//   onOk: () {
//      OK button pressed
//   },
//   onCancel: () {
//      Cancel button pressed
//   },
// );

// enum SnackBarType { success, info, error }

// extension ShowSnackBar on BuildContext {
//   void showSnackBar({
//     required String message,
//     Color? backgroundColor,
//     SnackBarType? snackBarType,
//     Duration duration = const Duration(seconds: 3),
//     void Function()? onOk,
//     void Function()? onCancel,
//   }) {
//     Color? snackBarColor;
//     if (snackBarType != null) {
//       switch (snackBarType) {
//         case SnackBarType.success:
//           snackBarColor = Colors.green;
//           break;
//         case SnackBarType.info:
//           snackBarColor = Colors.blue;
//           break;
//         case SnackBarType.error:
//           snackBarColor = Colors.red;
//           break;
//       }
//     }

//     ScaffoldMessenger.of(this).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: backgroundColor ?? snackBarColor ?? Colors.white,
//         duration: duration,
//         action: onOk != null || onCancel != null
//             ? SnackBarAction(
//                 label: "OK",
//                 onPressed: onOk ?? () {},
//               )
//             : null,
//       ),
//     );
//   }
// }
