class Constants {

  /// Singleton
  Constants._();
  static Constants _instance;
  factory Constants() {
    return _instance ??= Constants._();
  }

  /// Variable (used by sync data)
  //ViewTitle
  static final String homeViewTitle = 'Home';
  static final String diaryViewTitle = 'Diary';
  static final String historyViewTitle = 'History';
  static final String settingViewTitle = 'Setting';
  // Navigator Hero Animation Tag
  static final String profileHeroAnimTag = 'profileHeroAnimation';
  // CircleProgressIndicator BuildWaitTime
  static final int circleProgressIndicatorBuildWaitTime = 1000;

  /// Variable (used by SharedPref)
  // Key: UserNam
  static final String userName = 'user_name';
  // Key: UserName// Key: UserPass
  static final String userPass = 'user_pass';
  // Key: ProfileName
  static final String profileUserName = 'profile_user_name';
  // Key: DarkModeFlagName
  static final String darkModeFlagName = 'dark_mode_flag';
}