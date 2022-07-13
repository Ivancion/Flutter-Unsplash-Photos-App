import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unsplash_images/ui/screens/auth_screen/auth_screen_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final model = context.read<AuthModel>();
    return Scaffold(
      body: WebView(
        onWebResourceError: (error) => model.validateWebView(error, context),
        onWebViewCreated: (controller) {
          controller.loadUrl('https://unsplash.com/logout');
          Future.delayed(const Duration(milliseconds: 400), () {
            controller.loadUrl(model.authorizeString);
          });
        },
        javascriptMode: JavascriptMode.unrestricted,
        navigationDelegate: (navReq) =>
            model.handleNavigationActions(navReq, context),
      ),
    );
  }
}
