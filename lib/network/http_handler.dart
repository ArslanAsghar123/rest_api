import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:rest_api/toaster.dart';

import '../enums.dart';

String url = "";
String authToken = '';

class HTTPHandler {
  Future httpRequest(
      {required String url, var body, var headers, required RequestType method}) async {
    log("url :$url");
    log("body :${jsonEncode(body)}");

    http.Response? response;
    try {
      if (method == RequestType.GET) {
        response = await http.get(
          Uri.parse(url),
          headers: {
            'Content-type': 'application/json; charset=UTF-8',
          },
        );
      } else if (method == RequestType.POST) {
        response = await http.post(
          Uri.parse(url),
          body: jsonEncode(body),
          headers: {
            'Content-type': 'application/json; charset=UTF-8',
          },
        );
      } else if (method == RequestType.DELETE) {
        response = await http.delete(
          Uri.parse(url),
          body: jsonEncode(body),
          headers: {
            'Content-type': 'application/json; charset=UTF-8',
          },
        );
      }

      log("Here is the http response");
      log("Response : ${response!.body}");
      log("Status code : ${response.statusCode}");
      var jsonResponse = await json.decode(response.body);
      if (response.statusCode == 200) {
        return jsonResponse;
      } else {
        Toaster.showToast(
            jsonResponse['message'].toString(), ToastGravity.BOTTOM);
        log(response.statusCode.toString());
        return false;
      }
    } on SocketException catch (e) {
      log("In $method method exception");
      log(e.toString());
      // Toaster.showToast(
      //     "You are in offline mode, functionality is limited", ToastGravity.BOTTOM);

      // Toaster.showToast("exception");
      return false;
    } catch (e) {
      log("In $method method exception");
      log(e.toString());

      if (response!.statusCode == 401) {
        Toaster.showToast(
          "Invalid Auth Token\nTry Signing In Again",
          ToastGravity.BOTTOM,
        );
      } else if (response.statusCode == 500) {
        Toaster.showToast(
          "Internal Server Error",
          ToastGravity.BOTTOM,
        );
      } else {
        Toaster.showToast(e.toString(), ToastGravity.BOTTOM);
      }

      return false;
    }
  }
}
