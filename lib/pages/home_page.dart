import 'package:flutter/material.dart';
import 'package:giphy_finder/pages/gif_page.dart';
import 'package:giphy_finder/request/search_request.dart';
import 'package:giphy_finder/request/trend_request.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? text;
  int offset = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Image.network(
              'https://developers.giphy.com/branch/master/static/header-logo-0fec0225d189bc0eae27dac3e3770582.gif'),
          centerTitle: true,
        ),
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Pesquise um GIF',
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
                onSubmitted: (text) {
                  setState(() {
                    this.text = text;
                    offset = 0;
                  });
                },
              ),
              Expanded(
                child: FutureBuilder(
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Container(
                          width: 200,
                          height: 200,
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.red),
                            strokeWidth: 5,
                          ),
                        );
                      case ConnectionState.none:
                        return Container(
                          width: 200,
                          height: 200,
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                            strokeWidth: 5,
                          ),
                        );
                      default:
                        if (snapshot.hasError) {
                          return Container();
                        } else {
                          return createGifTable(context, snapshot);
                        }
                    }
                  },
                  future: text == null || text!.isEmpty
                      ? TrendRequest(offset.toString()).trendGifs()
                      : SearchRequest(text!, offset.toString()).searchGifs(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int _getGridItemCount(List list) {
    if (text == null) {
      return list.length;
    } else {
      return list.length + 1;
    }
  }

  Widget createGifTable(BuildContext context, AsyncSnapshot snapshot) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: _getGridItemCount(snapshot.data['data']),
      itemBuilder: (context, index) {
        if (text == null || index < snapshot.data['data'].length) {
          return GestureDetector(
            child: Image.network(
              snapshot.data['data'][index]['images']['fixed_height']['url'],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return GifPage(snapshot.data['data'][index]);
                }),
              );
            },
          );
        } else {
          return GestureDetector(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 50,
                  ),
                  onPressed: () {
                    setState(() {
                      offset += 25;
                    });
                  },
                ),
                const Text(
                  'Mais GIFs...',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
