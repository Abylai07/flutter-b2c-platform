import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:b2c_platform/src/presentation/widgets/main_functions.dart';

import '../../../../common/app_styles/colors.dart';
import '../../../../common/app_styles/text_styles.dart';
import '../../../../common/utils/l10n/generated/l10n.dart';
import '../widgets/profile_tile_widget.dart';

@RoutePage()
class AppSettingScreen extends StatelessWidget {
  const AppSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          S.of(context).appSettings,
          style: AppTextStyle.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 6,
                    offset: const Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  ProfileTileWidget(
                    description: S.of(context).termsUse,
                    onTap: () {
                      launchUrlFunc('https://b2c_platform.kz/terms-conditions');
                    },
                  ),
                  const Divider(
                    height: 42,
                    color: AppColors.divider,
                  ),
                  ProfileTileWidget(
                    description: S.of(context).addItemRule,
                    onTap: () {
                      launchUrlFunc('https://b2c_platform.kz/privacy-policy');
                    },
                  ),
                  const Divider(
                    height: 42,
                    color: AppColors.divider,
                  ),
                  ProfileTileWidget(
                    description: S.of(context).support,
                    onTap: () {
                      launchUrlFunc('mailto:support@b2c_platform.kz');
                    },
                  ),
                  const Divider(
                    height: 42,
                    color: AppColors.divider,
                  ),
                  ProfileTileWidget(
                    description: S.of(context).rateApp,
                    onTap: () async {
                      final InAppReview inAppReview = InAppReview.instance;

                      if (await inAppReview.isAvailable()) {
                        inAppReview.requestReview();
                      }
                    },
                  ),
                ],
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: FutureBuilder<PackageInfo>(
                    future: PackageInfo.fromPlatform(),
                    builder: (ctx, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.done:
                          return Text(
                            S.of(context).version(snapshot.data?.version ?? '1.0.1'),
                            style: AppTextStyle.labelLarge.copyWith(
                              color: AppColors.gray2,
                            ),
                          );
                        default:
                          return const SizedBox();
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
