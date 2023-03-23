import 'package:flutter/material.dart';
import 'package:roadvault_interview_sandbox/utils/nav.dart';

final AppBar appBar = AppBar();

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  final String? forward;
  final String? back;
  final String title;
  const NavBar(
      {Key? key, this.forward, this.back, this.title: 'Interview Sandbox'})
      : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);

  bool hasForward() {
    return forward != null;
  }

  bool hasBack() {
    return back != null;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(title),
        centerTitle: true,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (hasBack()) pushTo(context, back!);
            }),
        actions: [
          IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () {
                if (hasForward()) pushTo(context, forward!);
              })
        ]);
  }
}
