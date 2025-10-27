import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:b2c_platform/src/common/enums.dart';
import 'package:b2c_platform/src/presentation/bloc/base_state.dart';
import 'package:b2c_platform/src/features/user/presentation/pages/profile/bloc/user_info_cubit.dart';
import 'package:b2c_platform/src/features/user/presentation/pages/profile/bloc/user_photo_cubit.dart';
import 'package:b2c_platform/src/features/user/presentation/pages/profile/screens/widgets/change_info_view.dart';
import 'package:b2c_platform/src/features/user/presentation/pages/profile/screens/widgets/change_password_view.dart';
import 'package:b2c_platform/src/presentation/widgets/mixins/file_picker.dart';

import '../../../../common/app_styles/colors.dart';
import '../../../../common/app_styles/text_styles.dart';
import '../../../../common/utils/l10n/generated/l10n.dart';
import '../../../../domain/entity/user/user_entity.dart';
import '../../../../get_it_sl.dart';
import '../../../bloc/button_bloc/button_bloc.dart';
import '../../../widgets/add_photo_view.dart';
import '../../authorization/sign_up/bloc/password/password_bloc.dart';
import '../widgets/profile_tile_widget.dart';

@RoutePage()
class PersonalDataScreen extends StatelessWidget {
  const PersonalDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<UserPhotoCubit>(
        create: (_) => sl<UserPhotoCubit>(),
      ),
    ], child: const PersonalDataView());
  }
}

class PersonalDataView extends StatelessWidget with FilePickerMixin {
  const PersonalDataView({super.key});

  @override
  Widget build(BuildContext context) {
    uploadPhoto(File file) async {
      FormData data = FormData.fromMap({
        'image': [await MultipartFile.fromFile(file.path)]
      });
      context.read<UserPhotoCubit>().updateUserPhoto(data);
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          S.of(context).personalData,
          style: AppTextStyle.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<UserInfoCubit, BaseState>(
          builder: (context, state) {
            if (state.status.isSuccess) {
              UserEntity user = state.entity;
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        constraints: BoxConstraints(
                          maxHeight: 0.4.sh,
                        ),
                        builder: (context) {
                          return AddPhotoModal(
                            onGalleryTap: () async {
                              var result = await pickPhotoSingle(context);
                              if (result != null) {
                                Navigator.pop(context);
                                uploadPhoto(result);
                              }
                            },
                            onCameraTap: () async {
                              var result = await takePhoto(context);
                              if (result != null) {
                                Navigator.pop(context);
                                uploadPhoto(result);
                              }
                            },
                          );
                        },
                      );
                    },
                    child: Column(
                      children: [
                        const CircleAvatar(
                          radius: 60,
                          backgroundColor: AppColors.gray1,
                          child: Icon(
                            Icons.person,
                            size: 80,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 24),
                          child: Text(
                            S.of(context).newPhoto,
                            style: AppTextStyle.labelLarge
                                .copyWith(color: AppColors.gray),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 6,
                          offset:
                              const Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        ProfileTileWidget(
                          title: S.of(context).name,
                          description: user.firstName ?? '',
                          onTap: () {
                            showInfoChangeModal(context);
                          },
                        ),
                        const Divider(
                          height: 32,
                          color: AppColors.divider,
                        ),
                        ProfileTileWidget(
                          title: S.of(context).surname,
                          description: user.lastName ?? '',
                          onTap: () {
                            showInfoChangeModal(context);
                          },
                        ),
                        const Divider(
                          height: 32,
                          color: AppColors.divider,
                        ),
                        ProfileTileWidget(
                          title: S.of(context).birthday,
                          description: user.dateOfBirth ?? '',
                          onTap: () {
                            showInfoChangeModal(context);
                          },
                        ),
                        const Divider(
                          height: 32,
                          color: AppColors.divider,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0, top: 4),
                          child: ProfileTileWidget(
                            description: S.of(context).changePassword,
                            onTap: () {
                              showPasswordChangeModal(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            } else if (state.status.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }

  showPasswordChangeModal(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      constraints: BoxConstraints(
        maxHeight: 0.9.sh,
      ),
      builder: (ctx) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => PasswordBloc(),
            ),
            BlocProvider(
              create: (_) => ButtonBloc(),
            ),
          ],
          child: const ChangePasswordView(),
        );
      },
    );
  }

  showInfoChangeModal(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      constraints: BoxConstraints(
        maxHeight: 0.9.sh,
      ),
      builder: (ctx) {
        return MultiBlocProvider(providers: [
          BlocProvider(
            create: (_) => ButtonBloc(),
          ),
        ], child: const ChangeInfoView());
      },
    );
  }
}
