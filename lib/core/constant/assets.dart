class Assets {
  static final String logo = _path('logo', 'png');
  static final String loginBackground = _path('login_background', 'jpg');
  static final String facebook = _path('facebook', 'png');
  static final String instagram = _path('instagram', 'png');
  static final String linkedin = _path('linkedin', 'png');
  static final String twitter = _path('twitter', 'png');
  static final String drawerMenuBackground = _path('drawer_menu_background', 'jpg');
  static final String menu = _path('ic_menu', 'svg');
  static final String notification = _path('ic_notification', 'svg');
  static final String megaphone = _path('ic_megaphone', 'png');

  
  static final String dashboard = _path('ic_dashboard', 'png');
  static final String projects = _path('ic_projects', 'png');
  static final String meetups = _path('ic_meetups', 'png');
  static final String groups = _path('ic_groups', 'png');
  static final String references = _path('ic_references', 'png');
  static final String finance = _path('ic_finance', 'png');
  static final String profile = _path('ic_profile', 'png');
  static final String calendar = _path('ic_calendar', 'png');
}

String _path(String name, String type) {
  return 'assets/images/' + name + '.' + type;
}