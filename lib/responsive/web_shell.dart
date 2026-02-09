import 'package:flutter/material.dart';


class WebShell extends StatelessWidget {
  final Widget child;

  const WebShell({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth =
            constraints.maxWidth > 600 ? 600.0 : constraints.maxWidth;
        return Scaffold(
          body: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 0, 54, 134),
                      Color.fromARGB(255, 6, 122, 238),
                      Color.fromARGB(255, 11, 90, 208),
                    ],
                  ),
                ),
              ),
              Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: maxWidth,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: constraints.maxWidth > 600
                          ? [
                              BoxShadow(
                                blurRadius: 20,
                                spreadRadius: 2,
                                offset: const Offset(0, 8),
                                color: Colors.black12,
                              )
                            ]
                          : null,
                    ),
                    child: SafeArea(child: child),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

