import 'package:appp_sale_29092022/common/bases/base_widget.dart';
import 'package:appp_sale_29092022/common/utils/extension.dart';
import 'package:appp_sale_29092022/common/widgets/loading_widget.dart';
import 'package:appp_sale_29092022/data/datasources/remote/api_request.dart';
import 'package:appp_sale_29092022/data/model/cart.dart';
import 'package:appp_sale_29092022/data/repositories/order_repository.dart';
import 'package:appp_sale_29092022/presentation/features/order/order_bloc.dart';
import 'package:appp_sale_29092022/presentation/features/order/order_event.dart';
import 'package:appp_sale_29092022/presentation/features/order/orderdetail_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      appBar: AppBar(
        title: const Text("Lịch sử đơn hàng"),
        // leading:IconButton(icon: Icon(Icons.logout),
        //   onPressed: (){
        //   },
        // ),
      ),
      providers: [
        Provider(create: (context) => ApiRequest()),
        ProxyProvider<ApiRequest, OrderRepository>(
          create: (context) => OrderRepository(),
          update: (context, request, repository) {
            repository?.updateApiRequest(request);
            return repository!;
          },
        ),
        ProxyProvider<OrderRepository, OrderBloc>(
          create: (context) => OrderBloc(),
          update: (context, repository, bloc) {
            bloc?.updateOrderRepo(repository);
            return bloc!;
          },
        )
      ],
      child: OrderContainer(),
    );
  }
}

class OrderContainer extends StatefulWidget {
  const OrderContainer({Key? key}) : super(key: key);

  @override
  _OrderContainerState createState() => _OrderContainerState();
}

class _OrderContainerState extends State<OrderContainer> {
  late OrderBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read();
    bloc.eventSink.add(FetchOrderEvent());
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          StreamBuilder<List<Cart>>(
              initialData: [],
              stream: bloc.orders,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("Data is error");
                } else if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        return _buildItemOrder(snapshot.data?[index]);
                      });
                } else {
                  return Container();
                }
              }),
          LoadingWidget(child: Container(), bloc: bloc)
        ]);
  }

  Widget _buildItemOrder(Cart? cart,) {
    if (cart == null) return Container();
    return Container(
      height: 85,
      child: Card(
        elevation: 3,
        shadowColor: Colors.blueGrey,
        child: Container(
          padding: EdgeInsets.only(top: 5, bottom: 5),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.only(left: 5,right: 10),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Ngày mua: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(cart.date_created))}",
                                  style: TextStyle(fontSize: 20)),
                              Text("Tổng tiền: ${formatPrice(int.parse( cart.price.toString()))} đ",
                                  style: TextStyle(fontSize: 20)),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OrderDetailPage(cart: cart),
                                ),
                              );
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.resolveWith((states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    return Color.fromARGB(200, 240, 102, 61);
                                  } else {
                                    return Color.fromARGB(230, 240, 102, 61);
                                  }
                                }),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))))),
                            child:  Icon(Icons.remove_red_eye),
                          ),
                        ]
                    )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}