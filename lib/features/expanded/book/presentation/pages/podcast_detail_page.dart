import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/widgets/button/button_widget.dart';
import 'package:reading_app/core/ui/widgets/text/text_widget.dart';
import 'package:reading_app/core/ui/widgets/text_input/simple_input_textfield.dart';
import 'package:reading_app/features/expanded/book/presentation/controller/podcast_detail_controller.dart';


class PodcastDetailPage extends StatefulWidget {
  const PodcastDetailPage({super.key});

  @override
  State<PodcastDetailPage> createState() => _PodcastDetailState();
}

class _PodcastDetailState extends State<PodcastDetailPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final String tag = 'podcastDetail ${DateTime.now().microsecondsSinceEpoch}';
    final PodcastDetailController podcastDetailController =
        Get.put(PodcastDetailController(), tag: tag);
    return Scaffold(
      body: SafeArea(
        child: PodcastDetailBody(
          tag: tag,
          controller: podcastDetailController,
        ),
      ),
    );
  }
}

class PodcastDetailBody extends StatelessWidget {
  const PodcastDetailBody({
    super.key,
    required this.tag,
    required this.controller,
  });
  final String tag;
  final PodcastDetailController controller;
  @override
  Widget build(BuildContext context) {
    return buildScrollView(context);
  }

