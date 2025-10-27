import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:b2c_platform/src/common/app_styles/assets.dart';
import 'package:b2c_platform/src/common/enums.dart';
import 'package:b2c_platform/src/common/utils/app_router/app_router.dart';
import 'package:b2c_platform/src/features/auth/presentation/sign_in/sign_in_screen.dart';
import 'package:b2c_platform/src/features/auth/presentation/sign_up/bloc/sign_up_cubit.dart';

import '../../../../common/app_styles/colors.dart';
import '../../../../common/app_styles/text_styles.dart';
import '../../../../common/utils/l10n/generated/l10n.dart';
import '../../../../common/utils/parsers/date_parser.dart';
import '../../../../get_it_sl.dart';
import '../../../bloc/button_bloc/button_bloc.dart';
import '../../../bloc/obscure_bloc.dart';
import '../../../widgets/buttons/main_button.dart';
import '../../../widgets/show_error_snackbar.dart';
import '../../../widgets/snack_bar.dart';
import '../../../widgets/text_fields/custom_text_field.dart';
import '../bloc/timer_bloc.dart';
import 'bloc/password/password_bloc.dart';
import 'bloc/sign_up_state.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<TimerBloc>(
        create: (_) => TimerBloc()..add(StartTimer()),
      ),
      BlocProvider<SignUpCubit>(
        create: (_) => sl<SignUpCubit>(),
      ),
      BlocProvider(
        create: (_) => PasswordBloc(),
      ),
    ], child: const SignUpView());
  }
}

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();

    TextEditingController code = TextEditingController();
    TextEditingController name = TextEditingController();
    TextEditingController surname = TextEditingController();
    TextEditingController birthday = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController passwordAgain = TextEditingController();

    sentDataByStatus(SignUpStatus status) {
      if (status == SignUpStatus.initial || status == SignUpStatus.errorOtp) {
        context.read<SignUpCubit>().signUpOtp({
          'username': '7${AppUtils.phoneMaskFormatter.getUnmaskedText()}',
        });
      } else if (status == SignUpStatus.successOtp ||
          status == SignUpStatus.errorVerify) {
        context.read<SignUpCubit>().signUpVerify({
          'username': '7${AppUtils.phoneMaskFormatter.getUnmaskedText()}',
          'otp': code.text,
        });
      } else if (status == SignUpStatus.successVerify ||
          status == SignUpStatus.errorData) {
        context.read<SignUpCubit>().signUpData({
          'first_name': name.text,
          'last_name': surname.text,
          'date_of_birth': AppUtils.getServerDate(birthday.text),
        });
      } else if (status == SignUpStatus.successData ||
          status == SignUpStatus.errorPassword) {
        if (password.text == passwordAgain.text) {
          context.read<SignUpCubit>().signUpPassword({
            'password': password.text,
          });
        } else {
          context.read<PasswordBloc>().add(MatchPassword(
              confirmPassword: passwordAgain.text, password: password.text));
        }
      }
    }

    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status == SignUpStatus.successOtp ||
            state.status == SignUpStatus.successVerify ||
            state.status == SignUpStatus.successData) {
          pageController.animateToPage(getIndexByStatus(state.status),
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeIn);
          context.read<ButtonBloc>().add(const ToggleButton(isActive: false));
        } else if (state.status == SignUpStatus.successPassword) {
          Navigator.pop(context);
          context.router.replaceAll([
            const IndexRoute(children: [HomeRoute()])
          ]);
          AppSnackBarWidget(
            description: S.of(context).singUpSuccess,
          ).show(context);
        } else if (state.status.toString().contains('error')) {
          showErrorSnackBar(
            context,
            state.message == 'authorized'
                ? S.of(context).authorized
                : state.status == SignUpStatus.errorVerify
                    ? S.of(context).notRightCode
                    : state.message,
          );
        }
      },
      builder: (context, state) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(16), topLeft: Radius.circular(16)),
          child: Scaffold(
            backgroundColor: AppColors.white,
            appBar: AppBar(
              title: Text(S.of(context).singUp),
              automaticallyImplyLeading: false,
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
              child: PageView(
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                // onPageChanged: (index) {
                //   context
                //       .read<ButtonBloc>()
                //       .add(const ToggleButton(isActive: false));
                // },
                children: [
                  buildPhoneView(context),
                  buildCodeView(context, state, code),
                  buildDataView(context, name, surname, birthday),
                  buildPasswordView(context, password, passwordAgain),
                ],
              ),
            ),
            bottomNavigationBar: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                    right: 16,
                    left: 16,
                    bottom: MediaQuery.of(context).viewInsets.bottom + 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (state.status == SignUpStatus.initial ||
                        state.status == SignUpStatus.errorOtp) ...[
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
                                return const SignInScreen();
                              },
                            );
                          },
                          child: Text(
                            S.of(context).haveAccount,
                            style: AppTextStyle.labelMedium,
                          )),
                      8.height,
                    ],
                    BlocBuilder<ButtonBloc, ButtonState>(
                      builder: (context, buttonState) {
                        return CustomMainButton(
                          text: S.of(context).next,
                          isLoading: state.status == SignUpStatus.loading,
                          isActive: buttonState is ButtonActive,
                          onTap: () {
                            debugPrint('state status ${state.status}');
                            if (buttonState is ButtonActive) {
                              sentDataByStatus(state.status);
                            }
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

  Widget buildPasswordView(BuildContext context, TextEditingController password,
      TextEditingController passwordAgain) {
    return Column(
      children: [
        20.height,
        Text(
          S.of(context).needPassword,
          style: AppTextStyle.bodyLarge,
          textAlign: TextAlign.center,
        ),
        BlocBuilder<ObscureBloc, ObscureState>(
          builder: (context, state) {
            final isPasswordObscure =
                (state as TextFieldVisibilityState).isTextVisible;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 12.0),
                  child: NewTextFieldWidget(
                    labelText: S.of(context).password,
                    controller: password,
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
                      if (value == null || passwordAgain.text.isEmpty) return;
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
                      context.read<ObscureBloc>().add(ToggleVisibilityEvent());
                    },
                  ),
                  onChanged: (value) {
                    if (value == null || password.text.isEmpty) return;
                    context.read<PasswordBloc>().add(MatchPassword(
                        confirmPassword: value, password: password.text));
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
            if (state is PasswordsMatch && !buttonActive) {
              context
                  .read<ButtonBloc>()
                  .add(const ToggleButton(isActive: true));
            } else if (state is PasswordsDoNotMatch && buttonActive) {
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
    );
  }

  Widget buildDataView(BuildContext context, TextEditingController name,
      TextEditingController surname, TextEditingController birthday) {
    checkButtonActive() {
      bool buttonActive = context.read<ButtonBloc>().state is ButtonActive;
      if (!buttonActive &&
          name.text.isNotEmpty &&
          surname.text.isNotEmpty &&
          birthday.text.isNotEmpty) {
        context.read<ButtonBloc>().add(const ToggleButton(isActive: true));
      } else if (buttonActive &&
          (name.text.isEmpty ||
              surname.text.isEmpty ||
              birthday.text.isEmpty)) {
        context.read<ButtonBloc>().add(const ToggleButton(isActive: false));
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        12.height,
        NewTextFieldWidget(
          readOnly: true,
          initialValue: AppUtils.phoneMaskFormatter.getMaskedText(),
          labelText: S.of(context).phoneNumber,
          inputFormatters: [AppUtils.phoneMaskFormatter],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: NewTextFieldWidget(
            labelText: S.of(context).name,
            controller: name,
            onChanged: (value) {
              checkButtonActive();
            },
          ),
        ),
        NewTextFieldWidget(
          labelText: S.of(context).surname,
          controller: surname,
          onChanged: (value) {
            checkButtonActive();
          },
        ),
        12.height,
        NewTextFieldWidget(
          labelText: S.of(context).birthday,
          controller: birthday,
          inputFormatters: [AppUtils.dateMaskFormatter],
          onChanged: (value) {
            checkButtonActive();
          },
        ),
      ],
    );
  }

  Widget buildCodeView(
      BuildContext context, SignUpState state, TextEditingController code) {
    context.read<TimerBloc>().add(StartTimer());
    return Column(
      children: [
        20.height,
        Text(
          S.of(context).signInText,
          style: AppTextStyle.bodyLarge,
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: PinCodeTextField(
            appContext: context,
            length: 6,
            animationType: AnimationType.fade,
            validator: (v) {
              if (state.status == SignUpStatus.errorVerify) {
                return S.of(context).notRightCode;
              } else {
                return null;
              }
            },
            errorTextMargin: const EdgeInsets.only(top: 50),
            errorTextSpace: 20,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.underline,
              fieldHeight: 50,
              fieldWidth: 40,
              activeColor: AppColors.main,
              selectedColor: AppColors.gray,
              inactiveColor: AppColors.gray,
            ),
            textStyle: AppTextStyle.headlineLarge
                .copyWith(color: AppColors.main, fontWeight: FontWeight.w400),
            cursorColor: AppColors.main,
            animationDuration: const Duration(milliseconds: 300),
            keyboardType: TextInputType.number,
            inputFormatters: [AppUtils.codeMaskFormatter],
            onChanged: (value) {
              code.text = value;
              bool buttonActive =
                  context.read<ButtonBloc>().state is ButtonActive;
              if (!buttonActive && value.length == 6) {
                context
                    .read<ButtonBloc>()
                    .add(const ToggleButton(isActive: true));
              } else if (buttonActive && value.length != 6) {
                context
                    .read<ButtonBloc>()
                    .add(const ToggleButton(isActive: false));
              }
            },
          ),
        ),
        BlocBuilder<TimerBloc, TimerState>(
          builder: (context, state) {
            if (state is TimerRunInProgress) {
              return Text(
                S.of(context).sentAgainSec(state.duration),
                style: AppTextStyle.displayLarge.copyWith(
                  color: AppColors.gray,
                ),
                textAlign: TextAlign.center,
              );
            } else if (state is TimerRunComplete) {
              return TextButton(
                onPressed: () {
                  context.read<SignUpCubit>().signUpOtp({
                    'username':
                        '7${AppUtils.phoneMaskFormatter.getUnmaskedText()}',
                  });
                  context.read<TimerBloc>().add(ResetTimer());
                },
                child: Text(
                  S.of(context).sentAgain,
                  style: AppTextStyle.displayLarge,
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ],
    );
  }

  Widget buildPhoneView(BuildContext context) {
    return Column(
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
          inputFormatters: [AppUtils.phoneMaskFormatter],
          onChanged: (value) {
            bool buttonActive =
                context.read<ButtonBloc>().state is ButtonActive;
            if (!buttonActive && value?.length == 18) {
              context
                  .read<ButtonBloc>()
                  .add(const ToggleButton(isActive: true));
            } else if (buttonActive && value?.length != 18) {
              context
                  .read<ButtonBloc>()
                  .add(const ToggleButton(isActive: false));
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            S.of(context).willSentCode,
            style: AppTextStyle.displayLarge.copyWith(
              color: AppColors.gray,
            ),
          ),
        ),
      ],
    );
  }

  int getIndexByStatus(SignUpStatus status) {
    switch (status) {
      case SignUpStatus.successOtp:
        return 1;
      case SignUpStatus.successVerify:
        return 2;
      case SignUpStatus.successData:
        return 3;
      default:
        return 0;
    }
  }
}
