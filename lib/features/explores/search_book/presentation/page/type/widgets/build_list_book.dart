import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/dimens/space_dimens.dart';
import 'package:reading_app/core/data/models/book_model.dart';
import 'package:reading_app/core/ui/widgets/card/card_explore.dart';

class BuildListBook extends StatelessWidget {
  final List<BookModel> listBookData;

  const BuildListBook({
    super.key,
    required this.listBookData,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
          horizontal: SpaceDimens.space20, vertical: SpaceDimens.space15),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Số cột trong lưới
          crossAxisSpacing: 10, // Khoảng cách giữa các cột
          mainAxisSpacing: 10, // Khoảng cách giữa các hàng
          childAspectRatio:
              1.6 / 3, // Tỷ lệ giữa chiều rộng và chiều cao của mỗi phần tử
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            // Xây dựng phần tử của lưới
            return Container(
                alignment: Alignment.center,
                child: CardExplore(
                    widthCard: 110,
                    heightCard: 230,
                    bookModel: listBookData[index]));
          },
          childCount: listBookData.length, // Số lượng phần tử trong lưới
        ),
      ),
    );
  }
}
