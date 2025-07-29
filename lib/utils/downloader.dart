import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

Future<void> downloadImage(String imageUrl) async {
  // 1. Request Storage Permission
  var status = await Permission.storage.request();
  if (status.isDenied) {
    Fluttertoast.showToast(
      msg: "Storage permission denied. Cannot download image.",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
    );
    return;
  }
  if (status.isPermanentlyDenied) {
    Fluttertoast.showToast(
      msg:
          "Storage permission permanently denied. Please enable from settings.",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
    );
    openAppSettings(); // Opens app settings for user to enable permission
    return;
  }

  try {
    // 2. Get the Downloads directory
    final Directory downloadsDirectory = Directory(
      '/storage/emulated/0/Download',
    ); // await getDownloadsDirectory();

    // 3. Create the Tmcars subfolder
    final Directory tmcarsFolder = Directory(
      '${downloadsDirectory.path}/Tmcars',
    );
    if (!await tmcarsFolder.exists()) {
      await tmcarsFolder.create(recursive: true);
    }

    // 4. Extract file name from URL
    final String fileName = imageUrl.split('/').last.split('?').first;
    final String filePath = '${tmcarsFolder.path}/$fileName';

    // 5. Download the image data
    final response = await http.get(Uri.parse(imageUrl));

    if (response.statusCode == 200) {
      // 6. Write the image data to the file
      final File file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);

      Fluttertoast.showToast(
        msg: "Image downloaded!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    } else {
      throw Exception(
        'Failed to download image. Status: ${response.statusCode}',
      );
    }
  } catch (e) {
    Fluttertoast.showToast(
      msg: "An error occurred during download: $e",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
    );
  }
}
