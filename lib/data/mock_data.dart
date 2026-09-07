import '../models/models.dart';

final List<Client> initialClients = [
  Client(
    id: '1',
    name: 'Ana Souza',
    phone: '(91) 99999-0000',
    email: 'ana@email.com',
    cpf: '123.456.789-00',
    address: 'Rua das Flores, 45 - Belém, PA',
  ),
  Client(
    id: '2',
    name: 'Carlos Oliveira',
    phone: '(91) 98888-0000',
    email: 'carlos@email.com',
    cpf: '987.654.321-00',
    address: 'Av. Nazaré, 200 - Belém, PA',
  ),
  Client(
    id: '3',
    name: 'Mariana Lima',
    phone: '(91) 97777-0001',
    email: 'mariana@email.com',
    cpf: '456.789.123-00',
    address: 'Travessa Aurora, 12 - Belém, PA',
  ),
  Client(
    id: '4',
    name: 'Juliana Costa',
    phone: '(91) 96666-0002',
    email: 'juliana@email.com',
    cpf: '321.654.987-00',
    address: 'Rua Monsenhor Coutinho, 78 - Belém, PA',
  ),
];

final List<Product> initialProducts = [
  Product(
    id: '1',
    name: 'Hidratante Corporal Nativa SPA',
    brand: 'O Boticário',
    sku: 'BOT-001',
    costPrice: 22.90,
    salePrice: 39.90,
    quantity: 8,
    category: 'Cuidados Corporais',
  ),
  Product(
    id: '2',
    name: 'Perfume Feminino Essencial',
    brand: 'Natura',
    sku: 'NAT-042',
    costPrice: 55.00,
    salePrice: 89.90,
    quantity: 4,
    category: 'Perfumaria',
  ),
  Product(
    id: '3',
    name: 'Creme Anti-idade Renew',
    brand: 'Avon',
    sku: 'AVN-018',
    costPrice: 18.50,
    salePrice: 34.90,
    quantity: 12,
    category: 'Cuidados Faciais',
  ),
  Product(
    id: '4',
    name: 'Batom Mate FPS 15',
    brand: 'Mary Kay',
    sku: 'MK-033',
    costPrice: 12.00,
    salePrice: 24.90,
    quantity: 6,
    category: 'Maquiagem',
  ),
];
