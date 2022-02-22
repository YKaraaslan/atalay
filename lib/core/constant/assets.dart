class Assets {
  static final String logo = _path('logo', 'png');
  static final String loginBackground = _path('login_background', 'jpg');
  static final String facebook = _path('facebook', 'png');
  static final String instagram = _path('instagram', 'png');
  static final String linkedin = _path('linkedin', 'png');
  static final String twitter = _path('twitter', 'png');
}

String _path(String name, String type) {
  return 'assets/images/' + name + '.' + type;
}