import 'package:flutter/material.dart';
import 'package:ui_003/widgets/video_player.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            brightness: Brightness.light,
            floating: false,
            expandedHeight: 250.0,
            backgroundColor: Colors.black,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Incididunt enim culpa'),
              background: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/four.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black, Colors.transparent],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topLeft,
                      stops: [0.1, 0.6],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              makeHeaderParagraph(
                title: 'Mollit ut irure elit incididunt id esse.',
                body:
                    'Proident aute amet cillum ut nulla non nostrud magna. Esse elit nulla velit sunt id consectetur laboris. Nulla eu elit nisi esse officia aute sunt reprehenderit incididunt aliqua commodo exercitation anim aliquip. Ex exercitation in cupidatat anim occaecat sit eu anim officia incididunt consectetur. Sint irure ut aliqua eu Lorem ad aliquip laboris sint voluptate duis id do. Laboris velit ad enim id ut reprehenderit culpa duis laborum in minim elit.',
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 300,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children:
                      ['assets/one.png', 'assets/two.png', 'assets/three.png']
                          .map(
                            (el) => Container(
                              margin: EdgeInsets.all(10.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: Image.asset(el),
                              ),
                            ),
                          )
                          .toList(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              makeHeaderParagraph(
                title: 'Excepteur reprehenderit amet nulla.',
                body:
                    'Elit officia nostrud fugiat consequat tempor occaecat sint et magna. Irure duis ad qui et fugiat exercitation excepteur et pariatur fugiat nulla voluptate do. Adipisicing ea nostrud consectetur labore sit. Eiusmod pariatur ut pariatur nulla voluptate elit Lorem minim commodo nulla dolor. Labore est adipisicing velit excepteur dolor Lorem. Laboris proident dolore anim nulla ad tempor exercitation cupidatat nulla sit dolore ut excepteur. Cupidatat consectetur ullamco incididunt ipsum incididunt consequat ad sint nulla.',
              ),
              SizedBox(
                height: 10,
              ),
              VideoPlayer(),
              SizedBox(
                height: 10,
              ),
              makeHeaderParagraph(
                title: 'Elit tempor magna',
                body:
                    'Lorem anim velit culpa aute aliqua exercitation reprehenderit nostrud eiusmod et dolor ullamco non fugiat. Mollit duis eu proident laboris sit Lorem enim sunt minim. Et ipsum veniam irure reprehenderit non. Ipsum nostrud aute proident amet. Pariatur tempor deserunt veniam ex consequat. Elit ipsum elit minim ea labore velit et.',
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget makeHeaderParagraph({title, body}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            body,
            style: TextStyle(
              color: Colors.white,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
