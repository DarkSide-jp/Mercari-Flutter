import 'package:flutter/material.dart';
import 'package:infinite_scroll_tab_view/infinite_scroll_tab_view.dart';
import 'package:intl/intl.dart';
import 'package:mercari/constants.dart';

void main() {
  runApp(Mercari());
}

class Mercari extends StatelessWidget {
  final tabs = ['おすすめ', 'ショップ', 'ピックアップ', 'マイリスト'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(),
        bottomNavigationBar: _buildBottomNavigationBar(),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return InfiniteScrollTabView(
      tabHeight: 40,
      contentLength: 4,
      tabBuilder: (index, isSelected) => Text(
        tabs[index],
        style: TextStyle(
          color: isSelected ? Colors.red : Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
      ),
      separator: BorderSide(color: Colors.white, width: 3.5),
      indicatorColor: Colors.red,
      pageBuilder: (_, index, __) {
        if (index == 0) {
          return RecommendPage();
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black,
      selectedLabelStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
      unselectedLabelStyle:
          TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'ホーム'),
        BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined), label: 'お知らせ'),
        BottomNavigationBarItem(
            icon: Icon(Icons.photo_camera_outlined), label: '出品'),
        BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_outlined), label: 'メルペイ'),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), label: 'マイページ'),
      ],
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: Colors.grey,
                    size: 20,
                  ),
                  SizedBox(width: 5),
                  Text(
                    'なにをお探しですか？',
                    style: TextStyle(color: Colors.grey, fontSize: 14.5),
                  )
                ],
              ),
            ),
          ),
          SizedBox(width: 15),
          Icon(
            Icons.done_outline_sharp,
            color: Colors.black,
            size: 25,
          )
        ],
      ),
    );
  }
}

class RecommendPage extends StatelessWidget {
  final formatter = NumberFormat('#,###');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: ListView(
        children: [
          Row(
            children: [
              SizedBox(width: 10),
              Text(
                'おすすめの商品',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 10),
          GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: 21,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
            ),
            itemBuilder: (_, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      'assets/images/image${index + 1}.jpg',
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Container(
                        color: Colors.black.withOpacity(0.5),
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          '¥${formatter.format(prices[index])}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
