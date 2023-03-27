import 'package:flutter/cupertino.dart';
import '../components/appRouter.dart';

void pushTo(BuildContext context, String to, {bool isForward = true}) {
  var page = AppRouter.pageMap[to]!;
  var moveDir = (isForward ? 1.0 : -1.0);
  var pb = PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(moveDir, 0.0);
        const end = Offset(0.0, 0.0);
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      });

  Navigator.of(context).pushAndRemoveUntil(pb, (route) => route.isFirst);
}
