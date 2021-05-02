import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

/// 画像をキャッシュしておくためのモデルクラス
///
class ImageCacheModel {
  /// Constructor(SingleTon)
  ImageCacheModel._();
  static ImageCacheModel _imageCacheModel;
  factory ImageCacheModel() {
    return _imageCacheModel ??= ImageCacheModel._();
  }

  /// Variable
  // ProfileViewの背景画像
  ImageProvider _cacheProfileBackGroundImage;

  /// Method
  // --[Begin]ProfileViewの背景画像--//
  // set method
  void setProfileBackGroundImageCache({String imageUrl}) {
    // 画像圧縮
    _imageCompression(imageUrl ?? 'assets/background_image.png').then((imageUint8List) {
      _cacheProfileBackGroundImage = MemoryImage(imageUint8List);
    });
    _cacheProfileBackGroundImage = AssetImage(imageUrl ?? 'assets/background_image.png');
  }
  // get method
  ImageProvider getCacheProfileBackGroundImage() {
    return _cacheProfileBackGroundImage;
  }
  // --[End]ProfileViewの背景画像--//

  // AssetImage画像圧縮メソッド
  Future<Uint8List> _imageCompression(String imageUrl) {
    Future<Uint8List> compressionResult = FlutterImageCompress.compressAssetImage(
      imageUrl,
      minWidth: 1080,
      minHeight: 1920,
      quality: 80,
    );
    return compressionResult;
  }

  // カメラ起動メソッド
  Future<PickedFile> cameraActivation() async {
    return await ImagePicker().getImage(source: ImageSource.camera);
  }

}