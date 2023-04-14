import 'package:flutter/material.dart';
import 'package:podcast/Modal/podcast_player.dart';
import 'package:podcast/Screen/user.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> _categories = [    'All',    'Business',    'Comedy',    'Education',    'Health & Fitness',    'News',    'Sports',    'Technology'  ];

  String _selectedCategory = 'All';
  int _selectedindex=0;





  @override
  Widget build(BuildContext context) {

    List <Widget> _pages= <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 5),
            child: SizedBox(
              height:50,
              child: Center(
                child: Text(
                  'Podcasts',
                  style: TextStyle(
                    color: Colors.white
                    ,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Categories',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            ),
          ),
          SizedBox(height: 16),
          Container(
            height: 48,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              itemBuilder: (BuildContext context, int index) {
                String category = _categories[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCategory = category;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color:
                      _selectedCategory == category ? Colors.blue : null,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        category,
                        style: TextStyle(
                          color: _selectedCategory == category
                              ? Colors.white
                              : Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'New Releases',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 15,),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: Image.network(
                      'https://picsum.photos/100/100?random=$index',
                      height: 64,
                      width: 64,
                      fit: BoxFit.cover,
                    ),
                    title: Text(
                      'Podcast Title',
                      style: TextStyle(
                        fontFamily: 'algerian',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70,
                      ),
                    ),
                    subtitle: Text(
                      'Podcast Host',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    trailing: Icon(
                      Icons.play_circle_fill,
                      color: Colors.blue,
                      size: 36,
                    ),
                    onTap: () => PodcastPlayer(podcastUrl: "https://www.jiosaavn.com/artist/himesh-reshammiya-songs/N,m6H0-rqiY_"),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      Icon(Icons.play_circle_outlined),
      UserPage(),
    ];
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.centerRight,
              colors: [Colors.deepPurple,Colors.purple,Colors.purpleAccent,Colors.deepPurpleAccent])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded),
                label: "Home",
                backgroundColor: Colors.black
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.stream),
                  label: "Play",
                backgroundColor: Colors.blue,
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle),
                  label: "Account",
                backgroundColor: Colors.purple,
              ),
            ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedindex,
          onTap: _onitemtapped,
        ),
        body: Center(
          child: _pages.elementAt(_selectedindex),
        ),
      ),
    );
  }

  void _onitemtapped(int index) {
    setState(() {
      _selectedindex=index;
    });
  }
}
