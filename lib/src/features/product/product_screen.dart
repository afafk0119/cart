import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tgh_test/src/features/product/productprovider.dart';
import 'package:tgh_test/src/features/product_details/product_details_screen.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    Future.microtask(() => context.read<Productprovider>()..productapi());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          "Product",
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
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Consumer<Productprovider>(builder: (context, model, _) {
            return model.loginloading == false
                ? Expanded(
                    child: SizedBox(
                      child: GridView.builder(
                          padding: EdgeInsets.all(11),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 15,
                                  mainAxisSpacing: 20,
                                  mainAxisExtent: 150.h),
                          itemCount: model.responseData!.length,
                          itemBuilder: (BuildContext context, int index) {
                            List<ValueNotifier<int>> _itemCount = List.generate(
                              model.responseData!.length,
                              (index) => ValueNotifier<int>(0),
                            );
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProductDetailsScreen(
                                              id: model.responseData![index].id,
                                              description: model
                                                  .responseData![index]
                                                  .description
                                                  .toString(),
                                              count: model.responseData![index]
                                                  .rating.count,
                                              price: model
                                                  .responseData![index].price,
                                              rate: model.responseData![index]
                                                  .rating.rate,
                                              category: model
                                                  .responseData![index].category
                                                  .toString(),
                                              title: model
                                                  .responseData![index].title
                                                  .toString(),
                                              image: model
                                                  .responseData![index].image
                                                  .toString(),
                                            )));
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
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
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 5.h),
                                      child: SizedBox(
                                        height: 70.h,
                                        width: 70.w,
                                        child: Image.network(
                                          "${model.responseData![index].image.toString()}",
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent?
                                                  loadingProgress) {
                                            if (loadingProgress == null)
                                              return child;
                                            return Center(
                                              child: CircularProgressIndicator(
                                                value: loadingProgress
                                                            .expectedTotalBytes !=
                                                        null
                                                    ? loadingProgress
                                                            .cumulativeBytesLoaded /
                                                        loadingProgress
                                                            .expectedTotalBytes!
                                                    : null,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 120.w,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  model.responseData![index]
                                                      .title
                                                      .toString(),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 10.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black)),
                                              SizedBox(
                                                height: 2.h,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.black12,
                    ),
                  );
          }),
        ],
      )),
    );
  }
}
