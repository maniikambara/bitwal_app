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
                    title: 'Latest Tokens',
                    isSelected: selectedFilter == 'Latest Tokens',
                    onSelect: () => _selectFilter('Latest Tokens'),
                  ),
                  FilterOption(
                    title: 'Favorite Tokens',
                    isSelected: selectedFilter == 'Favorite Tokens',
                    onSelect: () => _selectFilter('Favorite Tokens'),
                  ),
                  FilterOption(
                    title: 'Meme Tokens',
                    isSelected: selectedFilter == 'Meme Tokens',
                    onSelect: () => _selectFilter('Meme Tokens'),
                  ),
                  FilterOption(
                    title: 'Gaming Tokens',
                    isSelected: selectedFilter == 'Gaming Tokens',
                    onSelect: () => _selectFilter('Gaming Tokens'),
                  ),
                  FilterOption(
                    title: 'AI & Big Data Tokens',
                    isSelected: selectedFilter == 'AI & Big Data Tokens',
                    onSelect: () => _selectFilter('AI & Big Data Tokens'),
                  ),
                  FilterOption(
                    title: 'DoFi Tokens',
                    isSelected: selectedFilter == 'DoFi Tokens',
                    onSelect: () => _selectFilter('DoFi Tokens'),
                  ),
                  FilterOption(
                    title: 'Layer 1 Tokens',
                    isSelected: selectedFilter == 'Layer 1 Tokens',
                    onSelect: () => _selectFilter('Layer 1 Tokens'),
                  ),
                  FilterOption(
                    title: 'Layer 2 Tokens',
                    isSelected: selectedFilter == 'Layer 2 Tokens',
                    onSelect: () => _selectFilter('Layer 2 Tokens'),
                  ),
                  FilterOption(
                    title: 'NFT Tokens',
                    isSelected: selectedFilter == 'NFT Tokens',
                    onSelect: () => _selectFilter('NFT Tokens'),
                  ),
                  FilterOption(
                    title: 'Web3 Tokens',
                    isSelected: selectedFilter == 'Web3 Tokens',
                    onSelect: () => _selectFilter('Web3 Tokens'),
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
                  'APPLY',
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
