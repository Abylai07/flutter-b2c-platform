import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:b2c_platform/src/common/app_styles/colors.dart';
import 'package:b2c_platform/src/common/app_styles/text_styles.dart';
import 'package:b2c_platform/src/common/enums.dart';
import 'package:b2c_platform/src/common/utils/app_router/app_router.dart';
import 'package:b2c_platform/src/common/utils/shared_preference.dart';
import 'package:b2c_platform/src/presentation/bloc/base_state.dart';
import 'package:b2c_platform/src/presentation/bloc/obscure_bloc.dart';
import 'package:b2c_platform/src/features/auth/presentation/sign_in/bloc/sign_in_cubit.dart';
import 'package:b2c_platform/src/features/auth/presentation/sign_up/sign_up_screen.dart';
import 'package:b2c_platform/src/presentation/widgets/text_fields/custom_text_field.dart';

import '../../../../common/app_styles/assets.dart';
import '../../../../common/utils/l10n/generated/l10n.dart';
import '../../../../common/utils/parsers/date_parser.dart';
import '../../../bloc/button_bloc/button_bloc.dart';
import '../../../widgets/buttons/main_button.dart';


class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  final TextEditingController phone = TextEditingController();
  final TextEditingController password = TextEditingController();

  void checkButtonActive() {
    final buttonBloc = context.read<ButtonBloc>();
    bool buttonActive = buttonBloc.state is ButtonActive;

    if (!buttonActive && phone.text.isNotEmpty && password.text.isNotEmpty) {
      buttonBloc.add(const ToggleButton(isActive: true));
    } else if (buttonActive &&
        (phone.text.isEmpty || password.text.isEmpty)) {
      buttonBloc.add(const ToggleButton(isActive: false));
    }
  }

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<SingInCubit, BaseState>(
      listener: (context, state) {
        if (state.status == CubitStatus.success) {
          SharedPrefs().setPassword(password.text);
          Navigator.pop(context);
          context.router.replaceAll([
            const IndexRoute(children: [HomeRoute()])
          ]);
        } else if (state.status == CubitStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(S.of(context).notFoundAccount),
              backgroundColor: AppColors.errorRedColor,
            ),
          );
        }
      },
      builder: (context, state){
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(16),
            topLeft: Radius.circular(16),
          ),
          child: Scaffold(
            backgroundColor: AppColors.white,
            appBar: AppBar(
              title: Text(S.of(context).signIn),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: SvgPicture.asset(AppAssets.cancel),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      S.of(context).signInText,
                      style: AppTextStyle.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  NewTextFieldWidget(
                    labelText: S.of(context).phoneNumber,
                    controller: phone,
                    inputFormatters: [AppUtils.phoneMaskFormatter],
                    onChanged: (value) {
                      checkButtonActive();
                    },
                  ),
                  const SizedBox(height: 12),
                  BlocBuilder<ObscureBloc, ObscureState>(
                    builder: (context, state) {
                      final isPasswordObscure =
                          (state as TextFieldVisibilityState).isTextVisible;
                      return NewTextFieldWidget(
                        labelText: S.of(context).password,
                        controller: password,
                        hide: !isPasswordObscure,
                        onChanged: (value) {
                          checkButtonActive();
                        },
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
                      );
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
                  bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          constraints: BoxConstraints(
                            maxHeight: 0.9.sh,
                          ),
                          builder: (context) {
                            return const SignUpScreen();
                          },
                        );
                      },
                      child: Text(
                        S.of(context).noAccount,
                        style: AppTextStyle.labelMedium,
                      ),
                    ),
                    const SizedBox(height: 8),
                    BlocBuilder<ButtonBloc, ButtonState>(
                      builder: (context, buttonState) {
                        return CustomMainButton(
                          isActive: buttonState is ButtonActive,
                          text: S.of(context).next,
                          isLoading: state.status == CubitStatus.loading,
                          onTap: () {
                            context.read<SingInCubit>().signIn({
                              "username":
                              '7${AppUtils.phoneMaskFormatter.getUnmaskedText()}',
                              "password": password.text,
                            });
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

