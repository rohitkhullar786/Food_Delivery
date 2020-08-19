import 'package:flutter/material.dart';

import '../data/data.dart';
import '../models/order.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  buildCartItems(Order order) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(),
        margin: EdgeInsets.all(1),
        height: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image(
                height: 130,
                width: 130,
                image: AssetImage(order.food.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.food.name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  order.restaurant.name,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black54,
                        width: 0.8,
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (order.quantity > 0) {
                              order.quantity--;
                            }
                          });
                        },
                        child: Text(
                          '-',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 35,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(
                        order.quantity.toString(),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                               if (order.quantity < 10) {
                              order.quantity++;
                            }
                          });
                        },
                        child: Text(
                          '+',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 30,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Text(
              '\$${order.food.price * order.quantity.toDouble()}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = 0;

    currentUser.cart.forEach((Order order) {
      totalPrice = totalPrice + order.quantity * order.food.price;
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart(${currentUser.orders.length})',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
              itemCount: currentUser.cart.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index < currentUser.cart.length) {
                  Order order = currentUser.cart[index];
                  return buildCartItems(order);
                }
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Estimated Time Delivery:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '25 mins',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Cost',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '\$${totalPrice.toStringAsFixed(2)}',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.green),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 100,
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  height: 1,
                  color: Colors.grey,
                );
              },
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        height: 80,
        width: MediaQuery.of(context).size.width,
        color: Theme.of(context).primaryColor,
        child: FlatButton(
          child: Text(
            'CHECKOUT',
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
