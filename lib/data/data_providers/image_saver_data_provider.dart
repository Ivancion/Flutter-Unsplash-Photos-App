import 'package:dio/dio.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

class ImageSaverDataProvider {
  Future<void> saveImage(String url) async {
    final tempDir = await getTemporaryDirectory();
    final path = '${tempDir.path}/${DateTime.now()}.jpg';
    await Dio().download(url, path);
    await GallerySaver.saveImage(path);
  }
}
