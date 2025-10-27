import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../../../../../domain/entity/items/item_for _update.dart';

part 'photo_event.dart';
part 'photo_state.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  PhotoBloc() : super(const PhotoState()) {
    on<AddPhotos>(_onAddPhotos);
    on<AddUrlPhotos>(_onAddUrlPhotos);
    on<SetMainPhoto>(_onSetMainPhoto);
    on<SwapPhotos>(_onSwapPhotos);
    on<RemovePhoto>(_onRemovePhoto);
    on<RemoveMainPhoto>(_onRemoveMainPhoto);
  }

  void _onAddPhotos(AddPhotos event, Emitter<PhotoState> emit) {
    List<File> updatedPhotos = List.from(state.photos)..addAll(event.photos);
    if (updatedPhotos.length > 5) {
      updatedPhotos = updatedPhotos.sublist(0, 5);
    }
    emit(state.copyWith(photos: updatedPhotos));
    if (updatedPhotos.isNotEmpty && state.mainPhoto == null) {
      add(const SetMainPhoto(
          0)); // Set the first photo as the main photo if no main photo is set
    }
  }

  Future<void> _onAddUrlPhotos(
      AddUrlPhotos event, Emitter<PhotoState> emit) async {
    emit(state.copyWith(isLoading: true));
    List<File> updatedPhotos = List.from(state.photos);
    Directory tempDir = await getTemporaryDirectory();
    // Create the HTTP client.
    var client = http.Client();
    try {
      // Fetch the image as a stream of bytes.
      for (final photo in event.photos) {
        Uri uri = Uri.parse(photo.image);
        var response = await client.get(uri);
        File file = File(path.join(
            tempDir.path, '?code=${photo.id}&${uri.pathSegments.last}'));
        await file.writeAsBytes(response.bodyBytes);
        updatedPhotos.add(file);
      }
    } finally {
      client.close();
    }

    if (updatedPhotos.length > 5) {
      updatedPhotos = updatedPhotos.sublist(0, 5);
    }

    emit(state.copyWith(photos: updatedPhotos));
    if (updatedPhotos.isNotEmpty && state.mainPhoto == null) {
      add(const SetMainPhoto(0));
    }
  }

  void _onSetMainPhoto(SetMainPhoto event, Emitter<PhotoState> emit) {
    File? mainPhoto = state.photos[event.index];
    List<File> updatedPhotos = List.from(state.photos)..removeAt(event.index);
    if (state.mainPhoto != null) {
      updatedPhotos.add(state.mainPhoto!);
    }
    emit(state.copyWith(mainPhoto: mainPhoto, photos: updatedPhotos));
  }

  void _onSwapPhotos(SwapPhotos event, Emitter<PhotoState> emit) {
    List<File> updatedPhotos = List.from(state.photos);
    final temp = updatedPhotos[event.oldIndex];
    updatedPhotos[event.oldIndex] = updatedPhotos[event.newIndex];
    updatedPhotos[event.newIndex] = temp;
    emit(state.copyWith(photos: updatedPhotos));
  }

  void _onRemovePhoto(RemovePhoto event, Emitter<PhotoState> emit) {
    List<File> updatedPhotos = List.from(state.photos);
    List<File> removeAfter = List.from(state.removeAfter);
    String path = state.photos[event.index].path;
    Match? match = RegExp(r'\?code=(\d+)').firstMatch(path);
    if (match != null) {
      removeAfter.add(state.photos[event.index]);
    }
    updatedPhotos.removeAt(event.index);
    emit(state.copyWith(photos: updatedPhotos, removeAfter: removeAfter));
  }

  void _onRemoveMainPhoto(RemoveMainPhoto event, Emitter<PhotoState> emit) {
    //  emit(state.copyWith(mainPhoto: ));
  }
}
