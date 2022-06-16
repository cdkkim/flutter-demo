import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';

class SharedAxisPageRoute extends PageRouteBuilder {
  SharedAxisPageRoute({required Widget page, SharedAxisTransitionType? transitionType})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation primaryAnimation,
            Animation secondaryAnimation,
          ) => page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> primaryAnimation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            return SharedAxisTransition(
              animation: primaryAnimation,
              secondaryAnimation: secondaryAnimation,
              transitionType: transitionType ?? SharedAxisTransitionType.horizontal,
              child: child,
            );
          },
        );
}
