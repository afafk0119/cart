import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tgh_test/src/features/cart/cart_model.dart';
import 'package:tgh_test/src/features/cart/cart_provider.dart';
import 'package:tgh_test/src/service/bottombar.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;

  final double rate;
  final int count;
  const ProductDetailsScreen(
      {super.key,
      required this.id,
      required this.title,
      required this.price,
      required this.description,
      required this.category,
      required this.image,
      required this.rate,
      required this.count});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  ValueNotifier<int> count = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.black,
            ),
            onPressed: () => {Navigator.pop(context)}),
        elevation: 0.0,
        title: Text(
          widget.category,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.black,
              ),
              onPressed: () => {})
        ],
      ),
      body:
          SafeArea(child: Consumer<Cartprovider>(builder: (context, model, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 30.h,
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 5.h),
                child: SizedBox(
                  height: 250.h,
                  width: 200.w,
                  child: Image.network(
                    widget.image,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18.r),
                    boxShadow: [
                      BoxShadow(
                        //offset: Offset(0, 4),

                        color: Colors.grey.shade200, //edited
                        spreadRadius: 1.r,
                        blurRadius: 1.r,
                        //edited
                      )
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        widget.title,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.w),
                          child: Text(
                            "\$" + widget.price.toString(),
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        Spacer(),
                        RatingBar.builder(
                          itemSize: 15,
                          initialRating: widget.rate,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (double value) {},
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.description,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ValueListenableBuilder(
                valueListenable: count,
                builder: (context, child, _) {
                  return Expanded(
                    child: SizedBox(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: count.value == 0
                            ? Container(
                                height: 50,
                                width: 350,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: ShapeDecoration(
                                  color: Colors.orangeAccent,
                                  shape: StadiumBorder(),
                                ),
                                child: Center(
                                  child: InkWell(
                                      onTap: () {
                                        count.value = 1;
                                      },
                                      child: Text(
                                        'Add to Cart',
                                        style: TextStyle(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      )),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 300,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      decoration: ShapeDecoration(
                                        color: Colors.orangeAccent,
                                        shape: StadiumBorder(),
                                      ),
                                      child: Center(
                                        child: InkWell(
                                          onTap: () {
                                            count.value = 1;
                                          },
                                          child: count.value == 0
                                              ? Text(
                                                  'Add to Cart',
                                                  style: TextStyle(
                                                      fontSize: 20.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                )
                                              : Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 15.w, right: 15.w),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      InkWell(
                                                          onTap: () {
                                                            count.value--;
                                                            model.cartorder(
                                                                widget.title
                                                                    .toString(),
                                                                count.value,
                                                                widget.id,
                                                                widget.price,
                                                                widget.image);
                                                          },
                                                          child: Icon(
                                                            Icons.remove,
                                                            color: Colors.white,
                                                            size: 16,
                                                          )),
                                                      Spacer(),
                                                      Text(
                                                        count.value.toString(),
                                                        style: TextStyle(
                                                            fontSize: 18.sp,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      Spacer(),
                                                      InkWell(
                                                          onTap: () async {
                                                            count.value++;
                                                            model.cartorder(
                                                                widget.title
                                                                    .toString(),
                                                                count.value,
                                                                widget.id,
                                                                widget.price,
                                                                widget.image);
                                                          },
                                                          child: Icon(
                                                            Icons.add,
                                                            color: Colors.white,
                                                            size: 16,
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    IconButton(
                                        iconSize: 40.sp,
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      BottomBar(
                                                        currentIndex: 1,
                                                      )));
                                        },
                                        icon: Icon(Icons.shopping_cart))
                                  ],
                                ),
                              ),
                      ),
                    ),
                  );
                }),
            SizedBox(
              height: 10.h,
            )
          ],
        );
      })),
    );
  }
}
