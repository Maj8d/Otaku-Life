import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Us"),
      ),
      backgroundColor: Colors.black,
      body:const SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
            '''
              Welcome to our Otaku Life app, where your passion for anime meets unlimited entertainment! We are dedicated to providing you with a one-of-a-kind anime streaming experience, bringing you the best of Japanese animation right at your fingertips.

Our Mission
Our mission is to connect anime enthusiasts from all around the world and create a vibrant community of passionate fans. We strive to be the ultimate destination for anime lovers, offering a vast library of anime titles across various genres and providing a seamless streaming experience.

Our Features
- Extensive Anime Library: Explore a diverse collection of anime series and movies, ranging from timeless classics to the latest releases. Discover hidden gems and immerse yourself in captivating stories that will leave you wanting more.
- Personalized Recommendations: Our intelligent recommendation system analyzes your viewing history and preferences to suggest anime titles tailored to your taste. Never miss out on your next favorite series again!
- Simulcast Streaming: Stay up-to-date with the latest episodes as we offer simulcast streaming, bringing you the newest anime releases shortly after they air in Japan. Be among the first to experience the excitement!
- Multi-Device Support: Enjoy your favorite anime on any device of your choice. Whether you prefer watching on your phone, tablet, or TV, our app ensures a seamless and optimized viewing experience across platforms.

Join Our Community
We invite you to be part of our passionate anime community. Connect with fellow fans, engage in discussions, share your thoughts, and participate in events and contests. Together, let's celebrate the artistry and creativity of anime.

Contact Us
Your feedback and suggestions are invaluable to us. If you have any questions, comments, or need assistance, please reach out to our friendly support team. We're here to make your anime journey extraordinary.

Thank you for choosing our anime app!
              ''',
            style: TextStyle(fontSize: 16.0,color: Colors.white),
          ),
        ),
      ),
      )
    );
  }
}
