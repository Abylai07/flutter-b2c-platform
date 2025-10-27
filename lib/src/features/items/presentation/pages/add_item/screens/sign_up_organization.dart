import 'package:auto_route/auto_route.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:b2c_platform/src/common/utils/app_router/app_router.dart';
import 'package:b2c_platform/src/features/auth/presentation/sign_up/bloc/sign_up_state.dart';

import '../../../../common/app_styles/assets.dart';
import '../../../../common/app_styles/colors.dart';
import '../../../../common/app_styles/text_styles.dart';
import '../../../../common/utils/l10n/generated/l10n.dart';
import '../../../../common/utils/parsers/date_parser.dart';
import '../../../../get_it_sl.dart';
import '../../../bloc/button_bloc/button_bloc.dart';
import '../../../bloc/navigation_cubit.dart';
import '../../../widgets/buttons/main_button.dart';
import '../../../widgets/containers/border_container.dart';
import '../../../widgets/expandable_theme.dart';
import '../../../widgets/show_error_snackbar.dart';
import '../../../widgets/text_fields/custom_text_field.dart';
import '../../authorization/sign_up/bloc/sign_up_cubit.dart';
import '../../profile/bloc/user_info_cubit.dart';
import '../bloc/user_type/user_type_bloc.dart';

class SignUpOrganization extends StatelessWidget {
  const SignUpOrganization({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignUpCubit>(
          create: (_) => sl<SignUpCubit>(),
        ),
        BlocProvider(
          create: (_) => UserTypeBloc(),
        ),
      ],
      child: const OrganizationView(),
    );
  }
}

class OrganizationView extends StatelessWidget {
  const OrganizationView({super.key});

  @override
  Widget build(BuildContext context) {
    ExpandableController expandableController = ExpandableController();
    TextEditingController email = TextEditingController();
    TextEditingController companyName = TextEditingController();
    TextEditingController bin = TextEditingController();
    TextEditingController bik = TextEditingController();
    TextEditingController iban = TextEditingController();

    List<String> userTypes = [
      S.of(context).simplePerson,
      S.of(context).ipPerson,
      S.of(context).tooPerson
    ];

    checkButtonActive(bool isSimplePerson) {
      bool buttonActive = context.read<ButtonBloc>().state is ButtonActive;
      if (!buttonActive &&
          email.text.isNotEmpty &&
          iban.text.isNotEmpty &&
          bik.text.isNotEmpty &&
          bin.text.isNotEmpty &&
          (isSimplePerson || companyName.text.isNotEmpty)) {
        context.read<ButtonBloc>().add(const ToggleButton(isActive: true));
      } else if (buttonActive &&
          (email.text.isEmpty ||
              iban.text.isEmpty ||
              bik.text.isEmpty ||
              bin.text.isEmpty ||
              (!isSimplePerson && companyName.text.isEmpty))) {
        context.read<ButtonBloc>().add(const ToggleButton(isActive: false));
      }
    }

    String getOrganizationType(String type) {
      Map userType = {
        userTypes[0]: 'individual',
        userTypes[1]: 'ip',
        userTypes[2]: 'too',
      };
      return userType[type];
    }

    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status == SignUpStatus.successData) {
         Navigator.pop(context);
         context.read<UserInfoCubit>().fetchUserInfo();
        } else if(state.status == SignUpStatus.errorData){
          showErrorSnackBar(context, S.of(context).somethingWrong);
        }
      },
      builder: (context, state) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(16),
            topLeft: Radius.circular(16),
          ),
          child: Scaffold(
            backgroundColor: AppColors.white,
            appBar: AppBar(
              title: Text(
                S.of(context).singUp,
                style: AppTextStyle.appBarStyle,
              ),
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  onPressed: () {
                      context.router.maybePop();
                      context.read<NavigationCubit>().navigateTo(0);
                  },
                  icon: SvgPicture.asset(AppAssets.cancel),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0, top: 8),
                      child: Text(
                        S.of(context).signInRental,
                        style: AppTextStyle.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    BlocBuilder<UserTypeBloc, UserTypeState>(
                      builder: (context, state) {
                        String selectedType = userTypes[0];
                        if (state is UserTypeSelected) {
                          selectedType = state.userType;
                        }
                        bool isSimpleUser = selectedType == userTypes[0];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            BorderContainer(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              child: ExpandablePanel(
                                controller: expandableController,
                                theme: buildExpandableThemeData(),
                                header: Text(
                                  selectedType,
                                  style: AppTextStyle.labelLarge.copyWith(
                                    color: AppColors.black,
                                  ),
                                ),
                                collapsed: const SizedBox(),
                                expanded: ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: userTypes.length,
                                    itemBuilder: (context, i) {
                                      return userTypes[i] != selectedType
                                          ? InkWell(
                                              onTap: () {
                                                checkButtonActive(isSimpleUser);
                                                context.read<UserTypeBloc>().add(
                                                    SelectUserType(userTypes[i]));
                                                expandableController.toggle();
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 16.0, bottom: 8),
                                                child: Text(
                                                  userTypes[i],
                                                  style: AppTextStyle.labelLarge
                                                      .copyWith(
                                                    color: AppColors.black,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : const SizedBox();
                                    }),
                              ),
                            ),
                            if (!isSimpleUser)
                              Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: NewTextFieldWidget(
                                  labelText: S.of(context).companyName,
                                  controller: companyName,
                                  onChanged: (value) {
                                    checkButtonActive(isSimpleUser);
                                  },
                                ),
                              ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12.0),
                              child: NewTextFieldWidget(
                                labelText: S.of(context).bin,
                                controller: bin,
                                onChanged: (value) {
                                  checkButtonActive(isSimpleUser);
                                },
                              ),
                            ),
                            NewTextFieldWidget(
                              labelText: S.of(context).iban,
                              controller: iban,
                              onChanged: (value) {
                                checkButtonActive(isSimpleUser);
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12.0),
                              child: NewTextFieldWidget(
                                labelText: S.of(context).bik,
                                controller: bik,
                                onChanged: (value) {
                                  checkButtonActive(isSimpleUser);
                                },
                              ),
                            ),
                            NewTextFieldWidget(
                              labelText: S.of(context).email,
                              controller: email,
                              inputFormatters: [AppUtils.textMaskFormatter],
                              onChanged: (value) {
                                checkButtonActive(isSimpleUser);
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                    right: 16,
                    left: 16,
                    bottom: MediaQuery.of(context).viewInsets.bottom + 16),
                child: BlocBuilder<ButtonBloc, ButtonState>(
                  builder: (context, buttonState) {
                    return CustomMainButton(
                      text: S.of(context).next,
                      isLoading: state.status == SignUpStatus.loading,
                      isActive: buttonState is ButtonActive,
                      onTap: () {
                        if (buttonState is ButtonActive) {
                          String organizationType = 'individual';
                          final userState = context.read<UserTypeBloc>().state;
                          if (userState is UserTypeSelected) {
                            organizationType =
                                getOrganizationType(userState.userType);
                          }

                          Map<String, dynamic> data = {
                            'email': email.text,
                            'company_name': companyName.text,
                            'bik': bik.text,
                            'iin': bin.text,
                            'iban': iban.text,
                            'organization_type': organizationType,
                          };
                          data.removeWhere((key, value) =>
                              key == 'company_name' &&
                              organizationType == 'individual');
                          context.read<SignUpCubit>().signUpData(data);
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
