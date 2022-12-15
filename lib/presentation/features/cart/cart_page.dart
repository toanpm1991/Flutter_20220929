import 'package:appp_sale_29092022/common/bases/base_widget.dart';
import 'package:appp_sale_29092022/common/constants/api_constant.dart';
import 'package:appp_sale_29092022/common/utils/extension.dart';
import 'package:appp_sale_29092022/common/widgets/loading_widget.dart';
import 'package:appp_sale_29092022/data/datasources/remote/api_request.dart';
import 'package:appp_sale_29092022/data/model/cart.dart';
import 'package:appp_sale_29092022/data/model/product.dart';
import 'package:appp_sale_29092022/data/repositories/cart_repository.dart';
import 'package:appp_sale_29092022/presentation/features/cart/cart_bloc.dart';
import 'package:appp_sale_29092022/presentation/features/cart/cart_event.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      appBar: AppBar(
        title: const Text("Giỏ hàng"),
        // leading:IconButton(icon: Icon(Icons.logout),
        //   onPressed: (){
        //   },
        // ),
      ),
      providers: [
        Provider(create: (context) => ApiRequest()),
        ProxyProvider<ApiRequest, CartRepository>(
          create: (context) => CartRepository(),
          update: (context, request, repository) {
            repository?.updateApiRequest(request);
            return repository!;
          },
        ),
        ProxyProvider<CartRepository, CartBloc>(
          create: (context) => CartBloc(),
          update: (context, repository, bloc) {
            bloc?.updateCartRepo(repository);
            return bloc!;
          },
        )
      ],
      child: CartContainer(),
    );
  }
}


class CartContainer extends StatefulWidget {
  const CartContainer({Key? key}) : super(key: key);

  @override
  _CartContainerState createState() => _CartContainerState();
}

class _CartContainerState extends State<CartContainer> {
  late CartBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read();
    bloc.eventSink.add(FetchCartEvent());
  }


  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      StreamBuilder<Cart>(
          stream: bloc.cart,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("Data is error");
            }
            else if(snapshot.hasData) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data?.products.length ?? 0,
                    itemBuilder: (context, index) {
                      return _buildItemFood(snapshot.data?.products[index]);
                    });
              }
              else {
                return Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Giỏ hàng của bạn chưa có sản phẩm!",
                              style: TextStyle(fontSize: 20),)
                          ]),
                    )
                );
              }
            }
            else {
              return Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Giỏ hàng của bạn chưa có sản phẩm!",
                            style: TextStyle(fontSize: 20),)
                        ]),
                  )
              );
            }

          }),
      LoadingWidget(child: Container(), bloc: bloc)
    ]);
  }

  Widget _buildItemFood(Product? product) {
    if (product == null) return Container();
    return Container(
      height: 135,
      child: Card(
        elevation: 5,
        shadowColor: Colors.blueGrey,
        child: Container(
          padding: EdgeInsets.only(top: 5, bottom: 5),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(ApiConstant.BASE_URL + (product.img??""),
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
                            style: TextStyle(fontSize: 16)),
                      ),
                      Text("Giá : ${formatPrice(product.price??0)} đ",
                          style: TextStyle(fontSize: 14)),
                      Row(
                        children:[
                          Text("Số lượng : ${formatPrice(product.quantity??0)}    ",
                            style: TextStyle(fontSize: 14)),
                          ElevatedButton(

                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size.zero, // Set this
                            ),
                            child:
                            Text("+", style: TextStyle(fontSize: 20)),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size.zero, // Set this
                            ),
                            child:
                            Text("-", style: TextStyle(fontSize: 20)),
                          ),
                        ] ,
                      ),
                      Text("Thành tiền : ${formatPrice((product.quantity??0) * (product.price??0))}",
                          style: TextStyle(fontSize: 14)),
                      // ElevatedButton(
                      //   onPressed: () {},
                      //   style: ButtonStyle(
                      //       backgroundColor:
                      //       MaterialStateProperty.resolveWith((states) {
                      //         if (states.contains(MaterialState.pressed)) {
                      //           return Color.fromARGB(200, 240, 102, 61);
                      //         } else {
                      //           return Color.fromARGB(230, 240, 102, 61);
                      //         }
                      //       }),
                      //       shape: MaterialStateProperty.all(
                      //           RoundedRectangleBorder(
                      //               borderRadius: BorderRadius.all(
                      //                   Radius.circular(10))))),
                      //   child:
                      //   Text("Thêm vào giỏ", style: TextStyle(fontSize: 14)),
                      // ),
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
