import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:b2c_platform/src/common/utils/shared_preference.dart';
import 'package:b2c_platform/src/features/auth/presentation/sign_up/bloc/sign_up_state.dart';
import 'package:b2c_platform/src/presentation/widgets/show_error_snackbar.dart';

import '../../../../../common/app_styles/colors.dart';
import '../../../../../common/app_styles/text_styles.dart';
import '../../../../../common/utils/l10n/generated/l10n.dart';
import '../../../../bloc/button_bloc/button_bloc.dart';
import '../../../../bloc/obscure_bloc.dart';
import '../../../../widgets/buttons/main_button.dart';
import '../../../../widgets/snack_bar.dart';
import '../../../../widgets/text_fields/custom_text_field.dart';
import '../../../authorization/sign_up/bloc/password/password_bloc.dart';
import '../../../authorization/sign_up/bloc/sign_up_cubit.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({
    super.key,
  });

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  TextEditingController currentPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController passwordAgain = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(16),
        topLeft: Radius.circular(16),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            S.of(context).changePassword,
            style: AppTextStyle.titleMedium,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<ObscureBloc, ObscureState>(
                builder: (context, state) {
                  final isPasswordObscure =
                      (state as TextFieldVisibilityState).isTextVisible;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).writeCurrentPassword,
                        style: AppTextStyle.titleSmall,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 16),
                        child: NewTextFieldWidget(
                          labelText: S.of(context).password,
                          controller: currentPassword,
                          hide: !isPasswordObscure,
                          suffixIcon: IconButton(
                            icon: Icon(
                              isPasswordObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: AppColors.gray,
                            ),
                            onPressed: () {
                              context
                                  .read<ObscureBloc>()
                                  .add(ToggleVisibilityEvent());
                            },
                          ),
                          onChanged: (value) {},
                        ),
                      ),
                      Text(
                        S.of(context).writeNewPassword,
                        style: AppTextStyle.titleSmall,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 12.0),
                        child: NewTextFieldWidget(
                          labelText: S.of(context).newPassword,
                          controller: newPassword,
                          hide: !isPasswordObscure,
                          suffixIcon: IconButton(
                            icon: Icon(
                              isPasswordObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: AppColors.gray,
                            ),
                            onPressed: () {
                              context
                                  .read<ObscureBloc>()
                                  .add(ToggleVisibilityEvent());
                            },
                          ),
                          onChanged: (value) {
                            if (value == null || passwordAgain.text.isEmpty) {
                              return;
                            }
                            context.read<PasswordBloc>().add(MatchPassword(
                                confirmPassword: passwordAgain.text,
                                password: value));
                          },
                        ),
                      ),
                      NewTextFieldWidget(
                        labelText: S.of(context).passwordAgain,
                        controller: passwordAgain,
                        hide: !isPasswordObscure,
                        suffixIcon: IconButton(
                          icon: Icon(
                            isPasswordObscure
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColors.gray,
                          ),
                          onPressed: () {
                            context
                                .read<ObscureBloc>()
                                .add(ToggleVisibilityEvent());
                          },
                        ),
                        onChanged: (value) {
                          if (value == null || newPassword.text.isEmpty) return;
                          context.read<PasswordBloc>().add(MatchPassword(
                              confirmPassword: value,
                              password: newPassword.text));
                        },
                      ),
                    ],
                  );
                },
              ),
              BlocConsumer<PasswordBloc, PasswordState>(
                listener: (context, state) {
                  bool buttonActive =
                      context.read<ButtonBloc>().state is ButtonActive;
                  if (state is PasswordsMatch &&
                      !buttonActive &&
                      currentPassword.text.isNotEmpty) {
                    context
                        .read<ButtonBloc>()
                        .add(const ToggleButton(isActive: true));
                  } else if ((state is PasswordsDoNotMatch ||
                          currentPassword.text.isEmpty) &&
                      buttonActive) {
                    context
                        .read<ButtonBloc>()
                        .add(const ToggleButton(isActive: false));
                  }
                },
                builder: (context, state) {
                  return state is PasswordsDoNotMatch
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Text(
                            S.of(context).passwordNotMatch,
                            style: AppTextStyle.labelLarge
                                .copyWith(color: AppColors.errorRedColor),
                          ),
                        )
                      : const SizedBox();
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
                right: 16,
                left: 16,
                bottom: MediaQuery.of(context).viewInsets.bottom + 16),
            child: BlocConsumer<SignUpCubit, SignUpState>(
              listener: (context, state) {
                if (state.status == SignUpStatus.successPassword) {
                  AppSnackBarWidget(description: S.of(context).success)
                      .show(context);
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                return CustomMainButton(
                  text: S.of(context).next,
                  isLoading: state.status == SignUpStatus.loading,
                  isActive: context.watch<ButtonBloc>().state is ButtonActive,
                  onTap: () {
                    String? savePassword = SharedPrefs().getPassword();
                    if (savePassword == currentPassword.text) {
                      context.read<SignUpCubit>().signUpPassword({
                        'password': newPassword.text,
                      });
                    } else {
                      showErrorSnackBar(
                          context, S.of(context).wrongCurrentPass);
                    }
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
