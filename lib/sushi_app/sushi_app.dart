import 'package:flutter/material.dart';

class SushiApp extends StatefulWidget {
  const SushiApp({Key? key}) : super(key: key);

  @override
  _SushiAppState createState() => _SushiAppState();
}

class _SushiAppState extends State<SushiApp> {
  // https://www.youtube.com/watch?v=u64MXByVEwM

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          FlexibleSpaceBarHeader(),
          SliverPersistentHeader(delegate: HeaderSliver(), pinned: true),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 1200,
            ),
          )
        ],
      ),
    );
  }
}

const maxHeaderExtent = 100.0;

class HeaderSliver extends SliverPersistentHeaderDelegate {
  const HeaderSliver();

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final percent = shrinkOffset / maxHeaderExtent;
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: maxHeaderExtent,
            color: Colors.grey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    AnimatedOpacity(
                      opacity: percent > .05 ? 1 : 0,
                      duration: Duration(milliseconds: 300),
                      child: Icon(Icons.arrow_back),
                    ),
                    AnimatedSlide(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                      offset: Offset(percent < .05 ? -0.18 : 0.18, 0),
                      child: Text('Kavsoft Bakery'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => maxHeaderExtent;

  @override
  // TODO: implement minExtent
  double get minExtent => maxHeaderExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class FlexibleSpaceBarHeader extends StatelessWidget {
  const FlexibleSpaceBarHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 250,
      automaticallyImplyLeading: false,
      stretch: true,
      pinned: true,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        stretchModes: [StretchMode.zoomBackground],
        background: Stack(
          fit: StackFit.expand,
          children: [
            // BackgroundSliver(),
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: Image.network(
                    'https://thumbs.dreamstime.com/b/sushi-platter-14287709.jpg',
                  ).image,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Positioned(
              right: 10,
              top: 20,
              child: Icon(Icons.favorite, size: 30),
            ),
          ],
        ),
      ),
    );
  }
}
