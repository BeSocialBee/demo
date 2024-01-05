import 'package:flutter/material.dart';
import 'package:hidding_bottom_navigation_bar/hidding_bottom_navigation_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HiddingBottomNavBarExample());
  }
}

class HiddingBottomNavBarExample extends StatefulWidget {
  const HiddingBottomNavBarExample({super.key});

  @override
  State<HiddingBottomNavBarExample> createState() =>
      _HiddingBottomNavBarExampleState();
}

class _HiddingBottomNavBarExampleState
    extends State<HiddingBottomNavBarExample> {
  //1. Declaramos el ScrollController
  final scrollController = ScrollController();
  late final List<Widget> _pages = [
    _Home(scrollController: scrollController),
    const _Tasks(),
    const _Settings()
  ];
  //   Para actualizar la página en la que estamos al pulsar sobre los
  //   elementos del HiddingBottomNavigationBar.
  int index = 0;
  void setIndex(int position) => setState(() => index = position);

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[index],
      bottomNavigationBar: HiddingBottomNavigationBar(
        //3. Le pasamos el scrollController, de igual manera que hemos hecho con el
        //   ListView. Con esto tendremos el Scrolling que se realice dentro del ListView
        //   conectado con nuestro HiddingBottomNavigationBar... y vualá!
        scrollController: scrollController,
        height: 70,
        type: FlexibleBottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: 'Tasks'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
        onTap: setIndex,
        currentIndex: index,
        onAppear: () => print('ESTOY APARECIENDO'),
        onHide: () => print('ESTOY DESAPARECIENDO'),
      ),
    );
  }
}

class _Tasks extends StatelessWidget {
  const _Tasks({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Tasks'),
    );
  }
}

class _Settings extends StatelessWidget {
  const _Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('settings'),
    );
  }
}

class _Home extends StatelessWidget {
  const _Home({
    super.key,
    required this.scrollController,
  });

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        //2. Le pasamos el scrollController al ListView. Esto es esencial!
        controller: scrollController,
        separatorBuilder: (context, index) => const Divider(color: Colors.grey),
        itemCount: 150,
        itemBuilder: (ctx, i) {
          return SizedBox(
            height: 50,
            child: Text('Elemento número ${i + 1} de Home'),
          );
        });
  }
}