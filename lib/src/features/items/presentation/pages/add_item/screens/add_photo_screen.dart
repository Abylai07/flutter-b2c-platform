import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as path;
import 'package:b2c_platform/src/common/app_styles/assets.dart';
import 'package:b2c_platform/src/common/enums.dart';
import 'package:b2c_platform/src/common/utils/app_router/app_router.dart';
import 'package:b2c_platform/src/features/items/domain/entities/create_item_entity.dart';
import 'package:b2c_platform/src/presentation/bloc/base_state.dart';
import 'package:b2c_platform/src/presentation/widgets/mixins/file_picker.dart';
import 'package:b2c_platform/src/presentation/widgets/snack_bar.dart';

import '../../../../common/app_styles/colors.dart';
import '../../../../common/app_styles/text_styles.dart';
import '../../../../common/utils/l10n/generated/l10n.dart';
import '../../../../get_it_sl.dart';
import '../../../widgets/add_photo_view.dart';
import '../../../widgets/buttons/main_button.dart';
import '../../../widgets/show_error_snackbar.dart';
import '../bloc/item_photo_cubit.dart';
import '../bloc/photo_bloc/photo_bloc.dart';

@RoutePage()
class AddPhotoScreen extends StatelessWidget {
  const AddPhotoScreen({super.key, required this.createItem});
  final CreateItemEntity createItem;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<ItemPhotoCubit>(
        create: (_) => sl<ItemPhotoCubit>(),
      ),
      BlocProvider(
        create: (_) => PhotoBloc(),
      ),
    ], child: AddPhotoView(createItem: createItem));
  }
}

class AddPhotoView extends StatelessWidget with FilePickerMixin {
  const AddPhotoView({super.key, required this.createItem});
  final CreateItemEntity createItem;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          color: AppColors.mainBlue,
          onPressed: () {
            context.router.maybePop();
          },
        ),
        title: Text(
          S.of(context).addItem,
          style: AppTextStyle.titleMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).addPhotoItem,
              style: AppTextStyle.titleSmall,
            ),
            BlocBuilder<PhotoBloc, PhotoState>(
              builder: (context, state) {
                return state.photos.isEmpty && state.mainPhoto == null
                    ? Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: buildAddPhoto(context, false),
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
                              DragTarget<File>(
                                onAcceptWithDetails: (data) {
                                  final newIndex =
                                      state.photos.indexOf(data.data);
                                  context
                                      .read<PhotoBloc>()
                                      .add(SetMainPhoto(newIndex));
                                },
                                builder:
                                    (context, candidateData, rejectedData) {
                                  return Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      if (state.mainPhoto != null)
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.file(
                                            state.mainPhoto!,
                                            width: 110.w,
                                            height: 190,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      // Positioned(
                                      //   top: 5,
                                      //   right: 5,
                                      //   child: GestureDetector(
                                      //     onTap: () {
                                      //       context
                                      //           .read<PhotoBloc>()
                                      //           .add(const RemoveMainPhoto());
                                      //     },
                                      //     child: const Icon(
                                      //       Icons.close,
                                      //       color: AppColors.mainBlue,
                                      //     ),
                                      //   ),
                                      // ),
                                      Positioned(
                                        bottom: 10,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: AppColors.mainBlue
                                                .withOpacity(0.6),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            S.of(context).mainPhoto,
                                            style: AppTextStyle.labelSmall
                                                .copyWith(
                                                    color: AppColors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
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
            Text(
              S.of(context).addPhotoDesc,
              style: AppTextStyle.displayLarge.copyWith(color: AppColors.gray),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BlocConsumer<ItemPhotoCubit, BaseState>(
        listener: (context, state) {
          if (state.status.isSuccess) {
            AppSnackBarWidget(description: S.of(context).success).show(context);
            context.router.replaceAll([
              const IndexRoute(children: [HomeRoute()])
            ]);
          } else if (state.status.isError) {
            showErrorSnackBar(context, S.of(context).somethingWrong);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
              child: CustomMainButton(
                  text: S.of(context).next,
                  isLoading: state.status.isLoading,
                  onTap: () async {
                    final photoState = context.read<PhotoBloc>().state;
                    if (photoState.mainPhoto != null) {
                      List<MultipartFile> attachments = [];
                      for (var file in [
                        photoState.mainPhoto,
                        ...photoState.photos
                      ]) {
                        if (file != null) {
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
                      FormData formData = FormData.fromMap({
                        'image': attachments,
                        'item': createItem.id,
                      });
                      context.read<ItemPhotoCubit>().updateItemPhoto(formData);
                    } else {
                      showErrorSnackBar(context, S.of(context).addPhotoItem);
                    }
                  }),
            ),
          );
        },
      ),
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
