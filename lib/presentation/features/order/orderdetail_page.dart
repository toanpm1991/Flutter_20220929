
import 'package:appp_sale_29092022/common/constants/api_constant.dart';
import 'package:appp_sale_29092022/common/utils/extension.dart';
import 'package:appp_sale_29092022/data/model/cart.dart';
import 'package:appp_sale_29092022/data/model/product.dart';
import 'package:flutter/material.dart';



class OrderDetailPage extends StatelessWidget {
  const OrderDetailPage({Key? key, required this.cart}) : super(key: key);

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Chi tiết đơn hàng"),
      ),
      body: Container(

        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: SizedBox(
                height: 200.0,
                child: ListView.builder(
                    itemCount: cart.products.length,
                    itemBuilder: (context, index) {
                      return _buildItemFood(cart?.products[index] );
                    }),
              ),
            ),

            const SizedBox(height: 30),
            Column(
              children: [
                const Text("Tổng tiền của đơn hàng",
                  style:TextStyle(fontSize: 20),),
                const SizedBox(height: 10),
                Text("${formatPrice(
                    int.parse((cart.price??0)
                        .toString()))} đ",
                  style:const TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.red),
                  textAlign: TextAlign.right,),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildItemFood(Product? product) {
    if (product == null) return Container();
    return SizedBox(
      height: 135,
      child: Card(
        elevation: 5,
        shadowColor: Colors.blueGrey,
        child: Container(
          padding:const EdgeInsets.only(top: 5, bottom: 5),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(ApiConstant.BASE_URL + (product.img),
                    width: 150, height: 120, fit: BoxFit.fill),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(product.name.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:const TextStyle(fontSize: 16)),
                      ),
                      Text("Giá : ${formatPrice(product.price)} đ",
                          style:const TextStyle(fontSize: 14)),
                      Row(
                        children:[
                          Text("Số lượng : ${formatPrice(product.quantity)}    ",
                              style:const TextStyle(fontSize: 14)),
                        ] ,
                      ),
                      Text("Thành tiền : ${formatPrice((product.quantity) * (product.price))}",
                          style: const TextStyle(fontSize: 14)),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
