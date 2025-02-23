import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/ultis/colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool isShowUsers = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: TextFormField(
          controller: _searchController,
          decoration: const InputDecoration(labelText: 'Search for an user'),
          onFieldSubmitted: (String _) {
            print(_);
            setState(() {
              isShowUsers = true;
            });
          },
        ),
      ),
      body: isShowUsers ? FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('users')
            .where('username', isGreaterThanOrEqualTo: _searchController.text)
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: const CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: (snapshot.data! as dynamic).docs.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    (snapshot.data! as dynamic).docs[index]['photoUrl'],
                  ),
                ),
                title: Text(
                  (snapshot.data! as dynamic).docs[index]['username'],
                ),
              );
            },
          );
        },
      ) : Text('Posts'),
    );
  }
}
