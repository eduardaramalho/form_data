import 'package:flutter/material.dart';

import '../app/theme.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
          icon: Icon(Icons.search),
          hintText: 'Pesquise aqui sua tarefa',
          labelText: 'Encontre a sua tarefa',
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1, color: Color.fromARGB(255, 75, 118, 204)),
              borderRadius: BorderRadius.all(Radius.circular(10)))),
    );
  }
}
