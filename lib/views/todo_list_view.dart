import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:noteale_clone/utils/colors.dart';

class ToDoListView extends StatefulWidget {
  const ToDoListView({super.key});

  @override
  State<ToDoListView> createState() => _ToDoListViewState();
}

class _ToDoListViewState extends State<ToDoListView> {
  bool _sleepChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtil.secondaryColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => GoRouter.of(context).pop(),
        ),
        backgroundColor: ColorsUtil.secondaryColor,
        title: const Text("To-Dos"),
        actions: [Icon(Icons.more_vert), SizedBox(width: 16)],
      ),

      body: Padding(
        padding: const EdgeInsets.all(32),
        child: ListView(
          children: [
            CheckboxListTile(
              value: _sleepChecked,
              title: Text(
                'Sleep',
                style: TextStyle(
                  fontSize: 16,
                  decoration: _sleepChecked
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              activeColor: ColorsUtil.primaryColor,
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (value) {
                setState(() {
                  if (value != null) {
                    _sleepChecked = value;
                  } else {
                    _sleepChecked = false;
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
