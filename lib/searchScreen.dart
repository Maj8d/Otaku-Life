import 'dart:io';

import 'package:flutter/material.dart';

import 'Models/AnimeModel.dart';
import 'Repository/anime_repository.dart';
import 'animeDetails_page.dart';
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool _showSearchField = false;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  String _searchTerm = '';
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _toggleSearchField();
    });
  }

  void _toggleSearchField() {
    setState(() {
      _showSearchField = !_showSearchField;
      if (_showSearchField) {
        _searchFocusNode.requestFocus();
      } else {
        _searchFocusNode.unfocus();
        _searchController.clear();
      }
    });
  }

  void _performSearch() {
    String searchTerm = _searchController.text;
    print('Search term: $searchTerm');
    // Perform search action with the search term
    // ...
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _showSearchField
            ? TextField(
          style: const TextStyle(color: Colors.white),
          controller: _searchController,
          focusNode: _searchFocusNode,
          cursorColor: Colors.white,
          decoration: const InputDecoration(
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.white),
            border: InputBorder.none,
          ),
          onChanged: (value) {
            setState(() {
              _searchTerm = value;
            });
            _performSearch();
          },
        )
            : null,
        actions: [
          IconButton(
            icon: Icon(_showSearchField ? Icons.close : Icons.search),
            onPressed: _toggleSearchField,
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: FutureBuilder<List<AnimeModel>>(
          future: AnimeRepository().getAnimeByName(_searchTerm),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ));
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                    child: Text("Error:${snapshot.error.toString()}"));
              } else if (snapshot.hasData) {
                var list = snapshot.data!;
                return RefreshIndicator(
                  onRefresh: () async {
                    setState(() {});
                  },
                  color: Colors.black,
                  backgroundColor: Colors.white,
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                                height: 130,
                                margin: const EdgeInsets.all(5),
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AnimeDetails(animeId:list[index].animeId)));
                                      },
                                      child: Row(
                                        children: [
                                          Container(
                                              height: 130,
                                              width: 90,
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 0, 5, 0),
                                              child: list[index].animeImage != null
                                                  ? Image.file(
                                                File(list[index].animeImage!),
                                                fit: BoxFit.cover,
                                              )
                                                  : Container()),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 115,
                                                  child: ListTile(
                                                    title: Text(
                                                        "${list[index].animeName}",
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                        TextAlign.justify,
                                                        style: const TextStyle(
                                                            color: Colors
                                                                .white)),
                                                    subtitle: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                      children: [
                                                        Text("${list[index].animeStatus}",
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                        Text("${list[index].animeType}",
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),

                        );
                      },
                      itemCount: list.length
                  ),
                );
              } else {
                return Center(
                    child: Text("Error:${snapshot.error.toString()}"));
              }
            } else {
              return Center(child: Text("Error:${snapshot.error.toString()}"));
            }
          }),
    );
  }
}