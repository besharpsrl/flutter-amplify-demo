import 'package:flutter/material.dart';
import 'package:flutter_amplify_app/core/core.dart';
import 'package:flutter_amplify_app/core/ui-builder.dart';

import 's3viewer.dart';

UiBuilder<S3ViewerState> s3viewerUi = (state) => Container(
    child: Stack(
        children: <Widget>[
          Visibility(
            visible: !state.isListing,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder (
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.only(top: 5, bottom: 70),
                      itemCount: state.items.length,
                      itemBuilder: (BuildContext context, int Index) {
                        return Card(
                            color: Colors.deepPurple,
                            child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                    children: <Widget>[
                                      Core.typeOfImage(state.items[Index].key.split('/').last),
                                      Expanded(
                                        child: Text(
                                            state.items[Index].key.split('/').last,
                                            style: TextStyle(fontSize: 20,
                                                color: Colors.white),
                                            overflow: TextOverflow.ellipsis
                                        ),
                                      ),
                                      GestureDetector(
                                          onTap: () => { if(!state.isRemoving && !state.isDownloading) state.downloadFile(state.items[Index]) },
                                          child: CircleAvatar(
                                            child: Icon(state.isDownloading ? Icons.hourglass_empty : Icons.download_outlined, color: Colors.white),
                                            backgroundColor: state.isDownloading ? Colors.grey : Colors.blue,
                                          )
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: GestureDetector(
                                          onTap: () => { if(!state.isRemoving && !state.isDownloading) state.deleteFile(state.items[Index]) },
                                          child: CircleAvatar(
                                            child: Icon(state.isRemoving ? Icons.hourglass_empty : Icons.delete, color: Colors.white),
                                            backgroundColor: state.isRemoving ? Colors.grey :  Colors.red,
                                          )
                                        ),
                                      )
                                    ]
                                )
                            )
                        );
                      }
                  )
                )
              ]
            )
          ),
          Visibility(
            visible: state.isListing,
            child: Align(
              child: Column (
                children: <Widget>[
                  Expanded(
                    child: Column (
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CircularProgressIndicator(),
                        Text('Listing process, please wait...', style: TextStyle(color: Colors.white, fontSize: 20),)
                      ]
                    )
                  )
                ]
              ),
              alignment: FractionalOffset.center,
            )
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton.extended(
              onPressed: () { if(!state.isUploading) state.uploadFile(); },
              label: Text(state.isUploading ? 'Uploading...' : 'Upload a file'),
              icon: Icon(state.isUploading ? Icons.hourglass_empty : Icons.upload_file, color: Colors.white,),
              foregroundColor: Colors.white,
              backgroundColor: state.isUploading ? Colors.amber : Colors.blue
            )
          ),
        ]
    )
);