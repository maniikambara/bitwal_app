import 'package:flutter/material.dart';

class TokenFilterSheet extends StatefulWidget {
  const TokenFilterSheet({super.key});

  @override
  State<TokenFilterSheet> createState() => _TokenFilterSheetState();
}

class _TokenFilterSheetState extends State<TokenFilterSheet> {
  String? selectedFilter;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF222831),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: SizedBox(
                width: 100,
                child: Divider(
                  thickness: 3,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Center(
              child: Text(
                'FILTER',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  FilterOption(
                    title: 'Token Terbaru',
                    isSelected: selectedFilter == 'Token Terbaru',
                    onSelect: () => _selectFilter('Token Terbaru'),
                  ),
                  FilterOption(
                    title: 'Token Favorit',
                    isSelected: selectedFilter == 'Token Favorit',
                    onSelect: () => _selectFilter('Token Favorit'),
                  ),
                  FilterOption(
                    title: 'Token Meme',
                    isSelected: selectedFilter == 'Token Meme',
                    onSelect: () => _selectFilter('Token Meme'),
                  ),
                  FilterOption(
                    title: 'Token Gaming',
                    isSelected: selectedFilter == 'Token Gaming',
                    onSelect: () => _selectFilter('Token Gaming'),
                  ),
                  FilterOption(
                    title: 'Token AI & Big Data',
                    isSelected: selectedFilter == 'Token AI & Big Data',
                    onSelect: () => _selectFilter('Token AI & Big Data'),
                  ),
                  FilterOption(
                    title: 'Token DoFi',
                    isSelected: selectedFilter == 'Token DoFi',
                    onSelect: () => _selectFilter('Token DoFi'),
                  ),
                  FilterOption(
                    title: 'Token Layer 1',
                    isSelected: selectedFilter == 'Token Layer 1',
                    onSelect: () => _selectFilter('Token Layer 1'),
                  ),
                  FilterOption(
                    title: 'Token Layer 2',
                    isSelected: selectedFilter == 'Token Layer 2',
                    onSelect: () => _selectFilter('Token Layer 2'),
                  ),
                  FilterOption(
                    title: 'Token NFT',
                    isSelected: selectedFilter == 'Token NFT',
                    onSelect: () => _selectFilter('Token NFT'),
                  ),
                  FilterOption(
                    title: 'Token Web3',
                    isSelected: selectedFilter == 'Token Web3',
                    onSelect: () => _selectFilter('Token Web3'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, selectedFilter);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD65A31),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Center(
                child: Text(
                  'TERAPKAN',
                  style: TextStyle(
                    color: Color(0xFF222831),
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _selectFilter(String filter) {
    setState(() {
      selectedFilter = filter;
    });
  }
}

class FilterOption extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onSelect;

  const FilterOption({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelect,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: [
            Radio(
              value: true,
              groupValue: isSelected,
              onChanged: (_) => onSelect(),
              activeColor: const Color(0xFFD65A31),
              fillColor: WidgetStateProperty.resolveWith<Color>(
                (Set<WidgetState> states) {
                  if (states.contains(WidgetState.selected)) {
                    return const Color(0xFFD65A31);
                  }
                  return Colors.white;
                },
              ),
            ),
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
