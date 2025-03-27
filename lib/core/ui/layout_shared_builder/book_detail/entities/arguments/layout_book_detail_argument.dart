import 'package:reading_app/core/services/entities/dto/response/reading_book_case_response.dart';
import 'package:reading_app/core/services/entities/models/reading_book_case_model.dart';

class LayoutBookDetailArgument {
  ReadingBookCaseResponse? readContinue;
  ReadingComicBookCaseModel? readingComicBookCase;

  LayoutBookDetailArgument({
    this.readContinue,
    this.readingComicBookCase,
  });

  factory LayoutBookDetailArgument.fromMap(Map<String, dynamic> args) {
    return LayoutBookDetailArgument(
      readContinue: args["readContinue"],
      readingComicBookCase: args["readingComicBookCase"],
    );
  }
}
