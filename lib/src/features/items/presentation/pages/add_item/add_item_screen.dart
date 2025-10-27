import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:b2c_platform/src/common/app_styles/text_styles.dart';
import 'package:b2c_platform/src/common/enums.dart';
import 'package:b2c_platform/src/features/user/domain/entities/user_entity.dart';
import 'package:b2c_platform/src/presentation/bloc/base_state.dart';
import 'package:b2c_platform/src/features/items/presentation/pages/add_item/screens/sign_up_organization.dart';
import 'package:b2c_platform/src/features/items/presentation/pages/add_item/widget/category_select_widget.dart';
import 'package:b2c_platform/src/features/user/presentation/pages/profile/bloc/user_info_cubit.dart';
import 'package:b2c_platform/src/presentation/widgets/show_error_snackbar.dart';
import 'package:b2c_platform/src/presentation/widgets/text_fields/custom_text_field.dart';

import '../../../common/utils/app_router/app_router.dart';
import '../../../common/utils/l10n/generated/l10n.dart';
import '../../../common/utils/shared_preference.dart';
import '../../../domain/entity/items/categories_entity.dart';
import '../../widgets/my_app_bar.dart';
import '../home/bloc/category_cubit.dart';

@RoutePage()
class AddItemScreen extends StatelessWidget {
  const AddItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showRegisterShopModal(){
      showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: false,
        isDismissible: false,
        context: context,
        constraints: BoxConstraints(
          maxHeight: 0.9.sh,
        ),
        builder: (context) {
          return const SignUpOrganization();
        },
      );
    }
    return Scaffold(
        appBar: MyAppBar(
          centerTitle: true,
          title: S.of(context).addItem,
        ),
        body: BlocConsumer<UserInfoCubit, BaseState>(
          listener: (context, state) {
            if (state.status.isSuccess) {
              UserEntity user = state.entity;
              if (user.organizationType == '' || user.organizationType == null) {
                SharedPrefs().setVerifyOrganization(true);
                showRegisterShopModal();
              } else {
                SharedPrefs().setVerifyOrganization(false);
              }
            }
          },
          builder: (context, state) {
            if (state.status.isSuccess) {
              UserEntity user = state.entity;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).itemName,
                      style: AppTextStyle.titleSmall,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 24),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            CustomTextFieldWidget(
                                hintText: S.of(context).itemNameHint,
                                controller: controller,
                                valid: (value) {
                                  if (value!.isEmpty) {
                                    return S.of(context).mustFill;
                                  }
                                }),
                          ],
                        ),
                      ),
                    ),
                    Text(
                      S.of(context).selectCategory,
                      style: AppTextStyle.titleSmall,
                    ),
                    // SearchTextFieldWidget(
                    //   controller: controller,
                    //   hintText: S.of(context).search,
                    //   onChanged: onChanged,
                    // )
                    12.height,
                    BlocBuilder<CategoryCubit, BaseState>(
                      builder: (context, state) {
                        if (state.status.isSuccess) {
                          List<CategoryEntity> categories = state.entity;
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: categories.length,
                            itemBuilder: (context, i) {
                              return CategorySelectWidget(
                                category: categories[i],
                                onTap: () {
                                  if(user.organizationType == '' || user.organizationType == null){
                                    showRegisterShopModal();
                                  } else if (controller.text.isEmpty) {
                                    formKey.currentState?.validate();
                                  } else {
                                    context.router.push(SelectSubCategoryRoute(
                                        titleItem: controller.text,
                                        category: categories[i]));
                                  }
                                },
                              );
                            },
                          );
                        } else if (state.status.isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                  ],
                ),
              );
            } else if (state.status.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const SizedBox();
            }
          },
        ));
  }
}
