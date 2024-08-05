
import 'package:get/get.dart';
import 'package:reading_app/core/data/models/book_model.dart';

class HomeController extends GetxController {
  var currentIndex = 0.obs;

  var currentIndexCategory = 0.obs;

  changeIndexCategory(){
    
  }

  List<String> listIntroduceSlide =[
    'https://th.bing.com/th?id=OIF.0%2fWnli1m6RI9xpaB9Aq3Zw&rs=1&pid=ImgDetMain',
    'https://th.bing.com/th/id/R.37302ba5edd92ca748129e6017fbe582?rik=tLKP4Onjp9Bc4g&riu=http%3a%2f%2fimg.faloo.com%2fNovel%2f498x705%2f0%2f336%2f000336647.jpg&ehk=%2bRaxtlEw1F7kLAs84IbXhj8kSlw9QjnVXpde7oUbZU8%3d&risl=&pid=ImgRaw&r=0',
    'https://th.bing.com/th/id/OIP.4GdY67ckiUXLyYAKrgBn_gHaKf?w=498&h=705&rs=1&pid=ImgDetMain',
    'https://th.bing.com/th/id/OIP.Ob8msuUfI_pd-MDL0fF8UgHaKf?rs=1&pid=ImgDetMain',
    'https://th.bing.com/th/id/OIP.Ob8msuUfI_pd-MDL0fF8UgHaKf?rs=1&pid=ImgDetMain'
  ];


List<BookModel> listValueCardContinue = [
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



List<BookModel> listValueCardBTVRecoment= [
  BookModel.fromJson({
    "bid": "1",
    "title": "Thần cấp đại ma đầu",
    "imageUrl": "https://th.bing.com/th/id/R.37302ba5edd92ca748129e6017fbe582?rik=tLKP4Onjp9Bc4g&riu=http%3a%2f%2fimg.faloo.com%2fNovel%2f498x705%2f0%2f336%2f000336647.jpg&ehk=%2bRaxtlEw1F7kLAs84IbXhj8kSlw9QjnVXpde7oUbZU8%3d&risl=&pid=ImgRaw&r=0",
  }),
  BookModel.fromJson({
    "bid": "1",
    "title": "Thần cấp đại ma đầu",
    "chapter": "chapter 6",
    "imageUrl": "https://th.bing.com/th/id/R.37302ba5edd92ca748129e6017fbe582?rik=tLKP4Onjp9Bc4g&riu=http%3a%2f%2fimg.faloo.com%2fNovel%2f498x705%2f0%2f336%2f000336647.jpg&ehk=%2bRaxtlEw1F7kLAs84IbXhj8kSlw9QjnVXpde7oUbZU8%3d&risl=&pid=ImgRaw&r=0",
  }),
  BookModel.fromJson({
    "bid": "1",
    "title": "Thần cấp đại ma đầu",
    "imageUrl": "https://th.bing.com/th/id/R.37302ba5edd92ca748129e6017fbe582?rik=tLKP4Onjp9Bc4g&riu=http%3a%2f%2fimg.faloo.com%2fNovel%2f498x705%2f0%2f336%2f000336647.jpg&ehk=%2bRaxtlEw1F7kLAs84IbXhj8kSlw9QjnVXpde7oUbZU8%3d&risl=&pid=ImgRaw&r=0",
  }),
  BookModel.fromJson({
    "bid": "1",
    "title": "Thần cấp đại ma đầu",
    "imageUrl": "https://th.bing.com/th/id/R.37302ba5edd92ca748129e6017fbe582?rik=tLKP4Onjp9Bc4g&riu=http%3a%2f%2fimg.faloo.com%2fNovel%2f498x705%2f0%2f336%2f000336647.jpg&ehk=%2bRaxtlEw1F7kLAs84IbXhj8kSlw9QjnVXpde7oUbZU8%3d&risl=&pid=ImgRaw&r=0",
  }),
  BookModel.fromJson({
    "bid": "1",
    "title": "Thần cấp đại ma đầu",
    "imageUrl": "https://th.bing.com/th/id/R.37302ba5edd92ca748129e6017fbe582?rik=tLKP4Onjp9Bc4g&riu=http%3a%2f%2fimg.faloo.com%2fNovel%2f498x705%2f0%2f336%2f000336647.jpg&ehk=%2bRaxtlEw1F7kLAs84IbXhj8kSlw9QjnVXpde7oUbZU8%3d&risl=&pid=ImgRaw&r=0",
  }),
  BookModel.fromJson({
    "bid": "1",
    "title": "Thần cấp đại ma đầu",
    "imageUrl": "https://th.bing.com/th/id/R.37302ba5edd92ca748129e6017fbe582?rik=tLKP4Onjp9Bc4g&riu=http%3a%2f%2fimg.faloo.com%2fNovel%2f498x705%2f0%2f336%2f000336647.jpg&ehk=%2bRaxtlEw1F7kLAs84IbXhj8kSlw9QjnVXpde7oUbZU8%3d&risl=&pid=ImgRaw&r=0",
  }),
];

List<BookModel> listValueCardByCategory= [
  BookModel.fromJson({
    "bid": "1",
    "title": "Bạo quân phản xuyên việt đại liên minh",
    "imageUrl": "https://th.bing.com/th/id/OIP.Ob8msuUfI_pd-MDL0fF8UgHaKf?rs=1&pid=ImgDetMain",
    "description": "Đang cập nhật"
  }),
  BookModel.fromJson({
    "bid": "1",
    "title": "Bạo quân phản xuyên việt đại liên minh",
    "imageUrl": "https://th.bing.com/th/id/OIP.Ob8msuUfI_pd-MDL0fF8UgHaKf?rs=1&pid=ImgDetMain",
    "description": "Thông tin mô tả của truyện được viết tại đây"
  }),
  BookModel.fromJson({
    "bid": "1",
    "title": "Bạo quân phản xuyên việt đại liên minh",
    "imageUrl": "https://th.bing.com/th/id/OIP.Ob8msuUfI_pd-MDL0fF8UgHaKf?rs=1&pid=ImgDetMain",
    "description": "Đang cập nhật"
  }),
  BookModel.fromJson({
    "bid": "1",
    "title": "Bạo quân phản xuyên việt đại liên minh",
    "imageUrl": "https://th.bing.com/th/id/OIP.Ob8msuUfI_pd-MDL0fF8UgHaKf?rs=1&pid=ImgDetMain",
    "description": "Đang cập nhật"
  }),
  BookModel.fromJson({
    "bid": "1",
    "title": "Bạo quân phản xuyên việt đại liên minh",
    "imageUrl": "https://th.bing.com/th/id/OIP.Ob8msuUfI_pd-MDL0fF8UgHaKf?rs=1&pid=ImgDetMain",
    "description": "Thông tin mô tả của truyện được viết tại đây"
  }),
];

List<BookModel> listCardFullInfo= [
  BookModel.fromJson({
    "bid": "1",
    "title": "Khánh Dư niên",
    "imageUrl": "https://th.bing.com/th/id/OIP.4GdY67ckiUXLyYAKrgBn_gHaKf?w=498&h=705&rs=1&pid=ImgDetMain",
    "description":  "Nội dung mô tả được viết vào đây Nội dung mô tả được viết vào đây Nội dung mô tả được viết vào đây Nội dung mô tả được viết vào đây",
  }),
  BookModel.fromJson({
    "bid": "1",
    "title": "Khánh Dư niên",
    "imageUrl": "https://th.bing.com/th/id/OIP.4GdY67ckiUXLyYAKrgBn_gHaKf?w=498&h=705&rs=1&pid=ImgDetMain",
    "description":  "Nội dung mô tả được viết vào đây Nội dung mô tả được viết vào đây Nội dung mô tả được viết vào đây Nội dung mô tả được viết vào đây",
  }),
  BookModel.fromJson({
    "bid": "1",
    "title": "Khánh Dư niên",
    "imageUrl": "https://th.bing.com/th/id/OIP.4GdY67ckiUXLyYAKrgBn_gHaKf?w=498&h=705&rs=1&pid=ImgDetMain",
    "description":  "Nội dung mô tả được viết vào đây Nội dung mô tả được viết vào đây Nội dung mô tả được viết vào đây Nội dung mô tả được viết vào đây",
  }),
];

List<String> listCategory=[
  "Cổ đại","Ma pháp", "Xuyên không", "Nhệ nhàn", "Quân sự", "Trinh thám"
];



}