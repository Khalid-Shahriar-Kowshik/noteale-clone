import 'package:flutter/material.dart';
import 'package:noteale_clone/utils/colors.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: ColorsUtil.primaryColor),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: Text(title),
        actions: [
          IconButton(onPressed: null, icon: const Icon(Icons.search)),
          IconButton(onPressed: null, icon: const Icon(Icons.filter_list)),
          IconButton(onPressed: null, icon: const Icon(Icons.grid_view)),
          IconButton(onPressed: null, icon: const Icon(Icons.more_vert)),
        ],
      ),

      drawer: Drawer(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [ColorsUtil.gradiantColor, ColorsUtil.primaryColor],
            ),
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'HaBIT Note',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text('V1.0.0'),
                    ],
                  ),
                ),
                const Divider(color: Colors.black54),
                // Menu items
                const ListTile(title: Text('Forgot Password')),
                const ListTile(title: Text('Privacy Policy')),
                const ListTile(title: Text('Terms of Use')),
              ],
            ),
          ),
        ),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You have pushed the button this many times:'),
            // Stateless - show a static counter value
            Text('0', style: Theme.of(context).textTheme.headlineMedium),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: 
         const [
          BottomNavigationBarItem(icon: Icon(Icons.note),label:"Notes"),
          BottomNavigationBarItem(icon: Icon(Icons.camera),label:"OCR"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outlined),label:"Me"),
         

          ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {}, // disabled in stateless version
        backgroundColor: ColorsUtil.primaryColor,
        foregroundColor: ColorsUtil.secondaryColor,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
