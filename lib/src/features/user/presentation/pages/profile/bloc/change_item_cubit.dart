import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as path;
import 'package:b2c_platform/src/features/items/domain/usecases/change_item_usecase.dart';
import 'package:b2c_platform/src/features/user/domain/usecases/fetch_user_usecase.dart';
import 'package:b2c_platform/src/presentation/bloc/base_state.dart';

import '../../../../common/enums.dart';
import '../../../../domain/usecase/item/item_photo_usecase.dart';
import '../../add_item/bloc/photo_bloc/photo_bloc.dart';

class ChangeItemCubit extends Cubit<BaseState> {
  ChangeItemCubit(this.changeItemUseCase, this.itemPhotoUseCase)
      : super(const BaseState());

  final ChangeItemUseCase changeItemUseCase;
  final ItemPhotoUseCase itemPhotoUseCase;

  void changeItemStatus(String status) async {
    emit(const BaseState(status: CubitStatus.loading));

    final failureOrAuth =
        await changeItemUseCase.changeItemStatus(PathParams(status));

    emit(
      failureOrAuth.fold(
        (l) => BaseState(
          status: CubitStatus.error,
          message: l.message,
        ),
        (r) {
          return BaseState(
            status: CubitStatus.success,
            entity: r,
          );
        },
      ),
    );
  }

  void changeItemData(PathMapParams params, PhotoState state) async {
    emit(const BaseState(status: CubitStatus.loading));

    final itemRequest = await changeItemUseCase.changeItemData(params);


    if(state.removeAfter.isNotEmpty){
      for(final file in state.removeAfter){
        Match? match = RegExp(r'\?code=(\d+)').firstMatch(file.path);
        if(match != null){
          await itemPhotoUseCase.deleteItemPhoto(PathParams(match.group(1) ?? ''));
        }
      }
    }
    
    List<MultipartFile> attachments = [];
    for (var file in [state.mainPhoto, ...state.photos]) {
      if (file != null) {
        Match? match = RegExp(r'\?code=(\d+)').firstMatch(file.path);
        if (match == null) {
          String? mime = lookupMimeType(file.path);
          List<String>? type = mime?.split('/');
          String fileName = path.basename(file.path);
          attachments.add(
            await MultipartFile.fromFile(file.path,
                filename: fileName,
                contentType: MediaType(type!.first, type.last)),
          );
        }
      }
    }

    FormData formData = FormData.fromMap({
      'image': attachments,
      'item': params.path,
    });

    final photoRequest =
        await itemPhotoUseCase.updateItemPhoto(FormParams(formData));

    emit(
      itemRequest.fold(
        (l) => BaseState(
          status: CubitStatus.error,
          message: l.message,
        ),
        (r) {
          return BaseState(
            status: CubitStatus.success,
            entity: r,
          );
        },
      ),
    );
  }
}
