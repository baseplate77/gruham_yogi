import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color selectedColor = Color(0xFF393938);
    const iconMargin = EdgeInsets.zero;
    final double tabBarHeight = 80.h;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            offset: Offset(0, -2),
            color: Colors.black12,
          ),
        ],
      ),
      child: TabBar(
        // isScrollable: true,
        indicator: const MD2Indicator(
          indicatorHeight: 2,
          indicatorColor: selectedColor,
          indicatorSize: MD2IndicatorSize.normal,
        ),
        labelColor: selectedColor,

        unselectedLabelColor: Colors.grey,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: const EdgeInsets.only(left: 16, right: 16),
        labelPadding: const EdgeInsets.all(0),
        labelStyle: Theme.of(context).textTheme.caption,
        indicatorColor: Colors.blue,
        tabs: [
          Tab(
            height: tabBarHeight,
            iconMargin: iconMargin,
            text: "Home",
            icon: Icon(
              Iconsax.home,
              size: 28.r,
            ),
          ),
          Tab(
            height: tabBarHeight,
            iconMargin: iconMargin,
            text: "Challenges",
            icon: Icon(
              Iconsax.medal_star,
              size: 32.r,
            ),
          ),
          Tab(
            height: tabBarHeight,
            iconMargin: iconMargin,
            text: "Relax",
            icon: Icon(
              Iconsax.sun_fog,
              size: 32.r,
            ),
          ),
          Tab(
            height: tabBarHeight,
            iconMargin: iconMargin,
            text: "Profile",
            icon: Icon(
              Iconsax.user,
              size: 32.r,
            ),
          ),
        ],
      ),
    );

    // OLD APP BAR
    // return BottomNavigationBar(
    //   currentIndex: 0,
    //   items: [
    //     BottomNavigationBarItem(
    //         icon: Icon(
    //           Iconsax.home,
    //           size: 32.r,
    //         ),
    //         label: "Home"),
    //     BottomNavigationBarItem(
    //         icon: Icon(
    //           Iconsax.medal_star,
    //           size: 32.r,
    //         ),
    //         label: "Challenge"),
    //     BottomNavigationBarItem(
    //         icon: Icon(
    //           Iconsax.profile_circle,
    //           size: 32.r,
    //         ),
    //         label: "Profile"),
    //   ],
    // );
  }
}

enum MD2IndicatorSize {
  tiny,
  normal,
  full,
}

class MD2Indicator extends Decoration {
  final double indicatorHeight;
  final Color indicatorColor;
  final MD2IndicatorSize indicatorSize;

  const MD2Indicator({
    required this.indicatorHeight,
    required this.indicatorColor,
    required this.indicatorSize,
  });

  @override
  _MD2Painter createBoxPainter([VoidCallback? onChanged]) {
    return _MD2Painter(this, onChanged);
  }
}

class _MD2Painter extends BoxPainter {
  final MD2Indicator decoration;

  _MD2Painter(this.decoration, VoidCallback? onChanged) : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);

    Rect rect;
    if (decoration.indicatorSize == MD2IndicatorSize.full) {
      rect = Offset(
            offset.dx,
            configuration.size!.height - decoration.indicatorHeight,
          ) &
          Size(configuration.size!.width, decoration.indicatorHeight);
    } else if (decoration.indicatorSize == MD2IndicatorSize.tiny) {
      rect = Offset(
            offset.dx + configuration.size!.width / 2 - 8,
            configuration.size!.height - decoration.indicatorHeight,
          ) &
          Size(16, decoration.indicatorHeight);
    } else {
      rect = Offset(offset.dx + 6, 2) &
          Size(configuration.size!.width - 12, decoration.indicatorHeight);
    }

    final Paint paint = Paint()
      ..color = decoration.indicatorColor
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
      RRect.fromRectAndCorners(rect,
          topRight: Radius.circular(8),
          topLeft: Radius.circular(8),
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8)),
      paint,
    );
  }
}
