// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String receiverId;
  final String message;
  final Timestamp timestamp;
  Message({
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
        "senderId": senderId,
        "receiverId": receiverId,
        "message": message,
        "timestamp": timestamp,
      };


  static Message fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Message(
      senderId: snapshot["senderId"],
      receiverId: snapshot["receiverId"],
      message: snapshot["message"],
      timestamp: snapshot["timestamp"],
    );
  }
}
