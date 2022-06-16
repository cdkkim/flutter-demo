import 'package:flutter/material.dart';

class ShrinkTopListApp extends StatefulWidget {
  const ShrinkTopListApp({Key? key}) : super(key: key);

  @override
  _ShrinkTopListAppState createState() => _ShrinkTopListAppState();
}

class _ShrinkTopListAppState extends State<ShrinkTopListApp> {
  final scrollController = ScrollController();

  List<Character> characters = [
    Character('Goku', 'assets/shrink_top_list/goku.png', Colors.red),
    Character('Vegeta', 'assets/shrink_top_list/vegeta.png', Colors.blue),
    Character('Cell', 'assets/shrink_top_list/cell.png', Colors.deepPurple),
    Character('Maiin', 'assets/shrink_top_list/maiin.png', Colors.pink),
    Character('Freezer', 'assets/shrink_top_list/freezer.png', Colors.grey),
    Character('Son Goku', 'assets/shrink_top_list/son_goku.png', Colors.orange),
    Character('Small cell', 'assets/shrink_top_list/small_cell.png', Colors.green),
    Character('Dragon', 'assets/shrink_top_list/dragon.png', Colors.yellow),
  ];

  final itemSize = 150.0;

  @override
  void initState() {
    scrollController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shrink Top List'),
      ),
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: Placeholder(
              fallbackHeight: 100,
            ),
          ),
          SliverPersistentHeader(
            // pinned: true,
            delegate: CouponHeader(),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                var character = characters[index];
                // double itemSizeHalf = itemSize / 2;
                final itemPositionOffset = index * itemSize / 2;
                final diff = scrollController.offset - itemPositionOffset;
                final percent = 1 - (diff / itemSize);
                double opacity = percent;
                double scale = percent;

                if (percent > 1) {
                  opacity = 1.0;
                } else if (percent < 0.5) {
                  opacity = 0;
                } else {
                  opacity = 1 - (diff / itemSize * 2);
                }

                if (scale > 1) {
                  scale = 1.0;
                }

                return Align(
                  heightFactor: .6,
                  child: Opacity(
                    opacity: opacity,
                    child: Transform.scale(
                      alignment: Alignment.center,
                      scale: scale,
                      child: Container(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: Colors.blueGrey.withOpacity(.5),
                            blurRadius: 20.0, // soften the shadow
                            spreadRadius: 0, //extend the shadow
                            offset: Offset.zero,
                          )
                        ]),
                        child: Card(
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          color: character.color,
                          child: SizedBox(
                            height: itemSize,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    child: Text(
                                      character.name,
                                      style: TextStyle(color: Colors.white, fontSize: 25),
                                    ),
                                  ),
                                ),
                                Image.asset(character.image),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              childCount: characters.length,
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 400),
          )
        ],
      ),
    );
  }
}

class Character {
  String name;
  String image;
  Color color;

  Character(this.name, this.image, this.color);
}

class CouponHeader extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Text('Coupons');
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 100;

  @override
  // TODO: implement minExtent
  double get minExtent => 100;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
