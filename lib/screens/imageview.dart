import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {

  final dynamic imgUrl;

  const ImageView({this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[700],
        title: Text('Pet Detail'),
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios),
            onPressed: () { Navigator.pop(context); }
        ),
      ),
      body: CachedNetworkImage(
        placeholder: (context, url) => CircularProgressIndicator(
          backgroundColor: Colors.grey[600],
          strokeWidth: 2,
        ),
        imageUrl: imgUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
