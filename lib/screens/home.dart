import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildHomeContent(),
          _buildOrdersContent(),
          _buildProfileContent(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        selectedItemColor: Color(0xFFE67E5C),
        unselectedItemColor: Colors.grey[500],
        backgroundColor: Colors.white,
        elevation: 12,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            activeIcon: Icon(Icons.shopping_bag),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildHomeContent() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 120,
          floating: false,
          pinned: true,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Color(0xFFE67E5C),
                child: Text('JD', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hi John Doe!', style: TextStyle(fontWeight: FontWeight.w600)),
                  Text('Let\'s find food for you', style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                ],
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: Stack(
                children: [
                  Icon(Icons.notifications_outlined),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                      constraints: BoxConstraints(minWidth: 12, minHeight: 12),
                      child: Text('2', style: TextStyle(color: Colors.white, fontSize: 10)),
                    ),
                  ),
                ],
              ),
              onPressed: () {},
            ),
          ],
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search food, restaurants...',
                      prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    ),
                  ),
                ),
                SizedBox(height: 32),

                Text('Categories', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                SizedBox(height: 20),
                SizedBox(
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildCategoryCard('All', '🍽️'),
                      _buildCategoryCard('Burgers', '🍔'),
                      _buildCategoryCard('Pizza', '🍕'),
                      _buildCategoryCard('Drinks', '🥤'),
                      _buildCategoryCard('Desserts', '🍰'),
                    ],
                  ),
                ),
                SizedBox(height: 32),

                // Popular Restaurants
                Text('Popular Restaurants', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                SizedBox(height: 20),

                ...List.generate(3, (index) => _buildRestaurantCard(index)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOrdersContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_bag_outlined, size: 80, color: Colors.grey[400]),
          SizedBox(height: 16),
          Text('No orders yet', style: TextStyle(fontSize: 20, color: Colors.grey[600])),
          Text('Order something delicious!', style: TextStyle(color: Colors.grey[500])),
        ],
      ),
    );
  }

  Widget _buildProfileContent() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 200,
          pinned: true,
          backgroundColor: Color(0xFFE67E5C),
          leading: IconButton(icon: Icon(Icons.menu), color: Colors.white, onPressed: () {}),
          actions: [IconButton(icon: Icon(Icons.settings), color: Colors.white, onPressed: () {})],
          flexibleSpace: FlexibleSpaceBar(
            title: Text('Profile', style: TextStyle(color: Colors.white)),
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFE67E5C), Color(0xFFD65A3F)],
                ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage('https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150'),
                ),
                SizedBox(height: 16),
                Text('John Doe', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Text('john.doe@email.com', style: TextStyle(color: Colors.grey[600])),
                SizedBox(height: 32),
                _buildProfileTile(Icons.person_outline, 'Personal Info'),
                _buildProfileTile(Icons.payment, 'Payment Methods'),
                _buildProfileTile(Icons.location_on, 'Addresses'),
                _buildProfileTile(Icons.history, 'Order History'),
                _buildProfileTile(Icons.favorite, 'Favorites'),
                _buildProfileTile(Icons.logout, 'Logout'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryCard(String title, String emoji) {
    return Container(
      width: 120,
      margin: EdgeInsets.only(right: 16),
      child: Column(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 12, offset: Offset(0, 4))],
            ),
            child: Center(child: Text(emoji, style: TextStyle(fontSize: 24))),
          ),
          SizedBox(height: 12),
          Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildRestaurantCard(int index) {
    final restaurants = [
      {'name': 'Burger King', 'rating': 4.8, 'distance': '1.2 km', 'image': 'burger.png'},
      {'name': 'Pizza Hut', 'rating': 4.6, 'distance': '0.8 km', 'image': 'pizza.png'},
      {'name': 'KFC', 'rating': 4.7, 'distance': '2.1 km', 'image': 'chicken.png'},
    ];

    final restaurant = restaurants[index];

    return Container(
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 16, offset: Offset(0, 8))],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(20),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            height: 80,
            width: 80,
            color: Color(0xFFE67E5C),
            child: Center(child: Text('🍔', style: TextStyle(fontSize: 32))),
          ),
        ),
        title: Text('Name', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Row(
          children: [
            Icon(Icons.star, color: Colors.amber, size: 16),
            Text('${restaurant!['rating']}'),
            SizedBox(width: 16),
            Icon(Icons.near_me, color: Colors.grey[500], size: 16),
          //  Text(restaurant['distance']!!!, style: TextStyle(color: Colors.grey[500])),
          ],
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey[400]),
      ),
    );
  }

  Widget _buildProfileTile(IconData icon, String title) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFF8F9FA),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: Color(0xFFE67E5C)),
        ),
        title: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        onTap: () {},
      ),
    );
  }
}
