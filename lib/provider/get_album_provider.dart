import 'package:flutter/material.dart';
import 'package:rest_api/model/get_album_model.dart';
import 'package:rest_api/model/post_album_model.dart';
import 'package:rest_api/network/get_request/get_album_network.dart';
import 'package:rest_api/network/post_request/post_album_network.dart';

class GetAlbumProvider extends ChangeNotifier {
  static final GetAlbumProvider _selfInstance = GetAlbumProvider._internal();

  GetAlbumProvider._internal();

  factory GetAlbumProvider() => _selfInstance;

  List<Album> album = [];
  late Posts posts;
  bool isLoading = false;

  updateAlbumData(List<Album> album) {
    this.album = album;
    isLoading = false;
    notifyListeners();
  }
  updatePostInfo(Posts post) {
    this.posts = post;
    isLoading = false;
    notifyListeners();
  }

  Future<void> getAlbumData(BuildContext context) async {
    isLoading = true;
    await AlbumNetwork().getAlbum(context);
    notifyListeners();
  }
  Future<void> postAlbumData(BuildContext context, Posts posts) async {
    isLoading = true;
    await AlbumNetworkPost().postAlbum(context, posts);
    notifyListeners();
  }

List<Album> get getAlbum {
  return album;
}
}
