import 'package:flutter/material.dart';

class NoteList extends StatelessWidget {
  const NoteList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('List of notes')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: ListView.separated(
          separatorBuilder: (_, __) => const Divider(
                height: 1,
                color: Colors.green,
              ),
          itemBuilder: (_, index) {
            return ListTile(
              title: Text(
                'Hello',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              subtitle: Text('Last edited on 21/2/2021'),
            );
          },
          itemCount: 30),
    );
  }
}
