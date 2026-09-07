import 'package:flutter/material.dart';

import 'data/mock_data.dart';
import 'models/models.dart';
import 'screens/client_detail_screen.dart';
import 'screens/client_form_screen.dart';
import 'screens/clients_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/login_screen.dart';
import 'screens/more_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/product_form_screen.dart';
import 'screens/products_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MinhaRevendaApp());
}

class MinhaRevendaApp extends StatelessWidget {
  const MinhaRevendaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minha Revenda',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: const LoginWrapper(),
    );
  }
}

class LoginWrapper extends StatelessWidget {
  const LoginWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return LoginScreen(
      onLogin: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const MainScreen(),
          ),
        );
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  late List<Client> clients;
  late List<Product> products;

  @override
  void initState() {
    super.initState();

    clients = List<Client>.from(initialClients);
    products = List<Product>.from(initialProducts);
  }

  void goTo(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void addClient() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ClientFormScreen(
          onSave: (client) {
            setState(() {
              clients.add(client);
            });
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  void editClient(Client client) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ClientFormScreen(
          client: client,
          onSave: (updatedClient) {
            setState(() {
              final index = clients.indexOf(client);

              if (index != -1) {
                clients[index] = updatedClient;
              }
            });

            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  void deleteClient(Client client) {
    setState(() {
      clients.remove(client);
    });
  }

  void showClient(Client client) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ClientDetailScreen(
          client: client,
          onEdit: () {
            Navigator.pop(context);
            editClient(client);
          },
          onDelete: () {
            Navigator.pop(context);
            deleteClient(client);
          },
        ),
      ),
    );
  }

  void addProduct() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductFormScreen(
          onSave: (product) {
            setState(() {
              products.add(product);
            });
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  void editProduct(Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductFormScreen(
          product: product,
          onSave: (updatedProduct) {
            setState(() {
              final index = products.indexOf(product);

              if (index != -1) {
                products[index] = updatedProduct;
              }
            });

            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  void deleteProduct(Product product) {
    setState(() {
      products.remove(product);
    });
  }

  void showProduct(Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductDetailScreen(
          product: product,
          onEdit: () {
            Navigator.pop(context);
            editProduct(product);
          },
          onDelete: () {
            Navigator.pop(context);
            deleteProduct(product);
          },
        ),
      ),
    );
  }

  Widget currentScreen() {
    switch (selectedIndex) {
      case 0:
        return DashboardScreen(
          clientCount: clients.length,
          productCount: products.length,
          onNewClient: addClient,
          onNewProduct: addProduct,
          onClients: () => goTo(1),
          onProducts: () => goTo(2),
        );

      case 1:
        return ClientsScreen(
          clients: clients,
          onDetail: showClient,
          onEdit: editClient,
          onDelete: deleteClient,
          onNew: addClient,
        );

      case 2:
        return ProductsScreen(
          products: products,
          onDetail: showProduct,
          onEdit: editProduct,
          onDelete: deleteProduct,
          onNew: addProduct,
        );

      case 3:
        return MoreScreen(
          onLogout: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => const LoginWrapper(),
              ),
              (route) => false,
            );
          },
        );

      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: currentScreen(),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: goTo,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people),
            label: 'Clientes',
          ),
          NavigationDestination(
            icon: Icon(Icons.inventory_2_outlined),
            selectedIcon: Icon(Icons.inventory_2),
            label: 'Produtos',
          ),
          NavigationDestination(
            icon: Icon(Icons.more_horiz),
            selectedIcon: Icon(Icons.more),
            label: 'Mais',
          ),
        ],
      ),
    );
  }
}