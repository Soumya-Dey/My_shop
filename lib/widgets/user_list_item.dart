import 'package:flutter/material.dart';

class UserListItem extends StatelessWidget {
  final String title;
  final String imageUrl;

  UserListItem({
    this.title,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.only(
        top: 16,
        right: 16,
        left: 16,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(
            imageUrl,
          ),
        ),
        title: Text(title),
        trailing: Container(
          width: 100,
          child: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
