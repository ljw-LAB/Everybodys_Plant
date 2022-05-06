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
        // title: const Text(
        //   '식물을 검색해주세요',
        //   style: TextStyle(color: Colors.grey, fontSize: 16),
        // ),
        // actions: [
        //   IconButton(
        //     icon: const Icon(
        //       Icons.search,
        //       color: Colors.grey,
        //     ),
        //     onPressed: () {
        //       showSearch(
        //         context: context,
        //         delegate: MySearchDelegate(),
        //       );
        //     },
        //   ),
        // ],
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
                      'assets/scindapsus.png',
                      fit: BoxFit.fitWidth,
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.all(6),
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: Text('쉬움',
                              style:
                                  TextStyle(color: Colors.green, fontSize: 13)),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.green),
                              borderRadius: BorderRadius.circular(6)),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text('scindapsus',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Text(
                        ' 온후한 지역의 실내 장식용 식물로 잘 알려져 있으며,\n 자주 관리하지 않아도 되어, 처음 식물을 길러보시는 분들에게\n 가장 추천드리는 친구입니다',
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
                                  plantname: 'scindapsus',
                                ),
                              ),
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
                      'assets/anthurium.png',
                      fit: BoxFit.fitWidth,
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.all(6),
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: Text('보통',
                              style:
                                  TextStyle(color: Colors.amber, fontSize: 13)),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.amber),
                              borderRadius: BorderRadius.circular(6)),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text('anthurium',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Text(
                        ' 공기정화 능력이 높은 실내 장식용 식물로서,\n 암모니아 및 일산화탄소를 잘 제거할 수 있어요. \n 밝고 습한 환경을 좋아하며 꽃이 이쁜 친구입니다',
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
                                      RegisterPage(plantname: 'anthurium'),
                                ));
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
                      'assets/arecapalm.png',
                      fit: BoxFit.fitWidth,
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.all(6),
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: Text('어려움',
                              style:
                                  TextStyle(color: Colors.red, fontSize: 13)),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.red),
                              borderRadius: BorderRadius.circular(6)),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text('arecapalm',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Text(
                        ' 아프리카 마다가스카르섬의 열대기후 식물로서,\n 잎의 줄기가 길고 크며 검은 반점이 있어요. \n 최고의 공기정화식물 중 하나인 친구입니다.',
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
                                          plantname: 'arecapalm',
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
    'scindapsus',
    'anthurium',
    'arecapalm',
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
