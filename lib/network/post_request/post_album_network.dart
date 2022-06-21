import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_api/enums.dart';
import 'package:rest_api/model/get_album_model.dart';
import 'package:rest_api/network/http_handler.dart';
import 'package:rest_api/provider/get_album_provider.dart';

import '../../model/post_album_model.dart';


class AlbumNetworkPost {
  Future<bool> postAlbum(BuildContext context,Posts posts) async {
    log("Requesting Album List...");
    String msgListUrl = "https://jsonplaceholder.typicode.com/posts";
    var albumListResponse = await HTTPHandler()
        .httpRequest(url: msgListUrl, method: RequestType.POST,body: posts.toJson());
    if (albumListResponse == false) {
      return false;
    } else {
      log("ALBUM LIST API RESPONSE SUCCESSFUL");
      var data = albumListResponse;
      var postAlbum =Posts.fromJson(albumListResponse);
      await GetAlbumProvider().updatePostInfo(postAlbum);

      return true;
    }
  }
}
