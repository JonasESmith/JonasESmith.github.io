import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../core.dart';

class ProjectImageGallery extends StatefulWidget {
  const ProjectImageGallery({
    super.key,
    required this.images,
    required this.projectName,
  });

  final List<ImageUrl>? images;
  final String projectName;

  @override
  State<ProjectImageGallery> createState() => _ProjectImageGalleryState();
}

class _ProjectImageGalleryState extends State<ProjectImageGallery> {
  PageController pageController = PageController();
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    if (widget.images == null || widget.images!.isEmpty) {
      return const SizedBox.shrink();
    }

    const height = 600.0;

    return SizedBox(
      height: height,
      child: CupertinoScrollbar(
        controller: scrollController,
        scrollbarOrientation: ScrollbarOrientation.bottom,
        child: ListView.builder(
          cacheExtent: 9999,
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          itemCount: widget.images!.length,
          itemBuilder: (context, index) {
            final image = widget.images![index];

            return MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GalleryExampleItemThumbnail(
                galleryExampleItem: image,
                onTap: () => open(context, index),
              ),
            );
          },
        ),
      ),
    );
  }

  void open(BuildContext context, final int index) {
    setState(() {
      pageController = PageController(
        initialPage: index,
      );
    });

    Navigator.push(
      context,
      HeroDialogRoute(
        builder: (context) => GalleryPhotoViewWrapper(
          initialIndex: index,
          galleryItems: widget.images!,
          pageController: pageController,
          projectName: widget.projectName,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }
}

class GalleryExampleItemThumbnail extends StatelessWidget {
  const GalleryExampleItemThumbnail({
    super.key,
    required this.galleryExampleItem,
    required this.onTap,
  });

  final ImageUrl galleryExampleItem;

  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: GestureDetector(
        onTap: onTap,
        child: Hero(
          tag: galleryExampleItem.url,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(kPad),
            child: Image.asset(
              galleryExampleItem.url,
              height: 80.0,
            ),
          ),
        ),
      ),
    );
  }
}

class GalleryPhotoViewWrapper extends StatefulWidget {
  const GalleryPhotoViewWrapper({
    super.key,
    this.loadingBuilder,
    this.minScale,
    this.maxScale,
    this.initialIndex = 0,
    required this.galleryItems,
    required this.projectName,
    required this.pageController,
    this.scrollDirection = Axis.horizontal,
  });

  final LoadingBuilder? loadingBuilder;
  final dynamic minScale;
  final dynamic maxScale;
  final int initialIndex;
  final PageController pageController;
  final List<ImageUrl> galleryItems;
  final String projectName;
  final Axis scrollDirection;

  @override
  State<StatefulWidget> createState() {
    return _GalleryPhotoViewWrapperState();
  }
}

class _GalleryPhotoViewWrapperState extends State<GalleryPhotoViewWrapper> {
  late int currentIndex = widget.initialIndex;

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final bgColor = theme.colorScheme.primary.withOpacity(0.1);
    final bColor = theme.colorScheme.primary.withOpacity(0.4);
    final textColor = theme.colorScheme.primary;

    final canNavBack = currentIndex >= 1;
    final canNavForwards = currentIndex < widget.galleryItems.length - 1;
    final bgDecoration = const BoxDecoration(color: Colors.transparent);

    const vertPadding = (kPad / 2) - 2;

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
      child: Container(
        decoration: bgDecoration,
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: kPad,
                right: kPad,
                top: kPad * 1.5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  VoxButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(kPad),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(kPad / 2),
                            decoration: BoxDecoration(
                              color: bgColor,
                              border: Border(
                                left: BorderSide(color: bColor),
                                top: BorderSide(color: bColor),
                                bottom: BorderSide(color: bColor),
                                right: BorderSide(color: bColor),
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(kPad),
                                bottomLeft: Radius.circular(kPad),
                              ),
                            ),
                            child: Icon(
                              CupertinoIcons.chevron_back,
                              color: textColor,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: vertPadding,
                              horizontal: kPad / 2,
                            ),
                            decoration: BoxDecoration(
                              color: bgColor,
                              border: Border(
                                top: BorderSide(color: bColor),
                                bottom: BorderSide(color: bColor),
                                right: BorderSide(color: bColor),
                              ),
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(kPad),
                                bottomRight: Radius.circular(kPad),
                              ),
                            ),
                            child: Text(
                              widget.projectName,
                              style: theme.textTheme.titleLarge!.copyWith(
                                color: textColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: theme.scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(kPad),
                    ),
                    child: Row(
                      children: [
                        VoxButton(
                          onPressed: canNavBack
                              ? () {
                                  animateToPage(currentIndex - 1);
                                }
                              : null,
                          child: Container(
                            padding: const EdgeInsets.all(kPad / 2),
                            decoration: BoxDecoration(
                              color: bgColor,
                              border: Border(
                                left: BorderSide(color: bColor),
                                top: BorderSide(color: bColor),
                                bottom: BorderSide(color: bColor),
                                right: BorderSide(color: bColor),
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(kPad),
                                bottomLeft: Radius.circular(kPad),
                              ),
                            ),
                            child: Icon(
                              CupertinoIcons.chevron_back,
                              color: canNavBack //
                                  ? textColor
                                  : theme.disabledColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: kPad / 2,
                            vertical: vertPadding,
                          ),
                          decoration: BoxDecoration(
                            color: bgColor,
                            border: Border(
                              bottom: BorderSide(color: bColor),
                              top: BorderSide(color: bColor),
                            ),
                          ),
                          child: Text(
                            "Image ${currentIndex + 1} / ${widget.galleryItems.length}",
                            style: theme.textTheme.titleLarge!.copyWith(
                              color: textColor,
                            ),
                          ),
                        ),
                        VoxButton(
                          onPressed: canNavForwards
                              ? () {
                                  animateToPage(currentIndex + 1);
                                }
                              : null,
                          child: Container(
                            padding: const EdgeInsets.all(kPad / 2),
                            decoration: BoxDecoration(
                              color: bgColor,
                              border: Border(
                                left: BorderSide(color: bColor),
                                top: BorderSide(color: bColor),
                                bottom: BorderSide(color: bColor),
                                right: BorderSide(color: bColor),
                              ),
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(kPad),
                                bottomRight: Radius.circular(kPad),
                              ),
                            ),
                            child: Icon(
                              CupertinoIcons.chevron_right,
                              color: canNavForwards //
                                  ? textColor
                                  : theme.disabledColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            Expanded(
              child: PhotoViewGallery.builder(
                builder: _buildItem,
                onPageChanged: onPageChanged,
                backgroundDecoration: bgDecoration,
                itemCount: widget.galleryItems.length,
                loadingBuilder: widget.loadingBuilder,
                pageController: widget.pageController,
                scrollDirection: widget.scrollDirection,
                scrollPhysics: const BouncingScrollPhysics(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void animateToPage(int index) {
    setState(() {
      currentIndex = index;
    });

    widget.pageController.animateToPage(
      index,
      curve: Curves.easeIn,
      duration: const Duration(milliseconds: 390),
    );
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    final ImageUrl item = widget.galleryItems[index];
    return PhotoViewGalleryPageOptions(
      imageProvider: AssetImage(item.url),
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
      maxScale: PhotoViewComputedScale.covered * 4.1,
      heroAttributes: PhotoViewHeroAttributes(tag: item.url),
    );
  }
}
