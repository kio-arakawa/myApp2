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
  //記録ボタンのサイズとmargin
  double registerButtonHeight = 0;
  double registerButtonWidth = 0;
  double registerButtonMarginTop = 0;
  double registerButtonMarginRight = 0;
  //登録テキストのContainerのmargin/BorderRadius
  double registerTextContainerForeMargin= 0;
  double registerTextContainerBackMargin = 0;
  double registerTextContainerMarginBottom = 0;
  double registerTextContainerBorderRadius = 0;
  //登録テキストのContainerのpadding
  double registerTextContainerPaddingHorizontal = 0;
  double registerTextContainerPaddingVertical = 0;
  //登録テキストフォントサイズ
  double registerTextFontSize = 0;
  //登録ボタンフォントサイズ
  double registerButtonTextSize = 0;
  //登録テキストの吹き出しContainerのサイズとmargin
  double registerTextBubbleHeight = 0;
  double registerTextBubbleWidth = 0;
  double registerTextBubbleMarginTop = 0;
  double registerTextBubbleMarginHorizontal = 0;

  @override
  void calculatorRatio<DiaryView>() {
    inputTextBoxAndRegisterButtonContainerHeight = viewBaseHeight * 0.08;
    diaryListBottomMargin = inputTextBoxAndRegisterButtonContainerHeight;
    diaryListTopMargin = viewBaseHeight * 0.005;
    inputTextBoxHeight = inputTextBoxAndRegisterButtonContainerHeight;
    inputTextBoxWidth = viewBaseWidth * 0.65;
    inputTextBoxMarginLeft = viewBaseWidth * 0.07;
    registerButtonHeight = viewBaseHeight * 0.04;
    registerButtonWidth = viewBaseWidth * 0.2;
    registerButtonMarginTop = viewBaseHeight * 0.02;
    registerButtonMarginRight = viewBaseWidth * 0.04;
    registerTextContainerForeMargin = viewBaseWidth * 0.2;
    registerTextContainerBackMargin = viewBaseWidth * 0.05;
    registerTextContainerMarginBottom = viewBaseHeight * 0.01;
    registerTextContainerBorderRadius = viewBaseWidth * 0.03;
    registerTextContainerPaddingHorizontal = viewBaseWidth * 0.03;
    registerTextContainerPaddingVertical = viewBaseHeight * 0.01;
    registerTextFontSize = viewBaseWidth * 0.04;
    registerButtonTextSize = viewBaseWidth * 0.04;
    registerTextBubbleHeight = registerTextFontSize;
    registerTextBubbleWidth = viewBaseWidth * 0.05;
    registerTextBubbleMarginTop = 0;
    registerTextBubbleMarginHorizontal = registerTextContainerBackMargin - (viewBaseWidth * 0.01);
  }

}