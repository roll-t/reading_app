import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/features/materials/book/presentation/layout_book_detail/layout_book_detail_controller.dart';

class BuildHeaderTapBar extends StatelessWidget {
  const BuildHeaderTapBar({
    super.key,
    required this.controller,
  });

  final LayoutBookDetailController controller;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true, // This makes the TabBar sticky
      delegate: _SliverAppBarDelegate(
        child: TabBar(
          controller: controller.tabController,
          isScrollable: false,
          dividerColor: AppColors.gray3,
          labelColor: AppColors.accentColor,
          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(
              width: 2,
              color: AppColors.accentColor,
            ),
          ),
          tabs: const [
            Tab(text: AppContents.info),
            Tab(text: AppContents.chapter),
          ],
          onTap: (value) {},
        ),
      ),
    );
  }
}


class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.child,
  });

  final TabBar child;

  @override
  double get minExtent => child.preferredSize.height;

  @override
  double get maxExtent => child.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: AppColors.black,
      child: child,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
