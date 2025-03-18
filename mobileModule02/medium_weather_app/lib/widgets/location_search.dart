import 'package:flutter/material.dart';
import '../models/location.dart';

class LocationSearch extends StatefulWidget {
  final Function(Location) onSearchSuccess;
  final Function(String) onSearchError;

  const LocationSearch({
    required this.onSearchSuccess,
    required this.onSearchError,
    super.key,
  });
  @override
  LocationSearchState createState() => LocationSearchState();
}

class LocationSearchState extends State<LocationSearch> {
  late Iterable<Location> searchList;
  TextEditingController _searchController = TextEditingController();

  void clear() {
    _searchController.text = '';
    _searchController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Autocomplete<Location>(
      optionsBuilder: (TextEditingValue textEditingValue) async {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<Location>.empty();
        }
        try {
          searchList = await Location.fetchLocations(textEditingValue.text);
        } catch (e) {
          searchList = const Iterable<Location>.empty();
        }
        return searchList;
      },
      displayStringForOption: (Location option) {
        String displayString = option.name;
        return displayString;
      },
      optionsViewBuilder: (
        BuildContext context,
        AutocompleteOnSelected<Location> onSelected,
        Iterable<Location> options,
      ) {
        return Container(
          color: Theme.of(context).colorScheme.surface,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: options.length,
            itemBuilder: (BuildContext context, int index) {
              final Location option = options.elementAt(index);
              return Container(
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.tealAccent)),
                ),
                child: ListTile(
                  title: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: option.name,
                          style: const TextStyle(color: Colors.white),
                        ),
                        if (option.region?.isNotEmpty == true)
                          TextSpan(
                            text: ' ${option.region}',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        if (option.country?.isNotEmpty == true)
                          TextSpan(
                            text: ', ${option.country}',
                            style: const TextStyle(color: Colors.grey),
                          ),
                      ],
                    ),
                  ),
                  onTap: () {
                    onSelected(option);
                    FocusScope.of(context).unfocus();
                  },
                ),
              );
            },
          ),
        );
      },
      fieldViewBuilder: (
        BuildContext context,
        TextEditingController textEditingController,
        FocusNode focusNode,
        VoidCallback onFieldSubmitted,
      ) {
        _searchController = textEditingController;
        return TextField(
          controller: textEditingController,
          focusNode: focusNode,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Search Location...',
            hintStyle: TextStyle(color: Colors.grey),
            prefixIcon: Icon(Icons.search, color: Colors.grey),
          ),
          style: const TextStyle(color: Colors.white, fontSize: 18),
          onSubmitted: (value) async {
            if (value.isEmpty) return;
            if (searchList.isNotEmpty) {
              onFieldSubmitted();
            } else {
              try {
                searchList = await Location.fetchLocations(value);
                widget.onSearchSuccess(searchList.first);
              } catch (e) {
                widget.onSearchError(e.toString());
              }
            }
          },
        );
      },
      onSelected: (Location selection) {
        widget.onSearchSuccess(selection);
      },
    );
  }
}
