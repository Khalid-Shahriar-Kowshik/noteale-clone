import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:noteale_clone/models/notes_model.dart';
import 'package:noteale_clone/utils/colors.dart';
import 'package:noteale_clone/viewmodels/notes_viewmodel.dart';
import 'package:noteale_clone/views/profile_view.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';

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

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key, required this.title});
  final String title;

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  bool isGridView = false;
  bool _isSearching = false;
  late final TextEditingController _searchController;
  bool _fabMenuOpen = false;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final isToday =
        now.year == date.year && now.month == date.month && now.day == date.day;
    if (isToday) return 'Today';
    return '${date.month}/${date.day}/${date.year}';
  }

  void _showColorFilterMenu(
    BuildContext buttonContext,
    NotesViewmodel notesVM,
  ) {
    final RenderBox button = buttonContext.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(buttonContext).context.findRenderObject() as RenderBox;

    final Offset buttonOffset = button.localToGlobal(
      Offset.zero,
      ancestor: overlay,
    );

    showMenu<String>(
      context: buttonContext,
      position: RelativeRect.fromLTRB(
        buttonOffset.dx,
        buttonOffset.dy + button.size.height,
        overlay.size.width - buttonOffset.dx - button.size.width,
        overlay.size.height - buttonOffset.dy - button.size.height,
      ),
      items: [
        const PopupMenuItem(
          value: 'all',
          child: Row(
            children: [
              Icon(Icons.all_inclusive, color: Colors.grey),
              SizedBox(width: 8),
              Text('All Notes'),
            ],
          ),
        ),
        PopupMenuItem(
          value: '#FFFFFF',
          child: Row(
            children: [
              Icon(Icons.circle, color: Colors.white, size: 16),
              SizedBox(width: 8),
              Text('White'),
            ],
          ),
        ),
        PopupMenuItem(
          value: '#FFEB3B',
          child: Row(
            children: [
              Icon(Icons.circle, color: Colors.yellow.shade600, size: 16),
              SizedBox(width: 8),
              Text('Yellow'),
            ],
          ),
        ),
        PopupMenuItem(
          value: '#FFCDD2',
          child: Row(
            children: [
              Icon(Icons.circle, color: Colors.red.shade300, size: 16),
              SizedBox(width: 8),
              Text('Red'),
            ],
          ),
        ),
        PopupMenuItem(
          value: '#C8E6C9',
          child: Row(
            children: [
              Icon(Icons.circle, color: Colors.green.shade300, size: 16),
              SizedBox(width: 8),
              Text('Green'),
            ],
          ),
        ),
      ],
    ).then((value) {
      if (value != null) {
        notesVM.setFilterColor(value == 'all' ? null : value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final notesVM = context.read<NotesViewmodel>();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color:
              Theme.of(context).appBarTheme.foregroundColor ??
              ColorsUtil.primaryColor,
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Search by title',
                  hintStyle: TextStyle(
                    color: Theme.of(
                      context,
                    ).appBarTheme.foregroundColor?.withOpacity(0.7),
                  ),
                  border: InputBorder.none,
                  isDense: true,
                ),
                style: TextStyle(
                  color: Theme.of(context).appBarTheme.foregroundColor,
                ),
                onChanged: notesVM.setSearchQuery,
              )
            : Text(
                widget.title,
                style: TextStyle(
                  color: Theme.of(context).appBarTheme.foregroundColor,
                ),
              ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
              });
              if (!_isSearching) {
                _searchController.clear();
                notesVM.setSearchQuery('');
              }
            },
            icon: Icon(
              _isSearching ? Icons.close : Icons.search,
              color: Theme.of(context).appBarTheme.foregroundColor,
            ),
          ),
          Builder(
            builder: (iconContext) => IconButton(
              onPressed: () {
                _showColorFilterMenu(iconContext, notesVM);
              },
              icon: Icon(
                Icons.filter_list,
                color: Theme.of(context).appBarTheme.foregroundColor,
              ),
            ),
          ),

          ///
          ///
          ///start

          // SizedBox(
          //   width: 56,
          //   child: Stack(
          //     clipBehavior: Clip.none,
          //     children: [
          //       Align(
          //         alignment: Alignment.center,
          //         child: IconButton(
          //           onPressed: () {
          //             setState(() {
          //               _showFilterMenu = !_showFilterMenu;
          //             });
          //           },
          //           icon: Icon(
          //             Icons.filter_list,
          //             color: Theme.of(context).appBarTheme.foregroundColor,
          //           ),
          //         ),
          //       ),
          //       if (_showFilterMenu)
          //         Positioned(
          //           top: 40,
          //           right: 0,
          //           child: Material(
          //             elevation: 6,
          //             borderRadius: BorderRadius.circular(8),
          //             child: Container(
          //               width: 160,
          //               padding: const EdgeInsets.symmetric(vertical: 8),
          //               decoration: BoxDecoration(
          //                 color: Theme.of(context).cardColor,
          //                 borderRadius: BorderRadius.circular(8),
          //               ),
          //               child: Column(
          //                 mainAxisSize: MainAxisSize.min,
          //                 children: [
          //                   _buildFilterItem(
          //                     'all',
          //                     Icons.all_inclusive,
          //                     'All Notes',
          //                   ),
          //                   _buildFilterItem(
          //                     '#FFFFFF',
          //                     Icons.circle,
          //                     'White',
          //                     iconColor: Colors.white,
          //                   ),
          //                   _buildFilterItem(
          //                     '#FFEB3B',
          //                     Icons.circle,
          //                     'Yellow',
          //                     iconColor: Colors.yellow.shade600,
          //                   ),
          //                   _buildFilterItem(
          //                     '#FFCDD2',
          //                     Icons.circle,
          //                     'Red',
          //                     iconColor: Colors.red.shade300,
          //                   ),
          //                   _buildFilterItem(
          //                     '#C8E6C9',
          //                     Icons.circle,
          //                     'Green',
          //                     iconColor: Colors.green.shade300,
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ),
          //         ),
          //     ],
          //   ),
          // ),

          ///end
          ///
          ///
          IconButton(
            onPressed: () {
              setState(() {
                isGridView = !isGridView;
              });
            },
            icon: Icon(
              isGridView ? Icons.view_list : Icons.grid_view,
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
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        backgroundColor: _fabMenuOpen ? Colors.red : ColorsUtil.primaryColor,
        foregroundColor: ColorsUtil.secondaryColor,
        overlayColor: Colors.black,
        overlayOpacity: 0.15,
        direction: SpeedDialDirection.up,
        shape: const CircleBorder(),
        onOpen: () => setState(() => _fabMenuOpen = true),
        onClose: () => setState(() => _fabMenuOpen = false),
        children: [
          SpeedDialChild(
            child: const Icon(Icons.note_add_outlined),
            label: 'New note',
            backgroundColor: ColorsUtil.primaryColor,
            foregroundColor: ColorsUtil.secondaryColor,
            onTap: () => GoRouter.of(context).push('/notes'),
          ),
          SpeedDialChild(
            child: const Icon(Icons.checklist_rtl),
            label: 'New checklist',
            backgroundColor: ColorsUtil.primaryColor,
            foregroundColor: ColorsUtil.secondaryColor,
            onTap: () => GoRouter.of(context).push('/todo'),
          ),
        ],
      ),

      body: Consumer<NotesViewmodel>(
        builder: (context, notesVM, _) {
          final notes = notesVM.filteredNotes;

          if (notes.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/rafiki.png',
                    width: 207.65,
                    height: 209.01,
                  ),
                  const SizedBox(height: 12),
                  const Text("Create your first note !"),
                ],
              ),
            );
          }
          if (isGridView) {
            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 3 / 4,
              ),
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final NotesModel note = notes[index];
                final bgColor = ColorsUtil.fromHex(note.colorHex);
                final textColor = ColorsUtil.readableTextColor(note.colorHex);

                return GestureDetector(
                  onTap: () {
                    GoRouter.of(context).push('/notes/${note.id}');
                  },
                  child: Card(
                    color: bgColor,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            note.title.isEmpty ? 'Untitled' : note.title,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: textColor,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Expanded(
                            child: Text(
                              note.content,
                              maxLines: 6,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: textColor),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              _formatDate(note.createdAt),
                              style: TextStyle(
                                fontSize: 12,
                                color: textColor.withOpacity(0.8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: notes.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final NotesModel note = notes[index];
              final bgColor = ColorsUtil.fromHex(note.colorHex);
              final textColor = ColorsUtil.readableTextColor(note.colorHex);

              return Card(
                color: bgColor,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  title: Text(
                    note.title.isEmpty ? 'Untitled' : note.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      note.content,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: textColor),
                    ),
                  ),
                  trailing: Text(
                    _formatDate(note.createdAt),
                    style: TextStyle(
                      fontSize: 12,
                      color: textColor.withOpacity(0.8),
                    ),
                  ),
                  onTap: () {
                    GoRouter.of(context).push('/notes/${note.id}');
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
