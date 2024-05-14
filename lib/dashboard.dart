import 'package:flutter/material.dart';
import 'package:ods_quest/nivel.dart';

final List<String> nombres = [
  'Fin de la pobreza', 'Hambre cero', 'Salud y bienestar', 'Educación de calidad', 'Igualdad de Género', 'Agua limpia y saneamiento', 'Energía asequible y no contaminante', 'Trabajo decente y crecimiento económico',
  'Industria, innovacion e infraestructura', 'Reducción de las desigualdades', 'ciudades y comunidades sostenibles', 'Producción y consumo responsables', 'Acción por el clima', 'Vida submarina', 'Vida de ecosistemas terrestres', 'Paz, justicia e instituciones Sólidas', 'Alianzas para lograr los objetivos'
];

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0; 
  late List<String> filteredNombres = nombres;

  void _filterNombres(String searchText) {
    setState(() {
      final searchTextLower = searchText.toLowerCase();
      filteredNombres = nombres.where((nombre) =>
        nombre.toLowerCase().contains(searchTextLower) || (nombres.indexOf(nombre) + 1).toString().contains(searchTextLower)
      ).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
        title: const Text(
          'ODS Quest',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
          backgroundColor: const Color(0xff60D3F2),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          toolbarHeight: 70,
        ),
        body: _buildBody(), 
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(

              icon: Icon(Icons.person),
              label: 'Perfil',


            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.casino),
              label: 'Random',

            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onTabTapped,
        ),
      ),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return _buildHomeView();
      case 1:
        return Container(); // Página de búsqueda vacía por ahora
      case 2:
        return Container(); // Página de perfil vacía por ahora
      default:
        return Container(); // Página vacía por defecto
    }
  }

  Widget _buildHomeView() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            onChanged: _filterNombres,
            decoration: const InputDecoration(
              labelText: 'Buscar',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: Color(0xff60D3F2), width: 4),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: Color.fromARGB(255, 169, 179, 182),),
              ),
              focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: Color(0xff60D3F2), width: 4),
                    ),
                    prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 1.0,
              ),
              itemCount: filteredNombres.length,
              itemBuilder: (context, index) {
                return _buildDashboardItem(context, filteredNombres[index]);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDashboardItem(BuildContext context, String itemName) {
    String imagePath = '';

    switch (itemName) {
      case 'Fin de la pobreza':
        imagePath = 'assets/S-WEB-Goal-01.png';
        break;
      case 'Hambre cero':
        imagePath = 'assets/S-WEB-Goal-02.png';
        break;
      case 'Salud y bienestar':
        imagePath = 'assets/S-WEB-Goal-03.png';
        break;
      case 'Educación de calidad':
        imagePath = 'assets/S-WEB-Goal-04.png';
        break;
      case 'Igualdad de Género':
        imagePath = 'assets/S-WEB-Goal-05.png';
        break;
      case 'Agua limpia y saneamiento':
        imagePath = 'assets/S-WEB-Goal-06.png';
        break;
      case 'Energía asequible y no contaminante':
        imagePath = 'assets/S-WEB-Goal-07.png';
        break;
      case 'Trabajo decente y crecimiento económico':
        imagePath = 'assets/S-WEB-Goal-08.png';
        break;
      case 'Industria, innovacion e infraestructura':
        imagePath = 'assets/S-WEB-Goal-09.png';
        break;
      case 'Reducción de las desigualdades':
        imagePath = 'assets/S-WEB-Goal-10.png';
        break;
      case 'ciudades y comunidades sostenibles':
        imagePath = 'assets/S-WEB-Goal-11.png';
        break;
      case 'Producción y consumo responsables':
        imagePath = 'assets/S-WEB-Goal-12.png';
        break;
      case 'Acción por el clima':
        imagePath = 'assets/S-WEB-Goal-13.png';
        break;
      case 'Vida submarina':
        imagePath = 'assets/S-WEB-Goal-14.png';
        break;
      case 'Vida de ecosistemas terrestres':
        imagePath = 'assets/S-WEB-Goal-15.png';
        break;
      case 'Paz, justicia e instituciones Sólidas':
        imagePath = 'assets/S-WEB-Goal-16.png';
        break;
      case 'Alianzas para lograr los objetivos':
        imagePath = 'assets/S-WEB-Goal-17.png';
        break;
      default:
        imagePath = 'assets/logo.png';
    }

    

  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Nivel(nombreObjetivo: itemName),
        ),
      );
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(30),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
      ),
    ),
  );
}


  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
