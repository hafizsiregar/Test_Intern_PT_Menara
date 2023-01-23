import 'package:flutter/material.dart';
import 'package:get_api_list/models/user_model.dart';

class DetailPage extends StatelessWidget {
  final User user;
  const DetailPage({ Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(user.avatar)
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(user.firstName, style: TextStyle(fontSize: 20),),
            )
          ],
        ),
      ),
    );
  }
}