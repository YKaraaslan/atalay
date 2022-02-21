class Assets {
  static final String logo = _path('logo', 'png');
  static final String login_background = _path('login_background', 'svg');
}

String _path(String name, String type) {
  return 'assets/images/' + name + '.' + type;
}