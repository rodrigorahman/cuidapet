import 'package:cuidapet/app/modules/address/address_page.dart';
import 'package:cuidapet/app/shared/cuidapet_appbar.dart';
import 'package:cuidapet/app/shared/cuidapet_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  //use 'controller' variable to access controller

  @override
  void initState() {
    super.initState();

    controller.hasAddress().then((hasAddress){
      if(!hasAddress) {
        Navigator.push(context, MaterialPageRoute(fullscreenDialog: true, builder: (_) => AddressPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CuidapetAppbar(context, width: MediaQuery.of(context).size.width * .9),
      drawer: CuidapetDrawer(),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              _buildImagesPanel(),
              _buildCategories(context),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: <Widget>[
                    Text('Pets'),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.view_comfy,
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.view_headline, color: Colors.grey),
                    )
                  ],
                ),
              ),
              Expanded(child: _buildListaPets()),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildCategories(BuildContext context) {
    return Container(
      height: 120,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: List.generate(4, (i) => i++)
            .map(
              (i) => Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 80,
                      height: 80,
                      padding: const EdgeInsets.all(10.0),
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/images/banho.jpg'),
                      ),
                    ),
                    Text('Categoria X')
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Container _buildImagesPanel() {
    var images = ['assets/images/banho.jpg', 'assets/images/food.png', 'assets/images/vet.jpeg'];
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (_, index) {
          return Container(
            margin: EdgeInsets.only(top: 30, bottom: 30, left: index == 0 ? 40 : 10, right: 10),
            decoration:
                BoxDecoration(image: DecorationImage(image: AssetImage(images[index]), fit: BoxFit.cover), borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(blurRadius: 5, color: Colors.grey[300], offset: Offset(5, 5))]),
            width: MediaQuery.of(context).size.width * .8,
            height: 200,
          );
        },
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget _buildListaPets() {
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (_, index) {
        return Divider(
          color: Colors.transparent,
        );
      },
      itemCount: 10,
      itemBuilder: (_, index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 30),
                width: MediaQuery.of(context).size.width,
                height: 80,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('PETX'),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.location_on,
                                size: 18,
                                color: Colors.grey[500],
                              ),
                              Text('3km de distância')
                            ],
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: CircleAvatar(
                        maxRadius: 15,
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 15,
                        ),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.transparent, width: 1),
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[100], width: 5), color: Colors.grey, borderRadius: BorderRadius.circular(100), image: DecorationImage(image: AssetImage('assets/images/food.png'), fit: BoxFit.cover)),
                  ),
                ),
              ),
            ],
          ),
        );
        // return ListTile(
        //   title: Text('teste'),
        //   subtitle: Text('teste'),
        //   trailing: CircleAvatar(
        //     maxRadius: 15,
        //     backgroundColor: Theme.of(context).primaryColor,
        //     child: Icon(
        //       Icons.arrow_back_ios,
        //       color: Colors.white,
        //       size: 20,
        //     ),
        //   ),
        // );
      },
    );
  }
}
