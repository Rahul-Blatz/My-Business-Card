import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get_it/get_it.dart';

void main() {
  setupLocator();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rahul\'s Card',
      home: Scaffold(
        body: MyCard(),
      ),
    ),
  );
}

class CallsAndMessagesService {
  void call(String number) => launch("tel:$number");
  void mail(String mail) => launch("mailto:$mail");
}

GetIt locator = GetIt();

void setupLocator() {
  locator.registerSingleton(CallsAndMessagesService());
}

class MyCard extends StatefulWidget {
  @override
  _MyCardState createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  final CallsAndMessagesService _service = locator<CallsAndMessagesService>();
  int bgColor = 0xff5baddd;

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Card buildCard(IconData icon, String data) {
    return Card(
      child: ListTile(
        title: Text(
          '$data',
          style: TextStyle(
            fontSize: 20,
            color: Color(bgColor),
            fontFamily: 'Bangers',
          ),
        ),
        leading: Icon(
          icon,
          color: Color(bgColor),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[
          SizedBox.expand(
            child: FittedBox(
              child: Image.asset(
                'images/BG.jpg',
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: const AssetImage('images/avatar.jpeg'),
                  ),
                  width: 100.0,
                  height: 100.0,
                  padding: const EdgeInsets.all(2.0), // border width
                  decoration: new BoxDecoration(
                    color: const Color(0xFFFFFFFF), // border color
                    shape: BoxShape.circle,
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Rahul Babu',
                  style: TextStyle(
                    fontSize: 42,
                    fontFamily: 'Bangers',
                  ),
                ),
              ),
              Text(
                'FLUTTER DEV',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black45,
                  fontFamily: 'Bangers',
                ),
              ),
              SizedBox(
                width: 100,
                child: Divider(
                  thickness: 1.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () => _service.call('8667342705'),
                  child: buildCard(
                    Icons.call,
                    '+91 8667342705',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () => _service.mail(
                    'rahulblatz002@gmail.com',
                  ),
                  child: buildCard(
                    Icons.mail,
                    'rahulblatz002@gmail.com',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () =>
                      _launchInBrowser('https://github.com/Rahul-Blatz'),
                  child: buildCard(
                    CommunityMaterialIcons.github_circle,
                    'github-rahul-blatz',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
