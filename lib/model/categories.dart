import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Category{
  final int id;
  final String name;
  final String image;
  Category(this.id, this.name, {this.image});
}

final List<Category> categories = [
  Category(9,"General Knowledge", image: 'assets/topic/image2.jpg'),
  Category(10,"Books", image: 'assets/topic/image13.jpg'),
  Category(11,"Film",image: 'assets/topic/image5.jpg'),
  Category(12,"Music", image: 'assets/topic/image16.jpg'),
  Category(13,"Musicals & Theatres", image: 'assets/topic/image22.jpg'),
  Category(14,"Television", image: 'assets/topic/image14.jpg'),
  Category(15,"Video Games", image: 'assets/topic/image9.jpg'),
  Category(16,"Board Games", image: 'assets/topic/image18.jpg'),
  Category(17,"Science & Nature",image: 'assets/topic/image10.jpg'),
  Category(18,"Computer",image: 'assets/topic/image20.jpg'),
  Category(19,"Maths", image: 'assets/topic/image2.jpg'),
  Category(20,"Mythology",image: 'assets/topic/image12.jpg'),
  Category(21,"Sports", image: 'assets/topic/image15.jpg'),
  Category(22,"Geography",image: 'assets/topic/image3.jpg'),
  Category(23,"History", image: 'assets/topic/image11.jpg'),
  Category(24,"Politics",image: 'assets/topic/image7.jpg'),
  Category(25,"Art", image: 'assets/topic/image21.jpg'),
  Category(26,"Celebrities",image: 'assets/topic/image17.jpg'),
  Category(27,"Animals", image: 'assets/topic/image19.jpg'),
  Category(28,"Vehicles", image: 'assets/topic/image2.jpg'),
  Category(29,"Comics",image: 'assets/topic/image8.jpg'),
  Category(30,"Gadgets", image: 'assets/topic/image6.jpg'),
  Category(32,"Cartoon & Animation",image: 'assets/topic/image4.jpg'),
];