import 'package:flutter/material.dart';
import 'package:task_assignment_one/main.dart';
import 'package:task_assignment_one/pages/photos_page.dart';
import 'package:task_assignment_one/pages/posts_page.dart';
import 'package:task_assignment_one/widget/navigation_drawer_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();

    controller = TabController(length: 2, vsync: this);
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          
            actions: [
              OutlineButton.icon(
            onPressed: (){
               Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyHomePage()));
            }, 
            icon: Icon(Icons.exit_to_app, size: 18,),  
            label: Text('Logout')),
            ],
          title: Text('Tab ${controller.index + 1}'),
          
          centerTitle: true,
          bottom: TabBar(
            controller: controller,
            tabs: [
              Tab(
                text: 'Photos',
                icon: Icon(Icons.photo),
              ),
              Tab(
                text: 'Posts',
                icon: Icon(Icons.post_add),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: controller,
          children: [
            PhotosPage(),
            PostsPage(),
          ],
        ),
      );
}
