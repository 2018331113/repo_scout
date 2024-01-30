class Owner {
  final String login;
  final String avatarUrl;

  Owner({required this.login, required this.avatarUrl});

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      login: json['login'],
      avatarUrl: json['avatar_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'avatar_url': avatarUrl,
    };
  }
}
