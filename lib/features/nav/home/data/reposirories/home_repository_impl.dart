import 'package:reading_app/core/configs/enum.dart';
import 'package:reading_app/core/service/api/locals/novel_service.dart';
import 'package:reading_app/core/service/api/remotes/comic_service.dart';
import 'package:reading_app/core/service/data/dto/response/novel_response.dart';
import 'package:reading_app/core/service/data/model/list_comic_model.dart';
import 'package:reading_app/core/service/data/model/result.dart';
import 'package:reading_app/core/service/data/model/user_model.dart';
import 'package:reading_app/core/service/domain/usecase/users/get_user_usecase.dart';
import 'package:reading_app/features/nav/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  
  final NovelService _novelService;

  final ComicApi _comicApi;

  final GetUserUsecase _getuserUseCase;

  HomeRepositoryImpl(this._novelService, this._comicApi, this._getuserUseCase);

  @override
  Future<List<NovelResponse>> fetchListNovel() async {
    Result result = await _novelService.fetchListNovel();
    if (result.status == Status.success) {
      return result.data ?? [];
    } else {
      throw Exception('Failed to load novels');
    }
  }

  @override
  Future<List<NovelResponse>> fetchListSlider() async {
    Result result =
        await _novelService.fetchListNovelByStatus(statusName: "SLIDER");
    if (result.status == Status.success) {
      return result.data ?? [];
    } else {
      throw Exception('Failed to load slider');
    }
  }

  @override
  Future<ListComicModel?> fetchUpcomingComics() async {
    Result result =await _comicApi.fetchListBySlug(page: 1, slug: 'sap-ra-mat');
    if (result.status == Status.success) {
      final apiResponse = result.data;
      if (apiResponse != null) {
        apiResponse.titlePage = "Cập nhật mới nhất";
        return apiResponse;
      }
    }
    return null;
    // throw Exception('Failed to load comics');
  }

  @override
  Future<UserModel?> fetchUser() async {
    return await _getuserUseCase();
  }
}
