import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:b2c_platform/src/common/enums.dart';
import 'package:b2c_platform/src/common/utils/app_router/app_router.dart';
import 'package:b2c_platform/src/common/utils/shared_preference.dart';
import 'package:b2c_platform/src/features/user/domain/entities/user_entity.dart';
import 'package:b2c_platform/src/presentation/bloc/base_state.dart';
import 'package:b2c_platform/src/features/user/presentation/pages/profile/widgets/profile_button_widget.dart';
import 'package:b2c_platform/src/features/user/presentation/pages/profile/widgets/profile_tile_widget.dart';
import 'package:b2c_platform/src/presentation/widgets/show_error_snackbar.dart';

import '../../../common/app_styles/colors.dart';
import '../../../common/app_styles/text_styles.dart';
import '../../../common/utils/l10n/generated/l10n.dart';
import '../../widgets/alert_dialog/text_alert_dialog.dart';
import 'bloc/delete_me_cubit.dart';
import 'bloc/user_info_cubit.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserInfoCubit, BaseState>(
      builder: (context, state) {
        UserEntity? entity;
        if (state.status.isSuccess) {
          entity = state.entity;
        }
        return Scaffold(
            appBar: AppBar(
              centerTitle: false,
              title: Text(
                entity != null
                    ? S
                        .of(context)
                        .helloUser(entity.firstName ?? entity.companyName ?? '')
                    : 'Привет!',
                style: AppTextStyle.headlineSmall,
              ),
            ),
            body: state.status.isSuccess
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
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
                            '${entity?.firstName} ${entity?.lastName}',
                            style: AppTextStyle.titleSmall,
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
                                offset: const Offset(
                                    0, 2), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              ProfileTileWidget(
                                description: S.of(context).personalData,
                                onTap: () {
                                  context.router
                                      .push(const PersonalDataRoute());
                                },
                              ),
                              const Divider(
                                height: 32,
                                color: AppColors.divider,
                              ),
                              ProfileTileWidget(
                                description: S.of(context).advertisement,
                                onTap: () {
                                  context.router
                                      .push(const AdvertisementRoute());
                                },
                              ),
                              const Divider(
                                height: 32,
                                color: AppColors.divider,
                              ),
                              ProfileTileWidget(
                                description: S.of(context).orders,
                                onTap: () {
                                  context.router.push(const OrdersRoute());
                                },
                              ),
                              const Divider(
                                height: 32,
                                color: AppColors.divider,
                              ),
                              ProfileTileWidget(
                                description: S.of(context).appSettings,
                                onTap: () {
                                  context.router.push(const AppSettingRoute());
                                },
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 24.0, bottom: 16),
                          child: ProfileButtonWidget(
                            textColor: AppColors.black,
                            onTap: () {
                              textAlertDialog(context,
                                  title: S.of(context).logoutDesc,
                                  onYesTap: () {
                                //    context.read<SingInCubit>().logout();
                                SharedPrefs().deleteTokens();
                                Navigator.pop(context);
                                context.router.replaceAll([
                                  const IndexRoute(children: [HomeRoute()])
                                ]);
                              });
                            },
                            title: S.of(context).signOut,
                          ),
                        ),
                        BlocListener<DeleteMeCubit, BaseState>(
                          listener: (context, state) {
                            if (state.status.isSuccess) {
                              SharedPrefs().deleteTokens();
                              Navigator.pop(context);
                              context.router.replaceAll([
                                const IndexRoute(children: [HomeRoute()])
                              ]);
                            } else if (state.status.isError) {
                              showErrorSnackBar(context,
                                  '${S.of(context).somethingWrong} ${state.message}');
                            }
                          },
                          child: ProfileButtonWidget(
                            textColor: AppColors.errorRedColor,
                            onTap: () {
                              textAlertDialog(context,
                                  title: S.of(context).deleteAccountDesc,
                                  onYesTap: () {
                                context.read<DeleteMeCubit>().deleteMe();
                              });
                            },
                            title: S.of(context).deleteAccount,
                          ),
                        ),
                      ],
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ));
      },
    );
  }
}
