import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tgh_test/src/features/cart/cart_model.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  late Box<AddItemModel> cartBox;

  @override
  void initState() {
    super.initState();
    _openCartBox();
  }

  Future<void> _openCartBox() async {
    await Hive.openBox<AddItemModel>('addedItems');
    cartBox = Hive.box<AddItemModel>('addedItems');
  }

  void _removeItem(String itemName) {
    // Remove item from the cart
    setState(() {
      cartBox.delete(itemName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: FutureBuilder(
        future: _openCartBox(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartBox.length,
                    itemBuilder: (context, index) {
                      final addedItem = cartBox.getAt(index);
                      return ListTile(
                        title: Text(addedItem?.name ?? ''),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Quantity: ${addedItem?.quantity ?? 0}'),
                            Text(
                                'Total: \$${(addedItem?.price ?? 0) * (addedItem?.quantity ?? 0)}'),
                          ],
                        ),
                        leading: Image.network(
                          addedItem?.image ??
                              '', // Replace with your image field
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.remove_circle),
                          onPressed: () => _removeItem(addedItem?.name ?? ''),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Total: \$${_calculateTotalPrice()}'),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          // Place an order or navigate to checkout page
                        },
                        child: Text('Checkout'),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  double _calculateTotalPrice() {
    double total = 0.0;
    for (int i = 0; i < cartBox.length; i++) {
      final addedItem = cartBox.getAt(i);
      total += (addedItem?.price ?? 0) * (addedItem?.quantity ?? 0);
    }
    return total;
  }
}
