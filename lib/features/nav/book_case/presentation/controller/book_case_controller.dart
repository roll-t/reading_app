
import 'package:get/get.dart';
import 'package:reading_app/core/database/data/model/book_model.dart';

class BookCaseController extends GetxController {

  RxString typeSelect= "Tất cả".obs;
  RxString filterType= "Mới nhất".obs;

  List<BookModel> listBookData = [
    BookModel.fromJson({
      "bid": "1",
      "title": "Thần cấp đại ma đầu",
      "imageUrl": "https://img.faloo.com/Novel/498x705/0/336/000336647.jpg",
    }),
    BookModel.fromJson({
      "bid": "2",
      "title": "Thư viện huyền bí",
      "imageUrl": "https://img.faloo.com/Novel/498x705/0/357/000357913.jpg",
    }),
    BookModel.fromJson({
      "bid": "3",
      "title": "Ma đạo tổ sư",
      "imageUrl":
          "https://ngontinh.org/wp-content/uploads/2021/11/Len-Nham-Kieu-Hoa-Truyen-Ngan-Tinh-Yeu.jpg",
    }),
    BookModel.fromJson({
      "bid": "4",
      "title": "Tuyệt thế vô song",
      "imageUrl":
          "https://truyenaudio.org/upload/pro/Le-Tinh-Truyen-Ngan-Tinh-Yeu.jpg",
    }),
    BookModel.fromJson({
      "bid": "5",
      "title": "Vũ trụ siêu cấp",
      "imageUrl":
          "https://tiengtrungtoancauhc.vn/wp-content/uploads/2024/01/Truyen-tranh-Trung-Quoc-1-566x800.jpg",
    }),
    BookModel.fromJson({
      "bid": "6",
      "title": "Thần long chi địa",
      "imageUrl":
          "https://i.pinimg.com/originals/36/4c/dc/364cdcef24987a1be511d76497ec4555.jpg",
    }),
    BookModel.fromJson({
      "bid": "7",
      "title": "Ngạo thị thiên hạ",
      "imageUrl":
          "https://th.bing.com/th/id/OIP.YEROt88zBh0qodtCZIoKfgHaMu?w=1280&h=2200&rs=1&pid=ImgDetMain",
    }),
    BookModel.fromJson({
      "bid": "8",
      "title": "Huyễn tưởng chi lữ",
      "imageUrl":
          "https://th.bing.com/th/id/OIP.W8tb3IOT_OT9-YAJn1y_sAHaNV?w=690&h=1242&rs=1&pid=ImgDetMain",
    }),
    BookModel.fromJson({
      "bid": "8",
      "title": "Huyễn tưởng chi lữ",
      "imageUrl":
          "https://th.bing.com/th/id/OIP.rU0sYjJtSbfZcRayv2DwpAHaJ0?rs=1&pid=ImgDetMain",
    }),
  ];
}
