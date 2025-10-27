import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:b2c_platform/src/common/app_styles/app_theme.dart';
import 'package:b2c_platform/src/common/utils/locale/locale.dart';
import 'package:b2c_platform/src/common/presentation/bloc/button_bloc.dart';
import 'package:b2c_platform/src/common/presentation/bloc/navigation_cubit.dart';
import 'package:b2c_platform/src/common/presentation/bloc/obscure_bloc.dart';
import 'package:b2c_platform/src/features/auth/presentation/bloc/sign_in/sign_in_cubit.dart';
import 'package:b2c_platform/src/features/auth/presentation/bloc/sign_up/sign_up_cubit.dart';
import 'package:b2c_platform/src/features/categories/presentation/pages/bloc/category_items_cubit.dart';
import 'package:b2c_platform/src/features/home/presentation/pages/bloc/category_cubit.dart';
import 'package:b2c_platform/src/features/home/presentation/pages/bloc/city_bloc/city_cubit.dart';
import 'package:b2c_platform/src/features/home/presentation/pages/bloc/items_cubit.dart';
import 'package:b2c_platform/src/features/user/presentation/pages/profile/bloc/delete_me_cubit.dart';
import 'package:b2c_platform/src/features/user/presentation/pages/profile/bloc/user_info_cubit.dart';

import 'common/utils/app_router/app_router.dart';
import 'common/utils/l10n/generated/l10n.dart';
import 'get_it_sl.dart';

class Application extends StatelessWidget {
  Application({super.key});

  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //   const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    // );

    return MultiBlocProvider(
      providers: [
        BlocProvider<SignInCubit>(
          create: (_) => sl<SignInCubit>(),
        ),
        BlocProvider<ItemsCubit>(
          create: (_) => sl<ItemsCubit>(),
        ),
        BlocProvider<UserInfoCubit>(
          create: (_) => sl<UserInfoCubit>(),
        ),
        BlocProvider<CityCubit>(
          create: (_) => sl<CityCubit>()..fetchCityList(),
        ),
        BlocProvider<CategoryCubit>(
          create: (_) => sl<CategoryCubit>()..fetchCategories(),
        ),
        BlocProvider<CategoryItemsCubit>(
          create: (_) => sl<CategoryItemsCubit>(),
        ),
        BlocProvider<DeleteMeCubit>(
          create: (_) => sl<DeleteMeCubit>(),
        ),
        BlocProvider<SignUpCubit>(
          create: (_) => sl<SignUpCubit>(),
        ),
        BlocProvider(
          create: (_) => ObscureBloc(),
        ),
        BlocProvider(
          create: (_) => NavigationCubit(),
        ),
        BlocProvider(
          create: (_) => ButtonBloc(),
        ),
      ],
      child: ScreenUtilInit(
        useInheritedMediaQuery: true,
        builder: (context, child) => LocaleBuilder(builder: (context, locale) {
          return MaterialApp.router(
            routerConfig: appRouter.config(),
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            locale: locale,
            supportedLocales: S.delegate.supportedLocales,
            theme: AppTheme.lightTheme,
          );
        }),
      ),
    );
  }
}
