class AuthorizationModel {
  String name;
  int index;

  AuthorizationModel({
    required this.name,
    required this.index,
  });

  AuthorizationModel.fromJson(Map<String, Object?> json)
      : this(
          name: json['name']! as String,
          index: json['index']! as int,
        );

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'index': index,
    };
  }
}
