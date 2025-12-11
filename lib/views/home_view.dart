import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:noteale_clone/utils/colors.dart';
import 'package:noteale_clone/views/profile_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.title});

  final String title;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      HomeWidget(title: widget.title),
      Container(),
      ProfileView(),
    ];
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? ColorsUtil.backgroundColor
            : (Theme.of(context).bottomAppBarTheme.color ??
                  Theme.of(context).colorScheme.surface),
        selectedItemColor: Colors.amberAccent,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.note_alt_outlined),
            label: "Notes",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.camera), label: "OCR"),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: "Me",
          ),
        ],
      ),
    );
  }
}

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color:
              Theme.of(context).appBarTheme.foregroundColor ??
              ColorsUtil.primaryColor,
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text(
          title,
          style: TextStyle(
            color: Theme.of(context).appBarTheme.foregroundColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: null,
            icon: Icon(
              Icons.search,
              color: Theme.of(context).appBarTheme.foregroundColor,
            ),
          ),
          IconButton(
            onPressed: null,
            icon: Icon(
              Icons.filter_list,
              color: Theme.of(context).appBarTheme.foregroundColor,
            ),
          ),
          IconButton(
            onPressed: null,
            icon: Icon(
              Icons.grid_view,
              color: Theme.of(context).appBarTheme.foregroundColor,
            ),
          ),
        ],
      ),

      ///Drawer Disabled ///

      // drawer: Drawer(
      //   child: Container(
      //     decoration: const BoxDecoration(
      //       gradient: LinearGradient(
      //         begin: Alignment.topCenter,
      //         end: Alignment.bottomCenter,
      //         colors: [ColorsUtil.gradiantColor, ColorsUtil.primaryColor],
      //       ),
      //     ),
      //     child: SafeArea(
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           Padding(
      //             padding: const EdgeInsets.all(16),
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: const [
      //                 Text(
      //                   'HaBIT Note',
      //                   style: TextStyle(
      //                     fontSize: 20,
      //                     fontWeight: FontWeight.bold,
      //                     fontStyle: FontStyle.italic,
      //                   ),
      //                 ),
      //                 SizedBox(height: 4),
      //                 Text('V1.0.0'),
      //               ],
      //             ),
      //           ),
      //           const Divider(color: Colors.black54),
      //           const ListTile(title: Text('Forgot Password')),
      //           const ListTile(title: Text('Privacy Policy')),
      //           const ListTile(title: Text('Terms of Use')),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
      floatingActionButton: Builder(
        builder: (fabContext) => FloatingActionButton(
          onPressed: () async {
            final RenderBox button = fabContext.findRenderObject() as RenderBox;
            final RenderBox overlay =
                Overlay.of(fabContext).context.findRenderObject() as RenderBox;
            final Offset buttonOffset = button.localToGlobal(
              Offset.zero,
              ancestor: overlay,
            );

            final selection = await showMenu<String>(
              context: fabContext,
              position: RelativeRect.fromLTRB(
                buttonOffset.dx,
                buttonOffset.dy,
                overlay.size.width - buttonOffset.dx - button.size.width,
                overlay.size.height - buttonOffset.dy - button.size.height,
              ),
              items: [
                PopupMenuItem<String>(
                  value: 'note',
                  child: ListTile(
                    leading: Icon(Icons.note_add_outlined),
                    title: Text('New note'),
                    onTap: () {
                      GoRouter.of(context).push('/notes');
                    },
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'checklist',
                  child: ListTile(
                    leading: Icon(Icons.checklist_rtl),
                    title: Text('New checklist'),
                    onTap: () {
                      GoRouter.of(context).push('/todo');
                    },
                  ),
                ),
              ],
            );

            if (selection != null) {
              log('FAB action selected: $selection');
            }
          },
          backgroundColor: ColorsUtil.primaryColor,
          foregroundColor: ColorsUtil.secondaryColor,
          shape: const CircleBorder(),
          child: const Icon(Icons.add),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/rafiki.png', width: 207.65, height: 209.01),
                const Text("Create your first note !"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
