import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:b2c_platform/src/common/enums.dart';
import 'package:b2c_platform/src/common/utils/shared_preference.dart';
import 'package:b2c_platform/src/presentation/bloc/base_state.dart';
import 'package:b2c_platform/src/features/home/presentation/pages/bloc/city_bloc/city_cubit.dart';

import '../../../../common/app_styles/assets.dart';
import '../../../../common/app_styles/text_styles.dart';
import '../../../../common/utils/l10n/generated/l10n.dart';
import '../../../../domain/entity/user/city_entity.dart';
import '../../../widgets/city_modal_sheet.dart';
import '../../../widgets/text_fields/custom_text_field.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar(
      {super.key,
      required this.title,
      this.onChanged,
      this.centerTitle = false});
  final String title;
  final bool centerTitle;
  final Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle,
      title: BlocBuilder<CityCubit, CityState>(
        builder: (context, state) {
          if(state.status.isSuccess){
            return GestureDetector(
              onTap: (){
                cityModalBottomSheet(context);
              },
              child: Row(
                children: [
                  SvgPicture.asset(
                    AppAssets.city,
                    height: 18,
                  ),
                  6.width,
                  Text(
                    state.selectCity?.name ?? title,
                    style: AppTextStyle.titleSmall,
                  ),
                ],
              ),
            );
          }
          return Text(
            title,
            style: AppTextStyle.appBarStyle,
          );
        },
      ),
      bottom: onChanged != null
          ? PreferredSize(
              preferredSize:
                  Size(MediaQuery.of(context).size.width, kToolbarHeight),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 6, 16, 12),
                child: SearchTextFieldWidget(
                  isNotFilled: false,
                  hintText: S.of(context).search,
                  onChanged: onChanged,
                ),
              ))
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(onChanged == null ? 56 : 102);
}
