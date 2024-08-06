
import 'package:get/get.dart';
import 'package:reading_app/core/data/models/book_model.dart';

class CommicController extends GetxController {

  var currentIndex = 0.obs;
  
  List<String> listIntroduceSlide =[
    'https://i.ytimg.com/vi/gSgWNFDwjeQ/maxresdefault.jpg?sqp=-oaymwEmCIAKENAF8quKqQMa8AEB-AH-CYAC0AWKAgwIABABGEYgTihyMA8=&rs=AOn4CLCwL2t-IC8u8tUP7JSqf4MYg5nffg',
    'https://th.bing.com/th/id/OIP.Pn-rT-CMIr_8FJQWMhdy3QAAAA?rs=1&pid=ImgDetMain',
    'https://th.bing.com/th/id/OIP.aViJ9we3jKw3KpfRG8cTIwHaJ4?w=600&h=800&rs=1&pid=ImgDetMain',
    'https://img.wtr-lab.com/cdn/series/r_GOQAyt66H10v52r2L4CQ.webp',
    'https://th.bing.com/th/id/OIP.O0NEf9kiR_siLth3Zep8YQHaJ3?w=640&h=853&rs=1&pid=ImgDetMain'
  ];

  List<BookModel> listData = [
  BookModel.fromJson({
    "bid": "1",
    "title": "Thần cấp đại ma đầu",
    "imageUrl": "https://img.faloo.com/Novel/498x705/0/336/000336647.jpg",
  }),
  BookModel.fromJson({
    "bid": "2",
    "title": "Thư viện huyền bí",
    "imageUrl": "https://img.faloo.com/Novel/498x705/0/357/000357913.jpg",
    "description":"Mô tả truyện tranh viết vào đây Mô tả truyện tranh viết vào đây Mô tả truyện tranh viết vào đây"
  }),
  BookModel.fromJson({
    "bid": "3",
    "title": "Ma đạo tổ sư",
    "imageUrl": "https://ngontinh.org/wp-content/uploads/2021/11/Len-Nham-Kieu-Hoa-Truyen-Ngan-Tinh-Yeu.jpg",
  }),
  BookModel.fromJson({
    "bid": "4",
    "title": "Tuyệt thế vô song",
    "imageUrl": "https://truyenaudio.org/upload/pro/Le-Tinh-Truyen-Ngan-Tinh-Yeu.jpg",
  }),
  BookModel.fromJson({
    "bid": "5",
    "title": "Vũ trụ siêu cấp",
    "imageUrl": "https://tiengtrungtoancauhc.vn/wp-content/uploads/2024/01/Truyen-tranh-Trung-Quoc-1-566x800.jpg",
  }),
  BookModel.fromJson({
    "bid": "6",
    "title": "Thần long chi địa",
    "imageUrl": "https://i.pinimg.com/originals/36/4c/dc/364cdcef24987a1be511d76497ec4555.jpg",
  }),
  BookModel.fromJson({
    "bid": "7",
    "title": "Ngạo thị thiên hạ",
    "imageUrl": "https://th.bing.com/th/id/OIP.YEROt88zBh0qodtCZIoKfgHaMu?w=1280&h=2200&rs=1&pid=ImgDetMain",
  }),
  BookModel.fromJson({
    "bid": "8",
    "title": "Huyễn tưởng chi lữ",
    "imageUrl": "https://th.bing.com/th/id/OIP.W8tb3IOT_OT9-YAJn1y_sAHaNV?w=690&h=1242&rs=1&pid=ImgDetMain",
  }),
  BookModel.fromJson({
    "bid": "8",
    "title": "Huyễn tưởng chi lữ",
    "imageUrl": "https://th.bing.com/th/id/OIP.rU0sYjJtSbfZcRayv2DwpAHaJ0?rs=1&pid=ImgDetMain",
  }),
];

}
