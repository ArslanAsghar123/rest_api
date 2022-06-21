import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_api/enums.dart';
import 'package:rest_api/model/get_album_model.dart';
import 'package:rest_api/network/http_handler.dart';
import 'package:rest_api/provider/get_album_provider.dart';


class AlbumNetwork {
  Future<bool> getAlbum(BuildContext context) async {
    log("Requesting Album List...");
    String msgListUrl = "https://jsonplaceholder.typicode.com/albums";
    var albumListResponse = await HTTPHandler()
        .httpRequest(url: msgListUrl, method: RequestType.GET);
    if (albumListResponse == false) {
      return false;
    } else {
      log("ALBUM LIST API RESPONSE SUCCESSFUL");
      var data = albumListResponse;
      List<Album> albumList = List<Album>.from(
          data.map((model) => Album.fromJson(model)));
      await GetAlbumProvider().updateAlbumData(albumList);

      return true;
    }
  }
}
