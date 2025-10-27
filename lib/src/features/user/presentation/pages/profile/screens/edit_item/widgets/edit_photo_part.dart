import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:b2c_platform/src/common/app_styles/assets.dart';
import 'package:b2c_platform/src/common/enums.dart';
import 'package:b2c_platform/src/presentation/widgets/mixins/file_picker.dart';

import '../../../../../../common/app_styles/colors.dart';
import '../../../../../../common/app_styles/text_styles.dart';
import '../../../../../../common/utils/l10n/generated/l10n.dart';
import '../../../../../../domain/entity/items/my_items_entity.dart';
import '../../../../../widgets/add_photo_view.dart';
import '../../../../add_item/bloc/photo_bloc/photo_bloc.dart';

class EditPhotoPart extends StatelessWidget with FilePickerMixin {
  const EditPhotoPart({super.key, required this.item});
  final MyItemEntity item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).changePhotoItem,
          style: AppTextStyle.titleSmall,
        ),
        BlocBuilder<PhotoBloc, PhotoState>(
          builder: (context, state) {
            return (state.photos.isEmpty && state.mainPhoto == null) &&
                    item.images.isEmpty &&
                    item.outsideImages.isEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: buildAddPhoto(context, false),
                  )
                : state.isLoading
                    ? const SizedBox(
                        height: 190,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 4.0, bottom: 16),
                            child: Text(
                              S.of(context).changePhoto,
                              style: AppTextStyle.displayLarge
                                  .copyWith(color: AppColors.gray),
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 110.w,
                                height: 190,
                                child: DragTarget<File>(
                                  onAcceptWithDetails: (data) {
                                    final newIndex =
                                        state.photos.indexOf(data.data);
                                    context
                                        .read<PhotoBloc>()
                                        .add(SetMainPhoto(newIndex));
                                  },
                                  builder:
                                      (context, candidateData, rejectedData) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.file(
                                        state.mainPhoto!,
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              10.width,
                              Expanded(
                                child: GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 10,
                                          mainAxisExtent: 90),
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: 4,
                                  itemBuilder: (context, index) {
                                    return state.photos.length > index
                                        ? DragTarget<File>(
                                            onAcceptWithDetails: (data) {
                                              final draggedIndex = state.photos
                                                  .indexOf(data.data);
                                              context.read<PhotoBloc>().add(
                                                  SwapPhotos(
                                                      draggedIndex, index));
                                            },
                                            builder: (context, candidateData,
                                                rejectedData) {
                                              return Draggable<File>(
                                                data: state.photos[index],
                                                feedback: Image.file(
                                                  state.photos[index],
                                                  height: 90,
                                                  fit: BoxFit.cover,
                                                ),
                                                childWhenDragging: Container(
                                                  height: 90,
                                                  decoration: BoxDecoration(
                                                      color: AppColors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6)),
                                                ),
                                                child: Stack(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                      child: Image.file(
                                                        state.photos[index],
                                                        height: 90,
                                                        width: double.infinity,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Positioned(
                                                      top: 5,
                                                      right: 5,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          context
                                                              .read<PhotoBloc>()
                                                              .add(RemovePhoto(
                                                                  index));
                                                        },
                                                        child: const Icon(
                                                          Icons.close,
                                                          color: AppColors
                                                              .mainBlue,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          )
                                        : buildAddPhoto(context, true);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
          },
        ),
        16.height,
      ],
    );
  }

  Widget buildAddPhoto(BuildContext context, bool isSmall) {
    return InkWell(
      onTap: () async {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          constraints: BoxConstraints(
            maxHeight: 0.4.sh,
          ),
          builder: (ctx) {
            return AddPhotoModal(
              onGalleryTap: () async {
                var result = await pickPhotoMulti(ctx);
                if (result.isNotEmpty) {
                  Navigator.pop(ctx);
                  context.read<PhotoBloc>().add(AddPhotos(result));
                }
              },
              onCameraTap: () async {
                var result = await takePhoto(ctx);
                if (result != null) {
                  context.read<PhotoBloc>().add(AddPhotos([result]));
                }
              },
            );
          },
        );
      },
      child: DottedBorder(
        radius: const Radius.circular(16),
        borderType: BorderType.RRect,
        dashPattern: const <double>[9, 9],
        color: Colors.black,
        strokeWidth: 1,
        child: SizedBox(
          height: isSmall ? 90 : 150,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(AppAssets.add),
              if (!isSmall) ...[
                8.height,
                Text(
                  S.of(context).addPhoto,
                  style: AppTextStyle.labelLarge,
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
