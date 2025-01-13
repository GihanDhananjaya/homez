import 'package:flutter/material.dart';


class AppSearchCriteria {
  final Function(String) onSubmit;
  final Function(String)? onChanged;
  final String? hint;
  final TextEditingController? controller;
  final bool isSearchView;
  final Function(int)? onSelect;

  AppSearchCriteria(
      {required this.onSubmit,
        this.onChanged,
        this.hint,
        this.controller,
        this.isSearchView = false,
        this.onSelect});
}

class AppSearchComponent extends StatefulWidget {
  final AppSearchCriteria searchCriteria;

  AppSearchComponent({
    required this.searchCriteria,
  });

  @override
  _AppSearchComponentState createState() => _AppSearchComponentState();
}

class _AppSearchComponentState extends State<AppSearchComponent> {
  TextEditingController? _searchController;
  int selectedSortOption = 1;

  @override
  void initState() {
    super.initState();
    setState(() {
      if (widget.searchCriteria.controller != null) {
        _searchController = widget.searchCriteria.controller!;
      } else {
        _searchController = TextEditingController();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: TextInputAction.search,
      maxLines: 1,
      controller: _searchController,
      textCapitalization: TextCapitalization.sentences,
      maxLength: 25,
      onSubmitted: widget.searchCriteria.onSubmit,
      onChanged: widget.searchCriteria.onChanged,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.normal,
      ),
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        isDense: true,
        counterText: "",
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1.5,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        filled: true,
        hintStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
        hintText: widget.searchCriteria.hint ?? 'Search',
        fillColor: Colors.white,
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  widget.searchCriteria.onSubmit(_searchController!.text);
                },
                child: SizedBox(
                  child: Icon(
                    Icons.search,
                    size: 24,
                    color: Colors.black,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
