import 'package:flutter/material.dart';

class IconActionWidget extends StatelessWidget {
  final String imagePath;
  final String label;
  final double iconSize;
  final VoidCallback? onPressed;

  const IconActionWidget({
    super.key,
    required this.imagePath,
    required this.label,
    this.iconSize = 50,
    this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath,
          width: iconSize,
          height: iconSize),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              )
          ),
        ],
      ),
    );
  }
}

Widget buildIconGrid(List<IconActionWidget> actions) {
  return GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 4,
      childAspectRatio: 1.0,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
    ),
    shrinkWrap: true,
    itemCount: actions.length,
    itemBuilder: (context, index) {
      return IconActionWidget(
        imagePath: actions[index].imagePath,
        label: actions[index].label,
        iconSize: actions[index].iconSize,
        onPressed: actions[index].onPressed,
      );
    },
  );
}

Widget buildIconGridMore(List<IconActionWidget> actions) {
  return GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      childAspectRatio: 1.0,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
    ),
    shrinkWrap: true,
    itemCount: actions.length,
    itemBuilder: (context, index) {
      return IconActionWidget(
        imagePath: actions[index].imagePath,
        label: actions[index].label,
        iconSize: actions[index].iconSize,
        onPressed: actions[index].onPressed,
      );
    },
  );
}

class NewsCard extends StatelessWidget {
  final String author;
  final String title;
  final String content;
  final String url;

  const NewsCard({
    super.key,
    required this.author,
    required this.title,
    required this.content,
    required this.url
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {},
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        color: const Color(0xFF222831),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(author, style: TextStyle(color: Colors.white.withOpacity(1), fontSize: 14)),
              const SizedBox(height: 8),
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 8),
              Text(content, style: TextStyle(color: Colors.grey[300]), maxLines: 4, overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildIconItem(BuildContext context, Map<String, dynamic> item) {
    return GestureDetector(
      onTap: item['onTap'] ?? () {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            item['icon'],
            width: 40,
            height: 40,
            errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, color: Colors.white, size: 40),
          ),
          const SizedBox(height: 8),
          Text(
            item['label'],
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget buildSettingCategory(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildSettingItem(String title, String value) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            // Tambahkan logika untuk aksi tombol di sini
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                if (value.isNotEmpty)
                  Text(
                    value,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
              ],
            ),
          ),
        ),
        const Divider(color: Colors.grey),
      ],
    );
  }