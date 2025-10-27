import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:b2c_platform/src/common/enums.dart';
import 'package:b2c_platform/src/presentation/bloc/base_state.dart';

import '../../../bloc/loading_cubit.dart';

class PaymentModalView extends StatelessWidget {
  const PaymentModalView({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    debugPrint('Payment url: $url');
    InAppWebViewController? webViewController;
    return BlocBuilder<LoadingCubit, BaseState>(
      builder: (context, state) {
        return Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(16),
                topLeft: Radius.circular(16),
              ),
              child: PopScope(
                canPop: true,
                onPopInvoked: (didPop) async {
                  if (webViewController != null &&
                      await webViewController!.canGoBack()) {
                    webViewController!.goBack();
                  }
                },
                child: Scaffold(
                  body: InAppWebView(
                    initialUrlRequest: URLRequest(
                      url: WebUri.uri(Uri.parse(url)),
                    ),
                    onLoadStop: (controller, url) {
                      context.read<LoadingCubit>().setSuccess();
                    },
                    onLoadStart: (controller, url) {
                      print('url changed $url');
                    },
                    shouldOverrideUrlLoading:
                        (controller, navigationAction) async {
                      var uri = navigationAction.request.url;
                      if (uri.toString() == 'http://example.com/') {
                        Navigator.pop(context);
                        return NavigationActionPolicy.CANCEL;
                      } else {
                        return NavigationActionPolicy.ALLOW;
                      }
                    },
                    onWebViewCreated: (controller) {
                      webViewController = controller;
                    },
                  ),
                  // bottomNavigationBar: SafeArea(
                  //   child: CustomMainButton(
                  //     text: S.of(context).save,
                  //     onTap: () {},
                  //   ),
                  // ),
                ),
              ),
            ),
            if (state.status.isLoading)
              const Center(child: CircularProgressIndicator())
          ],
        );
      },
    );
  }
}
