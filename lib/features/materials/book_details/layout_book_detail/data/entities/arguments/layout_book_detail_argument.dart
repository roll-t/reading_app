import 'package:reading_app/core/service/data/dto/response/reading_book_case_response.dart';
import 'package:reading_app/core/service/data/model/reading_book_case_model.dart';

class LayoutBookDetailArgument {
  final ReadingBookCaseResponse? readContinue;
  final ReadingComicBookCaseModel? readingComicBookCase;

  LayoutBookDetailArgument({this.readContinue, this.readingComicBookCase});

  factory LayoutBookDetailArgument.fromMap(Map<String, dynamic> args) {
    return LayoutBookDetailArgument(
      readContinue: args["readContinue"],
      readingComicBookCase: args["readingComicBookCase"],
    );
  }
}
