import 'package:flutter/material.dart';

void main() {
  runApp(const FoodMenuApp());
}

class FoodMenuApp extends StatelessWidget {
  const FoodMenuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menu Makanan Nusantara',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        scaffoldBackgroundColor: const Color(0xFFFFF8E1),
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      home: const MainNavigation(),
    );
  }
}

/// 🔹 NAVIGASI BAWAH GLOBAL
class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;
  List<Map<String, dynamic>> cart = [];

  void _addToCart(Map<String, dynamic> food) {
    setState(() => cart.add(food));
  }

  void _removeFromCart(Map<String, dynamic> item) {
    setState(() => cart.remove(item));
  }

  void _clearCart() {
    setState(() => cart.clear());
  }

  double get totalPrice =>
      cart.fold(0, (sum, item) => sum + (item["price"] as double));

  @override
  Widget build(BuildContext context) {
    final pages = [
      FoodMenuPage(onAddToCart: _addToCart),
      CartPage(
        cart: cart,
        onRemoveItem: _removeFromCart,
        onClearCart: _clearCart,
        totalPrice: totalPrice,
      ),
      const ProfilePage(),
    ];

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}

/// 🔹 HALAMAN MENU MAKANAN
class FoodMenuPage extends StatefulWidget {
  final Function(Map<String, dynamic>) onAddToCart;
  const FoodMenuPage({super.key, required this.onAddToCart});

  @override
  State<FoodMenuPage> createState() => _FoodMenuPageState();
}

class _FoodMenuPageState extends State<FoodMenuPage> {
  String query = "";

  final List<Map<String, dynamic>> foods = [
    {
      "name": "Nasi Goreng Spesial",
      "image": "assets/images/nasi goreng.jpg",
      "desc": "Nasi goreng klasik dengan telur, ayam, dan bumbu rempah khas Indonesia.",
      "price": 25000.0,
      "rating": 4.8
    },
    {
      "name": "Ayam Penyet",
      "image": "assets/images/ayam penyet.jpg",
      "desc": "Ayam goreng yang digeprek dengan sambal pedas, disajikan dengan lalapan segar.",
      "price": 28000.0,
      "rating": 4.7
    },
    {
      "name": "Sate Ayam Madura",
      "image": "assets/images/sate ayam.jpg",
      "desc": "Potongan daging ayam bakar dengan bumbu kacang gurih khas Madura.",
      "price": 30000.0,
      "rating": 4.9
    },
    {
      "name": "Bakso Malang",
      "image": "assets/images/bakso.jpg",
      "desc": "Bakso sapi kenyal dengan kuah kaldu gurih, tahu dan siomay pelengkap.",
      "price": 22000.0,
      "rating": 4.6
    },
    {
      "name": "Soto Ayam",
      "image": "assets/images/soto ayam.jpg",
      "desc": "Soto dengan kuah kuning segar, suwiran ayam, bihun, dan taburan bawang goreng.",
      "price": 23000.0,
      "rating": 4.7
    },
    {
      "name": "Rendang Padang",
      "image": "assets/images/rendang.jpg",
      "desc": "Daging sapi empuk dimasak lama dengan santan dan rempah kaya rasa khas Minang.",
      "price": 35000.0,
      "rating": 5.0
    },
    {
      "name": "Tumis Kangkung",
      "image": "assets/images/tumis kangkung.jpg",
      "desc": "Kangkung tumis dengan bawang putih, cabai, dan saus tiram sederhana namun nikmat.",
      "price": 14000.0,
      "rating": 4.5
    },
    {
      "name": "Tempe Mendoan",
      "image": "assets/images/tempe mendoan.jpg",
      "desc": "Tempe goreng setengah matang dengan adonan tepung tipis, khas Banyumas.",
      "price": 12000.0,
      "rating": 4.5
    },
    {
      "name": "Sambal Terasi",
      "image": "assets/images/sambal.jpg",
      "desc": "Sambal pedas menggoda dari cabai merah, bawang, dan terasi panggang.",
      "price": 8000.0,
      "rating": 4.6
    },
    {
      "name": "Ikan Bandeng Goreng",
      "image": "assets/images/ikan bandeng goreng.jpg",
      "desc": "Bandeng goreng garing dengan rasa gurih dan sambal tomat pedas.",
      "price": 30000.0,
      "rating": 4.6
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredFoods = foods
        .where((food) =>
            food["name"].toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: const Text("🍛 Menu Makanan Nusantara",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 🔍 Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.brown),
                hintText: "Cari makanan Nusantara...",
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) => setState(() => query = value),
            ),
          ),
          // 🍽️ Grid Makanan
          Expanded(
            child: filteredFoods.isEmpty
                ? const Center(child: Text("Makanan tidak ditemukan 🍽️"))
                : GridView.builder(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 14,
                      crossAxisSpacing: 14,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: filteredFoods.length,
                    itemBuilder: (context, index) {
                      final food = filteredFoods[index];
                      return FoodCard(
                        name: food["name"],
                        imagePath: food["image"],
                        description: food["desc"],
                        price: food["price"],
                        rating: food["rating"],
                        onAddToCart: () => widget.onAddToCart(food),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

/// 🔹 KARTU MAKANAN
class FoodCard extends StatelessWidget {
  final String name;
  final String imagePath;
  final String description;
  final double price;
  final double rating;
  final VoidCallback onAddToCart;

  const FoodCard({
    super.key,
    required this.name,
    required this.imagePath,
    required this.description,
    required this.price,
    required this.rating,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => FoodDetailPage(
              name: name,
              imagePath: imagePath,
              description: description,
              price: price,
              rating: rating,
              onAddToCart: onAddToCart,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(2, 4))
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: AspectRatio(
                aspectRatio: 1.2,
                child: Image.asset(imagePath, fit: BoxFit.contain),
              ),
            ),
            const SizedBox(height: 6),
            Text(name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xFFD84315))),
            Text("Rp ${price.toStringAsFixed(0)}",
                style: const TextStyle(
                    color: Colors.brown, fontWeight: FontWeight.w500)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 16),
                Text(rating.toString(),
                    style:
                        const TextStyle(fontSize: 13, color: Colors.black87)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// 🔹 DETAIL MAKANAN
class FoodDetailPage extends StatelessWidget {
  final String name;
  final String imagePath;
  final String description;
  final double price;
  final double rating;
  final VoidCallback onAddToCart;

  const FoodDetailPage({
    super.key,
    required this.name,
    required this.imagePath,
    required this.description,
    required this.price,
    required this.rating,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E1),
      appBar: AppBar(
        title: Text(name),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(30)),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.asset(imagePath, fit: BoxFit.contain),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Color(0xFFD84315))),
                  const SizedBox(height: 10),
                  Text("Rp ${price.toStringAsFixed(0)}",
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.brown)),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 20),
                      Text(rating.toString(),
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black87)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(description,
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black87)),
                  const SizedBox(height: 30),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        onAddToCart();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text("$name ditambahkan ke pesanan 🧾"),
                          duration: const Duration(seconds: 1),
                        ));
                      },
                      icon: const Icon(Icons.add_shopping_cart),
                      label: const Text("Tambah ke Pesanan"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD84315),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 🔹 HALAMAN KERANJANG
