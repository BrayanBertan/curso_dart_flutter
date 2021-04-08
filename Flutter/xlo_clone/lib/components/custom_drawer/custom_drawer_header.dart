import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_clone/stores/page_store.dart';
import 'package:xlo_clone/stores/user_manager_store.dart';
import 'package:xlo_clone/views/login/login_view.dart';

class CustomDrawerHeader extends StatelessWidget {
  final UserManagerStore user = GetIt.I<UserManagerStore>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        user.isLoggedIn
            ? GetIt.I<PageStore>().setPage(4)
            : Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        padding: EdgeInsets.all(15.0),
        color: Colors.purple.shade500,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.person,
              color: Colors.white,
              size: 35.0,
            ),
            Expanded(
                child: !user.isLoggedIn
                    ? Column(
                        children: [
                          Text(
                            'Acesse a sua conta agora',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),
                          ),
                          Text('Clique aqui',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                              )),
                        ],
                      )
                    : Wrap(
                        crossAxisAlignment: WrapCrossAlignment.start,
                        children: [
                          Text(
                            '${user.user.name}',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            '${user.user.email}',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ))
          ],
        ),
      ),
    );
  }
}
