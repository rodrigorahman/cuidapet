import 'package:cuidapet/app/models/category_model.dart';
import 'package:cuidapet/app/models/fornecedor_model.dart';
import 'package:cuidapet/app/shared/cuidapet_appbar.dart';
import 'package:cuidapet/app/shared/cuidapet_drawer.dart';
import 'package:cuidapet/app/utils/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  //use 'controller' variable to access controller
  PageController pageController = PageController(initialPage: 0);

  Map<String, IconData> categories = {'P': Icons.pets, 'V': Icons.local_hospital, 'C': Icons.store_mall_directory};

  @override
  void initState() {
    super.initState();
    controller.initPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CuidapetAppbar(
        context,
        width: MediaQuery.of(context).size.width * .9,
        callback: () => controller.initPage(),
        onTextChange: (text) => controller.filtrarFornecedoresPorNome(text),
      ),
      drawer: CuidapetDrawer(),
      backgroundColor: Colors.grey[100],
      body: RefreshIndicator(
        onRefresh: () => controller.findFornecedores(),
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                // _buildImagesPanel(),
                Observer(builder: (_) {
                  return Visibility(
                    visible: controller.addressSelected != null,
                    replacement: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text('Selecione um endereço', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 30)),
                    ),
                    child: Container(
                        padding: EdgeInsets.all(20),
                        child: Observer(builder: (_) {
                          return Column(
                            children: [
                              Text('Estabalecimentos próximos de '),
                              Text(
                                '${controller.addressSelected?.address}',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          );
                        })),
                  );
                }),
                _buildCategories(context),
                Observer(builder: (_) {
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: <Widget>[
                        Text('Estabelecimentos'),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () => pageController.previousPage(duration: Duration(milliseconds: 200), curve: Curves.ease),
                            child: Icon(
                              Icons.view_headline,
                              color: controller.selectedPage == 0 ? Colors.black : Colors.grey,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () => pageController.nextPage(duration: Duration(milliseconds: 200), curve: Curves.ease),
                            child: Icon(
                              Icons.view_comfy,
                              color: controller.selectedPage == 1 ? Colors.black : Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                Expanded(
                  child: PageView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: pageController,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (page) => controller.changeSelectedPage(page),
                    children: <Widget>[
                      _buildListaPets(),
                      _buildCardPets(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategories(BuildContext context) {
    return Observer(builder: (_) {
      return FutureBuilder<List<CategoryModel>>(
        future: controller.categoriesFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              height: 120,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data.length,
                itemBuilder: (_, index) {
                  var cat = snapshot.data[index];
                  return InkWell(
                    onTap: () => controller.filtrarFornecedoresPorCategoria(cat.id),
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: 80,
                            height: 80,
                            padding: const EdgeInsets.all(10.0),
                            child: Observer(builder: (_) {
                              return CircleAvatar(
                                backgroundColor: controller.selectedCategory == cat.id ? ThemeUtils.primaryColor : ThemeUtils.primaryColorLight,
                                child: Icon(categories[cat.tipo], size: 30, color: controller.selectedCategory == cat.id ? Colors.black : Colors.black),
                              );
                            }),
                          ),
                          Text(cat.nome)
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      );
    });
  }

  // Container _buildImagesPanel() {
  //   var images = ['assets/images/banho.jpg', 'assets/images/food.png', 'assets/images/vet.jpeg'];
  //   return Container(
  //     width: MediaQuery.of(context).size.width,
  //     height: 200,
  //     child: ListView.builder(
  //       itemCount: 3,
  //       itemBuilder: (_, index) {
  //         return Container(
  //           margin: EdgeInsets.only(top: 30, bottom: 30, left: index == 0 ? 40 : 10, right: 10),
  //           decoration:
  //               BoxDecoration(image: DecorationImage(image: AssetImage(images[index]), fit: BoxFit.cover), borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(blurRadius: 5, color: Colors.grey[300], offset: Offset(5, 5))]),
  //           width: MediaQuery.of(context).size.width * .8,
  //           height: 200,
  //         );
  //       },
  //       scrollDirection: Axis.horizontal,
  //     ),
  //   );
  // }
  Widget _buildCardPets() {
    return Observer(builder: (_) {
      return FutureBuilder<List<FornecedorModel>>(
          future: controller.fornecedoresFuture,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text(
                  'Nenhum Estabelecimento encontrado',
                  textAlign: TextAlign.center,
                );
                break;
              case ConnectionState.active:
                return Text(
                  'Nenhum Estabelecimento encontrado',
                  textAlign: TextAlign.center,
                );
                break;
              case ConnectionState.waiting:
                return Align(alignment: Alignment.topCenter, child: CircularProgressIndicator());
                break;
              case ConnectionState.done:
                return GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.1,
                  ),
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (_, index) {
                    var f = snapshot.data[index];
                    return Stack(
                      children: <Widget>[
                        Card(
                          margin: const EdgeInsets.only(top: 40.0, left: 10, right: 10),
                          elevation: 5,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          child: Container(
                              height: 120.0,
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 45.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Text(
                                      f.nome,
                                      style: Theme.of(context).textTheme.subtitle2,
                                    ),
                                    Text('${f.distancia.toStringAsFixed(2)} km de distância')
                                  ],
                                ),
                              )),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: CircleAvatar(radius: 40.0, backgroundColor: Colors.grey[200]),
                          ),
                        ),
                        Positioned(
                          top: 4,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: CircleAvatar(
                              radius: 35.0,
                              backgroundImage: NetworkImage(f.logo),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                );
                break;
            }
            return Container();
          });
    });
  }

  Widget _buildListaPets() {
    return Observer(builder: (_) {
      return FutureBuilder<List<FornecedorModel>>(
          future: controller.fornecedoresFuture,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text(
                  'Nenhum Estabelecimento encontrado',
                  textAlign: TextAlign.center,
                );
                break;
              case ConnectionState.active:
                return Text(
                  'Nenhum Estabelecimento encontrado',
                  textAlign: TextAlign.center,
                );
                break;
              case ConnectionState.waiting:
                return Align(alignment: Alignment.topCenter, child: CircularProgressIndicator());
                break;
              case ConnectionState.done:
                return ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (_, index) {
                    return Divider(
                      color: Colors.transparent,
                    );
                  },
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, index) {
                    var f = snapshot.data[index];
                    return FlatButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Modular.to.pushNamed('/estabelecimento/${f.id}');
                      },
                      child: Container(
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
                                        Text(f.nome),
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
                                            Text('${f.distancia.toStringAsFixed(2)} km de distância')
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
                                      border: Border.all(color: Colors.grey[100], width: 5), color: Colors.grey, borderRadius: BorderRadius.circular(100), image: DecorationImage(image: NetworkImage(f.logo), fit: BoxFit.cover)),
                                ),
                              ),
                            ),
                          ],
                        ),
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
                break;
            }
            return Container();
          });
    });
  }
}
