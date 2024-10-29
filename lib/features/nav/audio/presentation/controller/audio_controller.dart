
import 'package:get/get.dart';
import 'package:reading_app/features/nav/book_case/model/book_case_model.dart';

class AudioController extends GetxController {

  var currentIndex = 0.obs;
  
  List<String> listIntroduceSlide =[
    'https://i.ytimg.com/vi/gSgWNFDwjeQ/maxresdefault.jpg?sqp=-oaymwEmCIAKENAF8quKqQMa8AEB-AH-CYAC0AWKAgwIABABGEYgTihyMA8=&rs=AOn4CLCwL2t-IC8u8tUP7JSqf4MYg5nffg',
    'https://th.bing.com/th/id/OIP.Pn-rT-CMIr_8FJQWMhdy3QAAAA?rs=1&pid=ImgDetMain',
    'https://th.bing.com/th/id/OIP.aViJ9we3jKw3KpfRG8cTIwHaJ4?w=600&h=800&rs=1&pid=ImgDetMain',
    'https://img.wtr-lab.com/cdn/series/r_GOQAyt66H10v52r2L4CQ.webp',
    'https://th.bing.com/th/id/OIP.O0NEf9kiR_siLth3Zep8YQHaJ3?w=640&h=853&rs=1&pid=ImgDetMain'
  ];

  List<BookCaseModel> listData = [
  BookCaseModel.fromJson({
    "bid": "1",
    "title": "Thần cấp đại ma đầu",
    "imageUrl": "https://img.faloo.com/Novel/498x705/0/336/000336647.jpg",
  }),
];

}
