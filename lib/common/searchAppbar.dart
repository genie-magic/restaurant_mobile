import 'package:flutter/material.dart';
import 'package:restaurant_manage/all_translations.dart';

class SearchAppBar extends StatefulWidget {
  final Function onTextChange;
  final String title;
  final bool bShowBackBtn;

  SearchAppBar({Key key, this.onTextChange, this.title = '', this.bShowBackBtn = true}) : super(key:key);
  @override
  _SearchAppBarState createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar>
    with SingleTickerProviderStateMixin {
  TextEditingController _searchQuery;

  bool _isSearching = false;

  @override
  void initState() {
    super.initState();

    _searchQuery = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return [
        IconButton(
          color: Colors.white70,
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (_searchQuery == null || _searchQuery.text.isEmpty) {
              // Stop searching.
              _clearSearchQuery();
              setState(() {
                _isSearching = false;
              });
              return;
            }

            _clearSearchQuery();
          },
        ),
      ];
    }

    if (widget.bShowBackBtn) {
      return [
        IconButton(
          color: Colors.white70,
          icon: const Icon(Icons.search),
          onPressed: _startSearch,
        ),
        BackButton()
      ];
    } else {
      return [
        IconButton(
          color: Colors.white70,
          icon: const Icon(Icons.search),
          onPressed: _startSearch,
        ),
      ];
    }
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchQuery,
      autofocus: true,
      decoration: InputDecoration(
        hintText: allTranslations.text("Search")+' ${widget.title}...',
        border: InputBorder.none,
        hintStyle: const TextStyle(color: Colors.white30),
      ),
      style: const TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: widget.onTextChange,
    );
  }

  void _startSearch() {
    setState(() {
      _isSearching = true;
    });
  }

  void _clearSearchQuery() {
    setState((){
      _searchQuery.clear();
      widget.onTextChange("");
    });
  }

  void onBackButton () {
    setState(() {
      _isSearching = false;
    });

    _clearSearchQuery();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: false,
      leading: _isSearching ?
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                onBackButton ();
              }
            )
          : IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
      ),
      title: _isSearching ? _buildSearchField() : Center(child: Text(widget.title)),
      actions: _buildActions(),
    );
  }
}