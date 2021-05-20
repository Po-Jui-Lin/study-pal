import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StaffTile extends StatelessWidget {
  final Staff staff;
  StaffTile({this.staff});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ExpansionTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage(staff.profilePic),
          ),
          title: Text(staff.name),
          // subtitle: Text(staff.phone + '\n' + staff.email),
          children: <Widget>[
            IntrinsicHeight(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextButton(
                      child: Text(
                        staff.email,
                        textAlign: TextAlign.center,
                      ),
                      onPressed: () async {
                        String _url = "mailto:" + staff.email;
                        await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
                      },
                    ),
                  ),
                  VerticalDivider(
                    color: Colors.grey,
                    thickness: 2,
                  ),
                  Expanded(
                    child: TextButton(
                      child: Text(
                        staff.phone,
                        textAlign: TextAlign.center,
                      ),
                      onPressed: () async {
                        String _url = "tel:" + staff.phone;
                        await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
                      },
                    ),
                  ),
                  user.uid != staff.firebaseId
                      ? VerticalDivider(
                          color: Colors.grey,
                          thickness: 2,
                        )
                      : SizedBox.shrink(),
                  user.uid != staff.firebaseId
                      ? IconButton(
                          icon: Icon(Icons.message_rounded),
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Chat(staff: staff))),
                        )
                      : SizedBox.shrink(),
                ],
              ),
            ),
          ],
          // trailing: user.uid != staff.firebaseId
          //     ? IconButton(
          //         icon: Icon(Icons.message_rounded),
          //         onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Chat(staff: staff))),
          //       )
          //     : SizedBox.shrink(),
        ),
      ),
    );
  }
}
