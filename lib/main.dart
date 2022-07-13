import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unsplash_images/ui/app/my_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  const app = MyApp();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky)
      .then((_) => runApp(app));
}
