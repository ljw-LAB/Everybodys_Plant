import 'package:everybodys_plant/register/register_page.dart';
import 'package:flutter/material.dart';

class PlantList extends StatefulWidget {
  PlantList({Key? key}) : super(key: key);

  @override
  State<PlantList> createState() => _PlantListState();
}

class _PlantListState extends State<PlantList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: BackButton(color: Colors.grey),
        backgroundColor: Colors.white,
        title: const Text(
          '식물을 검색해주세요',
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.grey,
            ),
            onPressed: () {
              showSearch(
                context: context,
                delegate: MySearchDelegate(),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Image.asset(
                      'assets/스킨답서스.png',
                      fit: BoxFit.fitWidth,
                    ),
                    Text('스킨답서스',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(
                        '타고난 생명력과 관상용으로 인기가 높은 식물로,\n 식물을 처음 길러보신다면, 가장 추천드리는 친구입니다',
                        style: TextStyle(color: Color(0xff6B7583))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        TextButton(
                          child: const Text('선택하기'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage(
                                        plantname: '스킨답서스',
                                      )),
                            );
                          },
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Image.asset(
                      'assets/안시리움핑크.png',
                      fit: BoxFit.fitWidth,
                    ),
                    Text('안시리움핑크',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(
                        '타고난 생명력과 관상용으로 인기가 높은 식물로,\n 식물을 처음 길러보신다면, 가장 추천드리는 친구입니다',
                        style: TextStyle(color: Color(0xff6B7583))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        TextButton(
                          child: const Text('선택하기'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      RegisterPage(plantname: '안시리움핑크')),
                            );
                          },
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Image.asset(
                      'assets/이레카야자.png',
                      fit: BoxFit.fitWidth,
                    ),
                    Text('이레카야자',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(
                        '타고난 생명력과 관상용으로 인기가 높은 식물로,\n 식물을 처음 길러보신다면, 가장 추천드리는 친구입니다',
                        style: TextStyle(color: Color(0xff6B7583))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        TextButton(
                          child: const Text('선택하기'),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterPage(
                                          plantname: '이레카자야',
                                        )));
                          },
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 검색기능구현 관련
class MySearchDelegate extends SearchDelegate {
  List<String> searchResults = [
    '스킨답서스',
    '산세베리아',
    '유칼립투스 실버드롭',
    '몬스테라 델리시오사',
    '뱅갈고무나무'
  ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.grey),
        onPressed: () => close(context, null), // close search bar
      );

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (query.isEmpty) {
              close(context, null); // close searchbar
            } else {
              query = '';
            }
          },
        ),
      ];

  @override
  Widget buildResults(BuildContext context) => Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.album),
              title: Text(query),
              subtitle: Text('한줄 설명'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('선택하기'),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      );

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = searchResults.where((searchResult) {
      final result = searchResult.toLowerCase();
      final input = query.toLowerCase();

      return result.contains(input);
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];

        return ListTile(
          title: Text(suggestion),
          onTap: () {
            query = suggestion;

            showResults(context);
          },
        );
      },
    );
  }
}
