class Podcast{
  final String title;
  final String description;
  final String url;
  final String imageurl;

  Podcast({required this.title, required this.description, required this.url, required this.imageurl});

  static List<Podcast> podcast=[
    Podcast(
        title: "First",
        description: "First description",
        url: "https://wynk.in/music/song/chaska-workout-remix/un_M09054518",
        imageurl: "assets/images/5.jpg",
    ),
    Podcast(
      title: "Second",
      description: "second description",
      url: "https://wynk.in/music/song/chaska-workout-remix/un_M09054518",
      imageurl: "assets/images/2.jpg",
    ),
  ];
}