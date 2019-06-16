class Avatar {
  final String url;

  Avatar({this.url});
}

class User {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String token;
  final Avatar avatar;

  User({this.id, this.email, this.firstName, this.lastName, this.token, this.avatar});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      token: json['token'],
      avatar: Avatar(url: json['avatar']['url'])
    );
  }
}
