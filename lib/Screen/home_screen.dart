import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:podcast/Modal/Podcastmodelarray.dart';
import 'package:podcast/Modal/UserModel.dart';
import 'package:podcast/Modal/podcast_modal.dart';
import 'package:podcast/Screen/create_podcast.dart';
import 'package:podcast/Screen/playing_screen.dart';
import 'package:podcast/Screen/user.dart';

class HomeScreen extends StatefulWidget {
  final UserModel? usermod;
  final String? userid;
  const HomeScreen({super.key, this.usermod, this.userid});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List _categories = [    'All',    'Business',    'Comedy',    'Education',    'Health & Fitness',    'News',    'Sports',    'Technology'  ];

  // Podcast podcasts=Podcast.podcast[0];
  String? _selectedCategory = 'All';
  bool havedata=false;
  int _selectedindex=0;

  List<Podcast>? _showselectedCategory;

  List<Podcast>? pdata;



  @override
  void initState(){
    super.initState();
    getdata();

  }

  getdata()async{

    _showselectedCategory=  await PodModArr().getArrayOf(null);
    // _showselectedCategory=null;
    pdata=_showselectedCategory;

    if(_showselectedCategory!=null){
      setState(() {
        havedata=true;
      });
    }



  }

  getselecteddata(selectedcategory) async{

    _showselectedCategory=<Podcast>[];
    pdata!.forEach((pod){
      if(pod.genre==selectedcategory){
        _showselectedCategory?.add(pod);
      }
    });

    setState(() {

    });

  }

  show(){
    return havedata?ListView.builder(
      itemCount: _showselectedCategory!.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          // child: ListTile(
          //   leading: Image.network(
          //     'https://picsum.photos/100/100?random=$index',
          //     height: 100,
          //     width: 100,
          //     fit: BoxFit.cover,
          //   ),
          //   title: Text(
          //     'Podcast Title',
          //     style: TextStyle(
          //       fontFamily: 'algerian',
          //       fontSize: 18,
          //       fontWeight: FontWeight.bold,
          //       color: Colors.white70,
          //     ),
          //   ),
          //   subtitle: Text(
          //     'Podcast Host',
          //     style: TextStyle(
          //       fontSize: 16,
          //       fontWeight: FontWeight.normal,
          //     ),
          //   ),
          //   trailing: Icon(
          //     Icons.play_circle_fill,
          //     color: Colors.blue,
          //     size: 36,
          //   ),
          // ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white10,
              ),

              child: Row(
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    child: ClipRRect(
                      child: Image(
                        image: NetworkImage(
                            (_showselectedCategory![index].imageURL).toString()+"=$index"
                        ),
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 8, 8, 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              (_showselectedCategory![index].title).toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              (_showselectedCategory![index].description).toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15
                              ),
                              softWrap: true,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              (_showselectedCategory![index].genre).toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10
                              ),
                            ),
                          ],
                        ),
                      )
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      child: InkWell(
                        child: Icon(Icons.play_circle,size: 40,color: Colors.blue,),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PlayScreen(pod: _showselectedCategory,index: index,)));
                        },
                      ),
                    ),
                  )

                ],
              ),
            ),
          ),
        );
      },
    ):Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,));
  }


  @override
  Widget build(BuildContext context) {

    // List<Podcast> _showselectedCategory=  PodModArr().getArrayOf(null);

    List <Widget> _pages= <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 30, 10, 5),
            child: SizedBox(
              height:50,
              child: Center(
                child: Text(
                  'Podcasts',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          const Padding(
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
                    _selectedCategory = category;
                    if(_selectedCategory==_categories[0]){
                      _showselectedCategory=pdata;
                    }
                    else if(_selectedCategory!=null){
                      getselecteddata(_selectedCategory);
                    }
                    setState(() {
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
                              ? Colors.white54
                              : Colors.white,
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
          Expanded(
            child: RefreshIndicator(
              onRefresh: () {
                return Future.delayed(
                  Duration(seconds: 1),
                    (){
                    setState(() {

                    });
                    }
                );
              },
              child: show(),
            ),
          ),
        ],
      ),
      // Icon(Icons.play_circle_outlined),
      PlayScreen(index: 0,pod: pdata,),
      UserPage(usermod: widget.usermod,),
    ];
    return  Scaffold(
        backgroundColor: Colors.black,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          elevation: 5.0,
          backgroundColor: Colors.blue,
          onPressed: (){
            setState(() {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>create(userid: widget.userid,)));
            });
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded),
                label: "Home",
                backgroundColor: Colors.black54,
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.stream),
                  label: "Play",
                backgroundColor: Colors.deepPurple,
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
      );
  }

  void _onitemtapped(int index) {
    setState(() {
      _selectedindex=index;
    });
  }
}
