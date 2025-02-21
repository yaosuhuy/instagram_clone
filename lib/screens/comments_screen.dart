import 'package:flutter/material.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/resources/firestore_methods.dart';
import 'package:instagram_clone/ultis/ultis.dart';
import 'package:instagram_clone/widgets/comment_card.dart';
import 'package:instagram_clone/ultis/colors.dart';
import 'package:provider/provider.dart';
import 'package:instagram_clone/models/user.dart';

class CommentsScreen extends StatefulWidget {
  final snap;
  final postId;
  const CommentsScreen({super.key, this.snap, this.postId});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final TextEditingController _commentController = TextEditingController();

  // void postComment(String uid, String name, String profilePic)async{
  //   try {
  //     String res = await FirestoreMethods().postComment(widget.postId, _commentController.text, uid, name, profilePic);
  //     print(res);
  //     res = 'success';
  //   } catch (e){
  //     showSnackBar(e.toString(), context);
  //   }
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _commentController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text('Comments'),
        centerTitle: false,
      ),
      body: CommentCard(),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                  user.photoUrl,
                ),
                radius: 18,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 8),
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: 'Comment as ${user.username}',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  await FirestoreMethods().postComment(
                    widget.snap['postId'].toString(),
                    _commentController.text,
                    user.uid,
                    user.username,
                    user.photoUrl,
                  );
                },
                // onTap: () => postComment(user.uid, user.username, user.photoUrl),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  child: const Text(
                    'Post',
                    style: TextStyle(
                        color: blueColor, fontWeight: FontWeight.w800),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
