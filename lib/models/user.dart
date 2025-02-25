import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String username;
  final String uid;
  final String photoUrl;
  final String email;
  final String password;
  final String bio;
  final List followers;
  final List following;

  User({
    required this.username,
    required this.uid,
    required this.photoUrl,
    required this.email,
    required this.password,
    required this.bio,
    required this.followers,
    required this.following,
  });

  // convert an object 'User' to a map, so we can store it in Firestore
  Map<String, dynamic> toJson() => {
        'username': username,
        'uid': uid,
        'email': email,
        'password': password,
        'bio': bio,
        'followers': [],
        'following': [],
      };

  // convert a DocumentSnapshot that received from firebase to an object "User"
  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      username: snapshot['username'],
      uid: snapshot['uid'],
      photoUrl: snapshot["photoUrl"],
      email: snapshot['email'],
      password: snapshot['password'],
      bio: snapshot['bio'],
      followers: snapshot['followers'],
      following: snapshot['following'],
    );
  }
}
