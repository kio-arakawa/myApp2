import 'package:flutter/material.dart';
import 'package:my_first_app/dimens/dimens_base.dart';

class DimensDiary extends DimensBase {

  static DimensDiary _instance;
  static DimensDiary get instance => _instance;
  DimensDiary._();
  factory DimensDiary() {
    _instance ??= DimensDiary._();
    return _instance;
  }

  ///Variable
  //スクロール可能領域のmargin
  double diaryListTopMargin = 0;
  double diaryListBottomMargin = 0;
  //入力テキストボックスと記録ボタンのContainerの高さ
  double inputTextBoxAndRegisterButtonContainerHeight = 0;
  //入力テキストボックスのサイズとmargin
  double inputTextBoxHeight = 0;
  double inputTextBoxWidth = 0;
  double inputTextBoxMarginLeft = 0;
  double inputTextBoxMarginRight = 0;
  //入力テキストボックスのテキストサイズ
  double inputTextBoxTextSize = 0;
  //入力テキストボックスの行数
  int oldLines = 0;
  //記録ボタンのサイズとmargin
  double registerButtonHeight = 0;
  double registerButtonWidth = 0;
  double registerButtonMarginTop = 0;
  //登録テキストのContainerのmargin/BorderRadius
  double registerTextContainerForeMargin= 0;
  double registerTextContainerBackMargin = 0;
  double registerTextContainerMarginBottom = 0;
  double registerTextContainerBorderRadius = 0;
  //登録テキストのContainerのpadding
  double registerTextContainerPaddingHorizontal = 0;
  double registerTextContainerPaddingVertical = 0;
  //登録テキストフォントサイズ
  double registerTextFontSize = 1;
  //登録ボタンフォントサイズ
  double registerButtonTextSize = 0;
  //登録テキストの吹き出しContainerのサイズとmargin
  double registerTextBubbleHeight = 0;
  double registerTextBubbleWidth = 0;
  double registerTextBubbleMarginTop = 0;
  double registerTextBubbleMarginHorizontal = 0;

  @override
  void calculatorRatio<DiaryView>() {
    inputTextBoxAndRegisterButtonContainerHeight = viewBaseHeight * 0.1;
    inputTextBoxTextSize = inputTextBoxAndRegisterButtonContainerHeight * 0.35;
    diaryListBottomMargin = inputTextBoxAndRegisterButtonContainerHeight;
    diaryListTopMargin = viewBaseHeight * 0.01;
    inputTextBoxHeight = inputTextBoxAndRegisterButtonContainerHeight;
    inputTextBoxWidth = viewBaseWidth * 0.7;
    inputTextBoxMarginLeft = viewBaseWidth * 0.04;
    inputTextBoxMarginRight = inputTextBoxMarginLeft;
    registerButtonHeight = inputTextBoxAndRegisterButtonContainerHeight * 0.55;
    registerButtonWidth = viewBaseWidth * 0.2;
    registerButtonMarginTop = (inputTextBoxAndRegisterButtonContainerHeight - registerButtonHeight) / 2.0;
    registerTextContainerForeMargin = viewBaseWidth * 0.2;
    registerTextContainerBackMargin = viewBaseWidth * 0.05;
    registerTextContainerMarginBottom = viewBaseHeight * 0.01;
    registerTextContainerBorderRadius = viewBaseWidth * 0.03;
    registerTextContainerPaddingHorizontal = viewBaseWidth * 0.03;
    registerTextContainerPaddingVertical = viewBaseHeight * 0.01;
    registerTextFontSize = viewBaseWidth * 0.04;
    registerButtonTextSize = inputTextBoxAndRegisterButtonContainerHeight * 0.3;
    registerTextBubbleHeight = registerTextFontSize;
    registerTextBubbleWidth = viewBaseWidth * 0.05;
    registerTextBubbleMarginTop = 0;
    registerTextBubbleMarginHorizontal = registerTextContainerBackMargin - (viewBaseWidth * 0.01);
  }

  void textFormSizeChange(int newLines) {
    if(oldLines != newLines) {
      oldLines = newLines;
      switch(newLines) {
        case 1:
          inputTextBoxAndRegisterButtonContainerHeight = viewBaseHeight * 0.1;
          break;
        case 2:
          inputTextBoxAndRegisterButtonContainerHeight = (viewBaseHeight * 0.1) + inputTextBoxTextSize;
          break;
        case 3:
          inputTextBoxAndRegisterButtonContainerHeight = (viewBaseHeight * 0.1) + (inputTextBoxTextSize * 2);
          break;
        default:
          inputTextBoxAndRegisterButtonContainerHeight = (viewBaseHeight * 0.1) + (inputTextBoxTextSize * 2);
          break;
      }
      inputTextBoxHeight = inputTextBoxAndRegisterButtonContainerHeight;
      registerButtonMarginTop = (inputTextBoxAndRegisterButtonContainerHeight - registerButtonHeight) / 2.0;
      debugPrint('テキストフォームの行数:$newLines行');
      notifyListeners();
    }
  }

}