  Widget buildBottomAudio() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 70.0,
          padding: const EdgeInsets.only(right: 25.0),
          decoration: const BoxDecoration(
            gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.primary]),
          ),
          child: Row(
            children: [
              Container(
                height: 50,
                width: 50,
                margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://images.unsplash.com/photo-1547721064-da6cfb341d50',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              const Expanded(
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextWidget(
                      text: 'Exp 1',
                      size: 15.0,
                      color: AppColors.white,
                      fontWeight: FontWeight.w500,
                    ),
                    const TextWidget(
                      text: 'Expisode 1',
                      size: 12.0,
                    )
                  ],
                ),
              ),
              const Icon(Icons.replay_10),
              Container(
                height: 40.0,
                width: 40.0,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.play_arrow,
                  color: AppColors.white,
                  size: 25.0,
                ),
              ),
              Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0),
                child: const Icon(Icons.replay_10),
              )
            ],
          ),
        ),
        const SizedBox(height: 15.0),
      ],
    );
  }

  Widget buildScrollView(BuildContext context) {
    return NestedScrollView(
      controller: controller.scrollController,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            backgroundColor: AppColors.primary.withOpacity(0.4),
            centerTitle: true,
            pinned: false,
            floating: true,
            expandedHeight: 50.0,
            title: const TextWidget(
              text: 'Header',
              fontWeight: FontWeight.w500,
              size: 22,
              textAlign: TextAlign.center,
            ),
          ),
          SliverToBoxAdapter(
            child: buildInfoBook(),
          ),
          SliverToBoxAdapter(
            child: buildContentBook(context),
          ),
          SliverToBoxAdapter(
            child: buildWriteReview(context),
          ),
          SliverPersistentHeader(
            delegate: _SliverAppBarDelegate(
              child: TabBar(
                controller: controller.tabController,
                isScrollable: false,
                labelStyle:
                    const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                unselectedLabelStyle:
                    const TextStyle(fontWeight: FontWeight.normal),
                labelColor: AppColors.primary,
                unselectedLabelColor: AppColors.black.withOpacity(0.4),
                indicatorColor: AppColors.primary,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: const UnderlineTabIndicator(
                  borderSide: const BorderSide(color: AppColors.primary, width: 2.0),
                  insets: const EdgeInsets.only(bottom: 0.0),
                ),
                tabs: [
                  Tab(text: "Expisodes".tr),
                  Tab(text: 'Review'.tr),
                ],
                onTap: (value) {},
              ),
            ),
            pinned: false,
          ),
        ];
      },
      body: buildTabChapter(context),
    );
  }

  Widget buildContentBook(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const TextWidget(
                    text: '0',
                    color: AppColors.primary,
                    fontWeight: FontWeight.w400,
                    size: 16.0,
                  ),
                  TextWidget(
                    text: 'Plays',
                    color: AppColors.black.withOpacity(0.5),
                    fontWeight: FontWeight.w500,
                    size: 15.0,
                  ),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(7.0),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.star,
                      color: AppColors.primary,
                      size: 16.0,
                    ),
                    const TextWidget(
                      text: '3.0',
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      size: 13.0,
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                height: 50.0,
                // width: 45.0,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: AppColors.black.withOpacity(0.4), width: 1),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: const TextWidget(
                    text: 'English',
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                    size: 13.0,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Scaffold.of(context).showBottomSheet(
                    backgroundColor: AppColors.transparentColor,
                    (BuildContext context) {
                      return buildBottomAudio();
                    },
                  );
                },
                child: Container(
                  height: 40.0,
                  width: 150.0,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.play_arrow,
                        color: AppColors.white,
                        size: 18.0,
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      const TextWidget(
                        text: 'Play',
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        size: 15.0,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          const ExpandableText(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque id orci sem. Donec viverra nisi a augue convallis, in vehicula libero varius. Praesent sed consequat est, nec aliquam lectus. Fusce ultrices, magna non rhoncus commodo, eros justo vestibulum elit, non gravida elit nisi id ligula. Integer nec dictum magna, nec laoreet lorem. Phasellus ut elit sem. Nullam sit amet enim id est vestibulum laoreet. Ut at odio ut tortor ultricies tempor.',
          ),
          const SizedBox(
            height: 25.0,
          ),
          buildInfoAuthor(),
          const SizedBox(
            height: 25.0,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSheetContent(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 2 / 3,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 45.0),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(25.0),
          topLeft: Radius.circular(25.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextWidget(
            text: 'Give this book a star rating',
            size: 20,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(
            height: 15.0,
          ),
          const TextWidget(
            text: 'Booka app provide all books',
            size: 15,
          ),
          const SizedBox(
            height: 15.0,
          ),
          StarRating(
            initialRating: 3.5,
            starCount: 5,
            height: 40,
            color: Colors.amber,
            onRatingChanged: (rating) {
              print('New Rating: $rating');
            },
          ),
          const SizedBox(
            height: 20.0,
          ),
          SimpleInputTextField(
            height: 62.0,
            enableColor: Colors.black,
            focusedColor: Colors.black,
            backgroundColor: AppColors.white,
            hintColor: AppColors.black.withOpacity(0.9),
            hintText: 'Enter the review...'.tr,
            controller: controller.searchController,
            onChanged: (String value) {},
            obscureText: false,
            maxLength: 150,
          ),
          const SizedBox(
            height: 50.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ButtonWidget(
                  ontap: () {
                    Get.back();
                  },
                  text: 'Cancel',
                  borderRadius: 25,
                  width: 150,
                  borderColor: AppColors.primary,
                  isBorder: true,
                  backgroundColor: AppColors.white,
                  textColor: AppColors.black,
                  textSize: 20,
                  fontWeight: FontWeight.normal,
                ),
                ButtonWidget(
                  ontap: () {},
                  text: 'Post',
                  borderRadius: 25,
                  width: 150,
                  borderColor: AppColors.primary,
                  isBorder: true,
                  backgroundColor: AppColors.white,
                  textColor: AppColors.black,
                  textSize: 20,
                  fontWeight: FontWeight.normal,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildWriteReview(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (_) => _buildBottomSheetContent(context),
                  );
                },
                child: const TextWidget(
                  text: 'Write a Review',
                  size: 18,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),
        SizedBox(
          height: 120.0,
          child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (_, index) {
                return Card(
                  color: AppColors.primary,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(right: index + 1 == 10 ? 0 : 10),
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextWidget(
                          text: '14/07/2024',
                          size: 11,
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          children: [
                            StarRating(
                              initialRating: 3.5,
                              starCount: 5,
                              color: Colors.amber,
                              onRatingChanged: (rating) {
                                print('New Rating: $rating');
                              },
                            ),
                            const TextWidget(
                              text: 'Author',
                              size: 12,
                              fontWeight: FontWeight.w500,
                              maxLines: 3,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        const Expanded(
                          child: const TextWidget(
                            text: 'Good',
                            size: 12,
                            fontWeight: FontWeight.w500,
                            maxLines: 3,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }

  Widget buildTabChapter(BuildContext context) {
    return TabBarView(
      controller: controller.tabController,
      children: [tabBarChapter(context), tabBarReview(context)],
    );
  }

  Widget tabBarChapter(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        itemCount: 1,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (_, index) {
          return buildItemPodcast(index);
        });
  }

  Widget buildItemPodcast(int index) {
    return InkWell(
      onTap: () {
        Get.toNamed("/", arguments: [
          'https://images.unsplash.com/photo-1547721064-da6cfb341d50',
          'https://images.unsplash.com/photo-1519125323398-675f0ddb6308',
          'https://images.unsplash.com/photo-1551963831-b3b1ca40c98e',
          'https://images.unsplash.com/photo-1470770841072-f978cf4d019e',
          'https://images.unsplash.com/photo-1506748686214-e9df14d4d9d0',
        ]);
      },
      child: Card(
        color: AppColors.primary,
        child: Container(
          height: 65.0,
          // width: MediaQuery.of(context).size.width,
          // margin: const EdgeInsets.only(bottom: 8.0),
          padding: const EdgeInsets.only(left: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  TextWidget(
                    text: '${index + 1}',
                    size: 15,
                    fontWeight: FontWeight.w500,
                    maxLines: 1,
                  ),
                  Container(
                    height: 50,
                    width: 55,
                    margin: const EdgeInsets.only(left: 5.0),
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15.0)),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://images.unsplash.com/photo-1547721064-da6cfb341d50',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  const Expanded(
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextWidget(
                          text:
                              'Reader Review Reader Review Reader Review Reader Review Reader Review Reader Review Reader Review ',
                          size: 11,
                          fontWeight: FontWeight.w500,
                          maxLines: 1,
                        ),
                        const Row(
                          children: [
                            TextWidget(
                              text: '1',
                              size: 10,
                            ),
                            SizedBox(width: 5.0),
                            Icon(
                              Icons.circle,
                              size: 5,
                            ),
                            SizedBox(width: 5.0),
                            TextWidget(
                              text: '18/06/2024',
                              size: 10,
                            ),
                            SizedBox(width: 5.0),
                            Icon(
                              Icons.circle,
                              size: 5,
                            ),
                            SizedBox(width: 5.0),
                            TextWidget(
                              text: '18/06/2024',
                              size: 10,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Padding(
      padding: const EdgeInsets.all(8.0),
      child: const Center(
        child: const CircularProgressIndicator(),
      ),
    );
  }

  Widget tabBarReview(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        itemCount: 1,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (_, index) {
          return Card(
            color: AppColors.primaryActive,
            child: Container(
              height: 75.0,
              // width: MediaQuery.of(context).size.width,
              // margin: const EdgeInsets.only(bottom: 8.0),
              padding: const EdgeInsets.only(left: 10.0, top: 7.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextWidget(
                    text: '14/07/2024',
                    size: 11,
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [
                      StarRating(
                        initialRating: 3.5,
                        starCount: 5,
                        color: Colors.amber,
                        onRatingChanged: (rating) {
                          print('New Rating: $rating');
                        },
                      ),
                      const TextWidget(
                        text: 'Author',
                        size: 12,
                        fontWeight: FontWeight.w500,
                        maxLines: 3,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  const Expanded(
                    child: const TextWidget(
                      text: 'Good',
                      size: 12,
                      fontWeight: FontWeight.w500,
                      maxLines: 3,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget buildInfoAuthor() {
    return InkWell(
      onTap: () {
        Get.toNamed("/");
      },
      child: Row(
        children: [
          // AvatarComponent(
          //   height: 40,
          //   width: 40,
          //   url: 'https://images.unsplash.com/photo-1547721064-da6cfb341d50',
          //   borderAvatarColor: AppColors.primary,
          // ),
          const SizedBox(
            width: 15.0,
          ),
          const Expanded(
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextWidget(
                  text: 'Author',
                  size: 16,
                  fontWeight: FontWeight.w600,
                ),
                const Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: const TextWidget(
                    text: '6 Followers',
                    size: 13,
                  ),
                )
              ],
            ),
          ),
          ButtonWidget(
            width: 120.0,
            ontap: () {},
            text: 'Follow',
            textSize: 16.0,
            backgroundColor: AppColors.primary,
            borderRadius: 25.0,
          )
        ],
      ),
    );
  }

  Widget buildInfoBook() {
    return Stack(
      children: [
        Container(
          height: 260,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.4),
          ),
        ),
        Container(
          height: 370,
          margin: const EdgeInsets.only(left: 15.0, right: 15.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(15.0)),
            child: CachedNetworkImage(
              imageUrl:
                  'https://images.unsplash.com/photo-1547721064-da6cfb341d50',
              fit: BoxFit.cover,
              width: double.infinity,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
      ],
    );
  }
}

class ExpandableText extends StatefulWidget {
  const ExpandableText(
    this.text, {
    super.key,
    this.trimLines = 4,
    this.fontSize = 15,
    this.fontSizeReadMore = 15,
    this.colorText = AppColors.black,
    this.fontWeight = FontWeight.w500,
    this.fontWeightReadMore = FontWeight.w500,
  });

  final String text;
  final int trimLines;
  final double fontSize;
  final double fontSizeReadMore;
  final FontWeight fontWeight;
  final FontWeight fontWeightReadMore;
  final Color colorText;

  @override
  ExpandableTextState createState() => ExpandableTextState();
}

class ExpandableTextState extends State<ExpandableText> {
  bool _readMore = false; // Default to false to show trimmed text initially

  void _onTapLink() {
    setState(() => _readMore = !_readMore);
  }

  @override
  Widget build(BuildContext context) {
    final colorClickableText = AppColors.primary;

    final link = TextSpan(
      text: _readMore ? " Read Less" : "... Read More...",
      style: TextStyle(
        color: colorClickableText,
        fontWeight: widget.fontWeightReadMore,
        fontSize: widget.fontSizeReadMore,
      ),
      recognizer: TapGestureRecognizer()..onTap = _onTapLink,
    );

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final textSpan = TextSpan(
          text: widget.text,
          style: TextStyle(
            color: widget.colorText,
            fontSize: widget.fontSize,
            fontWeight: widget.fontWeight,
          ),
        );

        final textPainter = TextPainter(
          text: textSpan,
          textDirection: TextDirection.ltr,
          maxLines: widget.trimLines,
          ellipsis: '...',
        )..layout(maxWidth: constraints.maxWidth);

        if (textPainter.didExceedMaxLines) {
          final endIndex = textPainter
              .getPositionForOffset(
                Offset(
                  constraints.maxWidth - textPainter.size.width,
                  textPainter.size.height,
                ),
              )
              .offset;

          final displayedText =
              _readMore ? widget.text : widget.text.substring(0, endIndex);

          final fullText = TextSpan(
            text: displayedText,
            style: TextStyle(
              color: widget.colorText,
              fontSize: widget.fontSize,
              fontWeight: widget.fontWeight,
            ),
            children: <TextSpan>[link],
          );

          return RichText(
            text: fullText,
            textDirection: TextDirection.ltr,
            softWrap: true,
          );
        } else {
          return RichText(
            text: textSpan,
            textDirection: TextDirection.ltr,
            softWrap: true,
          );
        }
      },
    );
  }
}

typedef void RatingChangeCallback(double rating);

class StarRating extends StatefulWidget {
  final int starCount;
  final double initialRating;
  final RatingChangeCallback onRatingChanged;
  final Color color;
  final double height;
  const StarRating({
    Key? key,
    this.starCount = 5,
    this.height = 15,
    this.initialRating = 0.0,
    required this.onRatingChanged,
    required this.color,
  }) : super(key: key);

  @override
  _StarRatingState createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  late double _currentRating;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.initialRating;
  }

  void _onStarTap(int index, TapDownDetails details) {
    double newRating;
    if (details.localPosition.dx < 15) {
      // Assuming 15 is half the star size
      newRating = index + 0.5;
    } else {
      newRating = index + 1.0;
    }
    setState(() {
      _currentRating = newRating;
    });
    widget.onRatingChanged(newRating);
  }

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= _currentRating) {
      icon = Icon(
        Icons.star_border,
        color: Colors.grey, // Use your defined AppColors.gray37
        size: widget.height, // Adjust size as needed
      );
    } else if (index > _currentRating - 1 && index < _currentRating) {
      icon = Icon(
        Icons.star_half,
        color: widget.color,
        size: widget.height, // Adjust size as needed
      );
    } else {
      icon = Icon(
        Icons.star,
        color: widget.color,
        size: widget.height, // Adjust size as needed
      );
    }
    return GestureDetector(
      onTapDown: (details) => _onStarTap(index, details),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children:
          List.generate(widget.starCount, (index) => buildStar(context, index)),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.child,
  });

  final Widget child;

  @override
  double get minExtent => 60.0;

  @override
  double get maxExtent => 60.0;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
