class User {
  final String username;
  final String uid;
  final String email;
  final String password;
  final String bio;
  final List followers;
  final List following;
  final String photoUrl;

  User(
      {required this.username,
      required this.uid,
      required this.email,
      required this.password,
      required this.bio,
      required this.followers,
      required this.following,
      required this.photoUrl});

  Map<String, dynamic> toJson() => {
        'username': username,
        'uid': uid,
        'email': email,
        'password': password,
        'bio': bio,
        'followers': [],
        'following': [],
        'photoUrl': photoUrl,
      };
}
