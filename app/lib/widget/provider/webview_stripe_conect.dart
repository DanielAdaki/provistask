import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class InAppWebViewWidget extends StatelessWidget {
  final String initialUrl;
  final String urlReturn;
  final String pageCallback;

  const InAppWebViewWidget(
      {Key? key,
      required this.initialUrl,
      required this.urlReturn,
      required this.pageCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InAppWebViewControllerWrapper>(
      init: InAppWebViewControllerWrapper(),
      builder: (controllerWrapper) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xff170591),
            title: const Text(
              "Stripe acount connect",
            ),
          ),
          body: InAppWebView(
            initialUrlRequest: URLRequest(url: Uri.parse(initialUrl)),
            onWebViewCreated: (controller) {
              controllerWrapper.setController(controller);
            },
            onLoadStart: (controller, url) async {
              // si url contiene return-app.html lo mando a Get.back
              if (url.toString().contains("connect.stripe.com/setup/e") ||
                  url
                      .toString()
                      .contains("/users-permissions/strapi/account/reauth")) {
                if (kDebugMode) {
                  print(
                      "La URL contiene el string 'connect.stripe.com/setup/e'");
                }
              } else {
                Get.offNamed(pageCallback);
              }
            },
            onLoadStop: (controller, url) {
              if (url.toString().contains("connect.stripe.com/setup/e") ||
                  url
                      .toString()
                      .contains("/users-permissions/strapi/account/reauth")) {
                print("La URL contiene el string 'connect.stripe.com/setup/e'");
              } else {
                Get.offNamed(pageCallback);
              }
            },
            onProgressChanged: (controller, progress) {},
          ),
        );
      },
    );
  }
}

class InAppWebViewControllerWrapper extends GetxController {
  InAppWebViewController? _webViewController;

  void setController(InAppWebViewController controller) {
    _webViewController = controller;
  }

  InAppWebViewController? get webViewController => _webViewController;
}
