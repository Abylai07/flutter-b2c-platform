part of 'photo_bloc.dart';

class PhotoState extends Equatable {
  final List<File> photos;
  final List<File> removeAfter;
  final File? mainPhoto;
  final bool isLoading;

  const PhotoState(
      {this.photos = const [],
      this.removeAfter = const [],
      this.mainPhoto,
      this.isLoading = false});

  PhotoState copyWith(
      {List<File>? photos,
      List<File>? removeAfter,
      File? mainPhoto,
      bool isLoading = false}) {
    return PhotoState(
      photos: photos ?? this.photos,
      mainPhoto: mainPhoto ?? this.mainPhoto,
      removeAfter: removeAfter ?? this.removeAfter,
      isLoading: isLoading,
    );
  }

  @override
  List<Object?> get props => [photos, mainPhoto, removeAfter, isLoading];
}
