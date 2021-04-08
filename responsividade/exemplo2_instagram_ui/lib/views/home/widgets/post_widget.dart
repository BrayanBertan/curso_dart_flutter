import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class PostWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDeskptop = ResponsiveWrapper.of(context).isDesktop;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: isDeskptop ? 20 : 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.all(14),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/perfil.jpg'),
                  backgroundColor: Colors.transparent,
                  radius: 18,
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                    child: Text(
                  'Brayan Bertan',
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.white),
                )),
                GestureDetector(
                  child: Icon(
                    Icons.more_horiz_sharp,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          Image.asset('assets/images/perfil.jpg'),
          Padding(
            padding: EdgeInsets.all(5),
            child: Row(
              children: [
                IconButton(
                    icon: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                    ),
                    onPressed: () {}),
                const SizedBox(
                  width: 4,
                ),
                IconButton(
                    icon: Icon(
                      Icons.messenger_outline,
                      color: Colors.white,
                    ),
                    onPressed: () {}),
                const SizedBox(
                  width: 4,
                ),
                IconButton(
                    icon: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                    onPressed: () {}),
                const SizedBox(
                  width: 4,
                ),
                Expanded(child: Container()),
                IconButton(
                    icon: Icon(
                      Icons.bookmark_border,
                      color: Colors.white,
                    ),
                    onPressed: () {}),
                const SizedBox(
                  width: 4,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Curtido por kyo e outras 500 pessoas',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  'HÁ 1 HORA',
                  style: TextStyle(fontSize: 10, color: Colors.white),
                ),
              ],
            ),
          ),
          if (isDeskptop) ...{
            Divider(
              color: Colors.white,
              height: 1,
            ),
            Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        isCollapsed: true,
                        hintText: 'Adicione um comentário...',
                        hintStyle:
                            TextStyle(fontSize: 12, color: Colors.white)),
                  ),
                )),
                TextButton(
                    style: TextButton.styleFrom(primary: Colors.blue),
                    onPressed: () {},
                    child: Text('Publicar'))
              ],
            )
          }
        ],
      ),
    );
  }
}
