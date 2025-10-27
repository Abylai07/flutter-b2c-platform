import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:b2c_platform/src/common/enums.dart';
import 'package:b2c_platform/src/features/auth/presentation/sign_up/bloc/sign_up_state.dart';
import 'package:b2c_platform/src/features/user/presentation/pages/profile/bloc/user_info_cubit.dart';

import '../../../../../common/app_styles/text_styles.dart';
import '../../../../../common/utils/l10n/generated/l10n.dart';
import '../../../../../common/utils/parsers/date_parser.dart';
import '../../../../bloc/button_bloc/button_bloc.dart';
import '../../../../widgets/buttons/main_button.dart';
import '../../../../widgets/text_fields/custom_text_field.dart';
import '../../../authorization/sign_up/bloc/sign_up_cubit.dart';

class ChangeInfoView extends StatefulWidget {
  const ChangeInfoView({
    super.key,
  });

  @override
  State<ChangeInfoView> createState() => _ChangeInfoViewState();
}

class _ChangeInfoViewState extends State<ChangeInfoView> {
  TextEditingController name = TextEditingController();
  TextEditingController surname = TextEditingController();
  TextEditingController birthday = TextEditingController();

  @override
  Widget build(BuildContext context) {
    checkButtonActive() {
      bool buttonActive = context.read<ButtonBloc>().state is ButtonActive;
      if (!buttonActive &&
          name.text.isNotEmpty &&
          surname.text.isNotEmpty &&
          birthday.text.isNotEmpty) {
        context.read<ButtonBloc>().add(const ToggleButton(isActive: true));
      } else if ((name.text.isEmpty ||
              surname.text.isEmpty ||
              birthday.text.isEmpty) &&
          buttonActive) {
        context.read<ButtonBloc>().add(const ToggleButton(isActive: false));
      }
    }

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(16),
        topLeft: Radius.circular(16),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            S.of(context).changeInfo,
            style: AppTextStyle.titleMedium,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).name,
                style: AppTextStyle.titleSmall,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 16),
                child: NewTextFieldWidget(
                  hintText: S.of(context).name,
                  controller: name,
                  onChanged: (value) {
                    checkButtonActive();
                  },
                ),
              ),
              Text(
                S.of(context).surname,
                style: AppTextStyle.titleSmall,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 12.0),
                child: NewTextFieldWidget(
                  hintText: S.of(context).surname,
                  controller: surname,
                  onChanged: (value) {
                    checkButtonActive();
                  },
                ),
              ),
              Text(
                S.of(context).birthday,
                style: AppTextStyle.titleSmall,
              ),
              8.height,
              NewTextFieldWidget(
                hintText: '01.01.2001',
                controller: birthday,
                inputFormatters: [AppUtils.dateMaskFormatter],
                onChanged: (value) {
                  checkButtonActive();
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: BlocConsumer<SignUpCubit, SignUpState>(
          listener: (context, state) {
            if (state.status == SignUpStatus.successData) {
              Navigator.pop(context);
              context.read<UserInfoCubit>().fetchUserInfo();
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                    right: 16,
                    left: 16,
                    bottom: MediaQuery.of(context).viewInsets.bottom + 16),
                child: CustomMainButton(
                  text: S.of(context).next,
                  isLoading: state.status == SignUpStatus.loading,
                  isActive: context.watch<ButtonBloc>().state is ButtonActive,
                  onTap: () {
                    context.read<SignUpCubit>().signUpData({
                      'first_name': name.text,
                      'last_name': surname.text,
                      'date_of_birth': AppUtils.getServerDate(birthday.text),
                    });
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
