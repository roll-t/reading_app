import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SliderImage extends StatefulWidget {
  const SliderImage({super.key, required this.imgList});
  final List<String> imgList;
  @override
  State<SliderImage> createState() => _SliderImageState();
}

class _SliderImageState extends State<SliderImage> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.imgList.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return KeepAlivePage(
                imageUrl: widget.imgList[index],
              );
            },
          ),
        ),
      ],
    );
  }
}

class KeepAlivePage extends StatefulWidget {
  final String imageUrl;

  const KeepAlivePage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  _KeepAlivePageState createState() => _KeepAlivePageState();
}

class _KeepAlivePageState extends State<KeepAlivePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      margin: EdgeInsets.all(10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        child: CachedNetworkImage(
          imageUrl: widget.imageUrl,
          fit: BoxFit.cover,
          width: double.infinity,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
