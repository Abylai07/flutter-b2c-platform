part of 'photo_bloc.dart';

abstract class PhotoEvent extends Equatable {
  const PhotoEvent();

  @override
  List<Object> get props => [];
}

class AddPhotos extends PhotoEvent {
  final List<File> photos;

  const AddPhotos(this.photos);

  @override
  List<Object> get props => [photos];
}

class AddUrlPhotos extends PhotoEvent {
  final List<ImageInfoEntity> photos;

  const AddUrlPhotos(this.photos);

  @override
  List<Object> get props => [photos];
}

class SetMainPhoto extends PhotoEvent {
  final int index;

  const SetMainPhoto(this.index);

  @override
  List<Object> get props => [index];
}

class SwapPhotos extends PhotoEvent {
  final int oldIndex;
  final int newIndex;

  const SwapPhotos(this.oldIndex, this.newIndex);

  @override
  List<Object> get props => [oldIndex, newIndex];
}

class RemovePhoto extends PhotoEvent {
  final int index;

  const RemovePhoto(this.index);

  @override
  List<Object> get props => [index];
}

class RemoveMainPhoto extends PhotoEvent {

  const RemoveMainPhoto();

}

