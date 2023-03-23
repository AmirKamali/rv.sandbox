import 'package:flutter/cupertino.dart';

void pushTo(BuildContext context, String to, [args]) {
  Navigator.of(context).pushReplacementNamed(to);
}
