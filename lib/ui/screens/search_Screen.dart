import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../viewmodels/search_provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchProvider = context.watch<SearchProvider>();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: searchProvider.isLoading
                      ? const SizedBox(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator(strokeWidth: 3),
                        )
                      : Icon(Icons.search),
                ),
                Expanded(child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: TextField(
                    controller: _controller,
                    onChanged: (value) =>
                        context.read<SearchProvider>().search(value),
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      hintText: 'Enter keyword',
                      border: InputBorder.none,
                      suffixIcon: _controller.text.isEmpty
                          ? null
                          : IconButton(
                              icon: Icon(Icons.cancel_outlined),
                              onPressed: () {
                                _controller.clear();
                                context.read<SearchProvider>().search('');
                              },
                            ),
                    ),
                  ),
                )),
              ],
            ),
            if (searchProvider.error.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  searchProvider.error,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            Expanded(
              child: ListView.builder(
                itemCount: searchProvider.addresses.length,
                itemBuilder: (context, index) {
                  final address = searchProvider.addresses[index];
                  return ListTile(
                    title: Text(address.title),
                    subtitle: Text(address.fullAddress),
                    onTap: () async {
                      final url =
                          'https://www.google.com/maps/search/?api=1&query=${address.lat},${address.lon}';
                      if (await canLaunchUrl(Uri.parse(url))) {
                        await launchUrl(
                          Uri.parse(url),
                          mode: LaunchMode.externalApplication,
                        );
                      }
                    },
                    trailing:  Icon(Icons.directions),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
