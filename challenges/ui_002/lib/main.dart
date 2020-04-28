import 'package:flutter/material.dart';
import 'package:ui_002/fade_in_animation.dart';

void main() => runApp(
      MaterialApp(
        home: HomePage(),
      ),
    );

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final pageController = PageController(initialPage: 2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: <Widget>[
          Page(
            page: 1,
            title: 'Veniam ipsum eu do sint incididunt',
            description:
                'Irure voluptate quis qui non. Proident eiusmod eiusmod do qui. Fugiat reprehenderit ullamco veniam officia magna exercitation ex aliquip. Excepteur eu eu commodo cillum. Tempor ut adipisicing ullamco velit. Nostrud ullamco reprehenderit nulla laborum. Duis exercitation commodo voluptate officia cillum aliqua culpa enim consequat.',
            imagePath: 'assets/one.jpg',
          ),
          Page(
            page: 2,
            title: 'Deserunt in nostrud',
            description:
                'Exercitation eiusmod est cupidatat officia do sit nostrud fugiat labore elit incididunt aliquip amet. Ex ullamco dolor ipsum mollit. Laboris eiusmod officia esse excepteur ullamco do officia cupidatat dolore ex.',
            imagePath: 'assets/two.jpg',
          ),
          Page(
            page: 3,
            title: 'Occaecat do adipisicing laborum',
            description:
                'Culpa enim sunt minim cillum id anim consequat. Ea eu ex in voluptate proident quis do labore elit do eiusmod ea. Proident voluptate tempor culpa veniam ipsum incididunt minim voluptate voluptate occaecat consequat ipsum.',
            imagePath: 'assets/three.jpg',
          ),
          Page(
            page: 4,
            title: 'Aliqua nulla consectetur irure ullamco enim sunt.',
            description:
                'Irure occaecat anim exercitation amet aliqua ad. Irure esse reprehenderit dolor dolore Lorem exercitation nostrud proident ea ut. Enim dolore do adipisicing incididunt consequat et mollit voluptate ut. Ut pariatur ad consequat et sunt laboris proident sunt laboris culpa.',
            imagePath: 'assets/four.jpg',
          ),
        ],
      ),
    );
  }
}

class Page extends StatelessWidget {
  final page;
  final title;
  final description;
  final imagePath;

  Page({this.page, this.title, this.description, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black.withOpacity(0.8),
              Colors.black.withOpacity(0.0)
            ],
            begin: Alignment.bottomRight,
            end: Alignment.topRight,
            stops: [0.1, 0.6],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Stack(
            children: <Widget>[
              Positioned(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      Text(
                        page.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '/4',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeInAnimation(
                    delay: 0.0,
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  FadeInAnimation(
                    delay: 0.3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                            Icons.star,
                            Icons.star,
                            Icons.star,
                            Icons.star,
                            Icons.star_half,
                          ]
                              .map<Widget>(
                                (el) => Icon(
                                  el,
                                  color: Colors.yellow,
                                  size: 15.0,
                                ),
                              )
                              .toList() +
                          <Widget>[
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '4.5 (566)',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  FadeInAnimation(
                    delay: 0.6,
                    child: Text(
                      description,
                      style: TextStyle(
                        fontSize: 17,
                        height: 1.4,
                        color: Colors.grey[300],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  FadeInAnimation(
                    delay: 0.9,
                    child: Text(
                      'READ MORE',
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
