
import 'package:reading_app/features/expanded/book/data/remote/api/book_remote.dart';
import 'package:reading_app/features/expanded/book/domain/book_repository.dart';

class BookRepositoryImpl extends BookRepository {
  final BookRemote _remote;

  BookRepositoryImpl(this._remote);
}
