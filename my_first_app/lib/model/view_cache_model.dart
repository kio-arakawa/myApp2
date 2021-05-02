import 'package:flutter/material.dart';
import 'package:my_first_app/view/profile_view.dart';

class ViewCacheModel {
  /// Constructor(SingleTon)
  ViewCacheModel._();
  static ViewCacheModel _viewCacheModel;
  factory ViewCacheModel() {
    return _viewCacheModel ??= ViewCacheModel._();
  }

  /// ProfileView
  Widget _profileView;
  // set
  void setProfileViewInstance() {
    _profileView ??= ProfileView();
  }
  // get
  Widget getProfileViewInstance() {
    return _profileView ??= ProfileView();
  }
  // cache clear
  void cacheClearProfileViewInstance() {
    _profileView = null;
  }

}