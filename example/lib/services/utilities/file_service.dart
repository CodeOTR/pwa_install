import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileService {
  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  Future<String> getSavePath({bool video = false}) async {
    String extension;
    if (video) {
      extension = 'mp4';
    } else {
      extension = 'jpg';
    }

    var appDocDir = await getTemporaryDirectory();
    String savePath = appDocDir.path + '${timestamp()}_temp.$extension';
    String fixedSavePath = savePath.replaceAll(RegExp(r'\s+'), '');
    print('fixed: ' + fixedSavePath);

    return fixedSavePath;
  }

  /// Get ApplicationsDocumentsDirectory which can only be accessed by this app
  Future<Directory> getAppDirectory() async {
    return await getApplicationDocumentsDirectory();
  }

  /// Get TempDirectory which can only be accessed by this app but is cleared temporarily
  Future<Directory> getTempDirectory() async {
    return await getTemporaryDirectory();
  }

  /// One call to get a file reference, set temp = false to get ApplicationDocumentsDirectory
  /// extension should be 'mp4' for videos and 'jpg' for images
  /// Folders should be in this format: first/second/third/
  Future<File> getFile({bool temp = true, String? folders, String? fileName, required String extension}) async {
    Directory directory;

    if (temp) {
      directory = await getTempDirectory();
    } else {
      directory = await getAppDirectory();
    }

    return getFileFromDirectory(directory: directory, folders: folders, name: fileName, extension: extension);
  }

  /// Folders should be in this format: first/second/third/
  File getFileFromDirectory({required Directory directory, String? folders, String? name, String? extension}) {
    String? fileName = name;

    if (fileName == null) {
      fileName = '${timestamp()}_temp';
    }

    if (extension != null) {
      fileName = fileName + '.$extension';
    }

    if (folders != null) {
      fileName = folders + fileName;
    }

    String filePath = directory.path;
    return File('$filePath/$fileName');
  }

  /// Creates the given folders in the appDirectory
  /// Returns true if the folder exists or has been created, false if it failed
  ///
  /// Input is a list of strings  -> 'first/second/third/'
  Future<bool> createFolders(List<String> folders) async {
    // Get the appDirectory
    Directory appDirectory = await getAppDirectory();

    String folderPath = '';

    // Take the strings provided in the input and create a folder path out of them
    // Make sure to keep trailing /
    folders.forEach((folder) {
      folderPath = folderPath + '$folder/';
    });

    // Get the folder directory
    Directory newDirectory = Directory('${appDirectory.path}/$folderPath');

    // Check if it already exists
    if (await newDirectory.exists()) {
      print('directory already exists');
      return true;
    } else {
      print('directory does not exist');

      try {
        // Create the folders recursively if they don't exist
        await newDirectory.create(recursive: true);
        return true;
      } catch (e) {
        print('Error creating folder: ' + e.toString());
        return false;
      }
    }
  }
}
