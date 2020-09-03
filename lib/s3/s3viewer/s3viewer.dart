import 'dart:io';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:file_picker/file_picker.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_amplify_app/core/core.dart';
import 'package:flutter_amplify_app/s3/s3viewer/s3viewer.ui.dart';
import 'package:flutter_amplify_app/shared/toastr.dart';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';

class S3Viewer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new S3ViewerState(); // new can be omitted in dart...
  }
}

class S3ViewerState extends State<S3Viewer> {

  // Storage Item list
  List<StorageItem> items = [];

  // Check if the app is uploading something
  bool isUploading = false;

  // Check if a file is being removed
  bool isRemoving = false;

  // Check if a file is being downloaded
  bool isDownloading = false;

  // Check if the app is retrieving the list of files
  bool isListing = false;

  @override
  void initState() {
    // We have an initial state and we configure it
    super.initState();

    // List files before drawing
    listFiles();
  }

  Future<bool> checkPermission() async {
    final status = await Permission.storage.status;
    if (status != PermissionStatus.granted) {
      final result = await Permission.storage.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  void downloadFile(StorageItem item) async {
    try {
      setState(() {
        isDownloading = true;
      });

      var dir = await DownloadsPathProvider.downloadsDirectory;
      var url = await Amplify.Storage.getUrl(key: item.key, options: GetUrlOptions(expires: 3600));

      await checkPermission();

      final taskId = await FlutterDownloader.enqueue(
        url: url.url,
        fileName: item.key.split('/').last,
        savedDir: dir.path,
        showNotification: true, // show download progress in status bar (for Android)
        openFileFromNotification: true, // click on notification to open downloaded file (for Android)
      );

      setState(() {
        isDownloading = false;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void deleteFile(StorageItem item) async {
    try {
      setState(() {
        isRemoving = true;
      });

      RemoveResult res = await Amplify.Storage.remove(
        key: item.key,
      );

      // Refresh list of files in the personal bucket
      listFiles();

      // Tell that the file was removed
      toastr('File removed successfully from the bucket');
    } catch (e) {
      toastr('Error deleting the file:\n' + e.toString());
    }
  }

  void uploadFile() async {
    // We put this outside of try to avoid logging user cancel
    File file = await FilePicker.getFile();
    AuthUser user = await Core.getUser();

    try {
      if(file.existsSync()) {

        setState(() {
          isUploading = true;
        });

        final key = user.username + '/' + file.path.split('/').last;

        // Upload the file
        UploadFileResult result = await Amplify.Storage.uploadFile(
          key: key,
          local: file
        );

        // Refresh list of files in the personal bucket
        listFiles();
      }
    } catch(e) {
      toastr('Error uploading the file:\n' + e.toString());
    }
  }

  void listFiles() async {
    try {
      setState(() {
        isListing = true;
      });

      AuthUser user = await Core.getUser();
      ListResult res = await Amplify.Storage.list();

      // Change the status of the screen
      setState(() {
        items = res.items.where((e) => e.key.split('/').first.contains(user.username)).toList();
        isUploading = false;
        isRemoving = false;
        isListing = false;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return s3viewerUi(this);
  }

}