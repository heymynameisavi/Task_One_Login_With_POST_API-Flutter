import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PhotosPage extends StatefulWidget {
  const PhotosPage({Key? key}) : super(key: key);

  @override
  State<PhotosPage> createState() => _PhotosPageState();
}

class _PhotosPageState extends State<PhotosPage> {
  List<Photos> photosList = [];

  Future<List<Photos>> getPhotos() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString());

    print(data);
    if (response.statusCode == 200) {
      for (Map i in data) {
        Photos photos = Photos(title: i['title'], url: i['url'], id: i['id']);
        photosList.add(photos);
      }
      return photosList;
    } else {
      return photosList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getPhotos(),
                builder: (context, AsyncSnapshot<List<Photos>> snapshot) {
                  return ListView.builder(
                      itemCount: photosList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            showDialogFunc(
                                context,
                                snapshot.data![index].id,
                                snapshot.data![index].title,
                                snapshot.data![index].url);
                          },
                          child: Card(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Ink.image(
                                      image: NetworkImage(
                                          snapshot.data![index].url.toString()),
                                      height: 240,
                                      fit: BoxFit.cover,
                                    ),
                                    Positioned(
                                      bottom: 16,
                                      right: 16,
                                      left: 16,
                                      child: Text(
                                        'Photos id:' +
                                            snapshot.data![index].id.toString(),
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 22),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(16)
                                          .copyWith(bottom: 0),
                                      child: Text(
                                        snapshot.data![index].title.toString(),
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 22),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                        // return ListTile(
                        //   leading:CircleAvatar(

                        //     backgroundImage:  NetworkImage(snapshot.data![index].url.toString()),
                        //   ),

                        //   subtitle: Text(snapshot.data![index].title.toString()),
                        //   title: Text('Photos id:'+snapshot.data![index].id.toString()),
                        // );
                      });
                }),
          ),
        ],
      ),
    );
  }
}

showDialogFunc(context, id, title, url) {
  return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              padding: EdgeInsets.all(15),
              height: 320,
              width: MediaQuery.of(context).size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    // width: 200,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        title,
                        maxLines: 3,
                        style: TextStyle(fontSize: 15, color: Colors.grey[500]),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
}

class Photos {
  String title, url;
  int id;
  Photos({required this.title, required this.url, required this.id});
}
