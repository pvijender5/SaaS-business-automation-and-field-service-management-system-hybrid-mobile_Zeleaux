// lib/app/modules/dashboard/subview/botton_navbar.dart
//
// This file defines a custom bottom navigation bar widget (`BottomNavBarV2`)
// with a floating action button in the center. It uses a custom painter for
// the navigation bar background and manages tab selection state. Navigation
// is handled using GetX.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/routes.dart';

/// BottomNavBarV2 is a custom bottom navigation bar with a center FAB.
/// It manages the selected tab and handles navigation.
class BottomNavBarV2 extends StatefulWidget {
  @override
  _BottomNavBarV2State createState() => _BottomNavBarV2State();
}

class _BottomNavBarV2State extends State<BottomNavBarV2> {
  // Index of the currently selected tab
  int currentIndex = 0;

  /// Updates the selected tab index and refreshes the UI.
  void setBottomBarIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white.withAlpha(55),
      body: Stack(
        children: [
          // Positioned bottom navigation bar
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: size.width,
              height: 80,
              child: Stack(
                children: [
                  // Custom painted background for the navigation bar
                  CustomPaint(
                    size: Size(size.width, 80),
                    painter: BNBCustomPainter(),
                  ),
                  // Center floating action button
                  Center(
                    heightFactor: 0.6,
                    child: FloatingActionButton(
                      backgroundColor: Colors.orange,
                      child: Icon(Icons.shopping_basket),
                      elevation: 0.1,
                      onPressed: () {
                        // Handle FAB press here
                      },
                    ),
                  ),
                  // Row of navigation icons
                  Container(
                    width: size.width,
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Home icon
                        IconButton(
                          icon: Icon(
                            Icons.home,
                            color: currentIndex == 0
                                ? Colors.greenAccent
                                : Colors.grey.shade400,
                          ),
                          onPressed: () {
                            // Navigate to landing page
                            Get.toNamed(Routes.LANDING_PAGE);
                            setBottomBarIndex(0);
                          },
                          splashColor: Colors.white,
                        ),
                        // Menu icon
                        IconButton(
                          icon: Icon(
                            Icons.restaurant_menu,
                            color: currentIndex == 1
                                ? Colors.orange
                                : Colors.grey.shade400,
                          ),
                          onPressed: () {
                            setBottomBarIndex(1);
                          },
                        ),
                        // Spacer for FAB
                        Container(
                          width: size.width * 0.20,
                        ),
                        // Bookmark icon
                        IconButton(
                          icon: Icon(
                            Icons.bookmark,
                            color: currentIndex == 2
                                ? Colors.orange
                                : Colors.grey.shade400,
                          ),
                          onPressed: () {
                            setBottomBarIndex(2);
                          },
                        ),
                        // Notifications icon
                        IconButton(
                          icon: Icon(
                            Icons.notifications,
                            color: currentIndex == 3
                                ? Colors.orange
                                : Colors.grey.shade400,
                          ),
                          onPressed: () {
                            setBottomBarIndex(3);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// BNBCustomPainter draws the custom background for the bottom navigation bar.
class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path();
    // Draw the custom shape for the navigation bar with a center notch for the FAB
    path.moveTo(0, 20);
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(
      Offset(size.width * 0.60, 20),
      radius: Radius.circular(20.0),
      clockwise: false,
    );
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 20);

    // Draw shadow and path
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // No need to repaint as the shape does not change
    return false;
  }
}