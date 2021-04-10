class Constants {
  Constants._();
  static Constants _instance;
  factory Constants() {
    return _instance ??= Constants._();
  }
  //ViewTitle
  static final String homeViewTitle = 'Home';
  static final String diaryViewTitle = 'Diary';
  static final String historyViewTitle = 'History';
  static final String settingViewTitle = 'Setting';
  // Navigator Hero Animation Tag
  static final String profileHeroAnimTag = 'profileHeroAnimation';
}