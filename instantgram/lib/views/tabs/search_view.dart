import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/components/searched_posts_grid_view.dart';

class SearchView extends HookConsumerWidget {
  const SearchView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final termController = useTextEditingController();
    final term = useState('');
    return Column(children: [
      TextField(
        controller: termController,
        onSubmitted: (text) => term.value = text,
        decoration: InputDecoration(
            labelText: 'Search here',
            suffixIcon: IconButton(
                onPressed: () {
                  termController.clear();
                  term.value = '';
                },
                icon: const Icon(Icons.clear))),
        textInputAction: TextInputAction.search,
      ),
      Expanded(child: SearchedPostsGridView(term: term.value))
    ]);
  }
}