class CartPage extends StatelessWidget {
  final List<Map<String, dynamic>> cart;
  final Function(Map<String, dynamic>) onRemoveItem;
  final VoidCallback onClearCart;
  final double totalPrice;

  const CartPage({
    super.key,
    required this.cart,
    required this.onRemoveItem,
    required this.onClearCart,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("🛒 Keranjang Pesanan"),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: cart.isEmpty
          ? const Center(
              child: Text("Keranjang masih kosong 🍽️",
                  style: TextStyle(fontSize: 16, color: Colors.grey)))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final item = cart[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child:
                          Image.asset(item["image"], width: 60, fit: BoxFit.cover),
                    ),
                    title: Text(item["name"],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    subtitle:
                        Text("Rp ${item["price"].toStringAsFixed(0)}"),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: () => onRemoveItem(item),
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: cart.isEmpty
          ? null
          : Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(color: Color(0xFFFFF3E0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total: Rp ${totalPrice.toStringAsFixed(0)}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18)),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.delete_forever,
                            color: Colors.redAccent),
                        onPressed: onClearCart,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Pesanan dikonfirmasi ✅"),
                            duration: Duration(seconds: 2),
                          ));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrange,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text("Pesan Sekarang"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}

/// 🔹 HALAMAN PROFIL
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("👤 Profil Pembeli"),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/profile.jpg'),
            ),
            const SizedBox(height: 16),
            const Text("Nama: Ade Barkah",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Text("Alamat: Jl. Merdeka No. 45, Garut"),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Fitur ubah profil akan datang 👀"),
                  duration: Duration(seconds: 1),
                ));
              },
              icon: const Icon(Icons.edit),
              label: const Text("Ubah Profil"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
