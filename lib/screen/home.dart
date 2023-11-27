import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const StoryArea(),
          FeedList(),
        ],
      ),
    );
  }
}

class StoryArea extends StatelessWidget {
  const StoryArea({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(10, (index) => UserStory(userName: 'User ${index+1}', userImage: 'assets/images/IMG_8986.jpeg',)),
      ),
    );
  }
}

class UserStory extends StatelessWidget {
  final String userName;
  final String userImage;

  const UserStory({
    required this.userName,
    required this.userImage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8.0),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(userImage)),
                borderRadius: BorderRadius.circular(1000)),
          ),
          Text(userName),
        ],
      ),
    );
  }
}

///피드 관련 데이터 : 사용자 이름, 좋아요, 컨텐츠(댓글), 이미지
class FeedData {
  final String userName;
  final int likeCount;
  final String content;
  final String image;

  FeedData(
      {required this.userName, required this.likeCount, required this.content, required this.image});
}

/// 피드 리스트 선언
final feedDataList = [
  FeedData(userName: 'User1', likeCount: 50, content: '나만의 앱을 만들어 봐야지! 할 수있다!! 한번 해보즈아아아아아아', image: 'IMG_8899.jpeg'),
  FeedData(userName: 'User2', likeCount: 42, content: '오늘 아침은 맛있었다', image: 'IMG_6651.jpeg'),
  FeedData(userName: 'User3', likeCount: 1, content: '오늘 저녁은 맛있었다', image: 'IMG_8523.jpeg'),
  FeedData(userName: 'User4', likeCount: 91, content: '어제 점심은 맛있었다', image: 'IMG_8572.jpeg'),
  FeedData(userName: 'User5', likeCount: 100, content: '어제 저녁은 맛있었다', image: 'IMG_8672.jpeg'),
  FeedData(userName: 'User6', likeCount: 32, content: '어제 아침은 맛있었다', image: 'IMG_8676.jpeg'),
  FeedData(userName: 'User7', likeCount: 1, content: '내일 맛있을껄?', image: 'IMG_9110.JPG'),
  FeedData(userName: 'Use8', likeCount: 1246, content: '끝!', image: 'IMG_9111.JPG'),
];

///피드 아이템에 피드 데이터 넘기기(리스트 개수만큼...)
class FeedList extends StatelessWidget {
  const FeedList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        // 피드의 스크롤을 무한으로 주는 코드...
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        ///////////////////////////////////////
        itemCount: feedDataList.length,
        itemBuilder: (context, index) =>
            FeedItem(feedData: feedDataList[index]));
  }
}

/// 피드 화면 구성
class FeedItem extends StatelessWidget {
  final FeedData feedData;

  const FeedItem({required this.feedData, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue.shade300,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(feedData.userName),
                ],
              ),
              Icon(Icons.more_vert),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          width: double.infinity,
          height: 280,
          // 피드 이미지
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/${feedData.image}')),

          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {}, icon: Icon(Icons.favorite_outline)),
                  IconButton(
                      onPressed: () {}, icon: Icon(CupertinoIcons.chat_bubble)),
                  IconButton(
                      onPressed: () {}, icon: Icon(CupertinoIcons.paperplane)),
                ],
              ),
              IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.bookmark)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            '좋아요 ${feedData.likeCount}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical:4, horizontal: 24),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black),
              children: [
                TextSpan(
                    text: feedData.userName,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: feedData.content),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
