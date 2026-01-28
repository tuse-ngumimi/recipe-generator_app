import 'package:flutter/material.dart';
import '../model/meal.dart';
import '../repository/meal_repository.dart';
import '../detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final MealRepository _repository = MealRepository();
  final TextEditingController _searchController = TextEditingController();
  List<Meal> _meals = [];
  bool _isLoading = false;
  bool _showWelcome = true;

  @override
  void initState() {
    super.initState();
    _loadRandomMeal();
  }

  void _loadRandomMeal() async {
    setState(() {
      _isLoading = true;
      _showWelcome = false;
    });

    try {
      final meal = await _repository.getRandomMeal();
      setState(() {
        _meals = [meal];
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error loading meal: $e")),
        );
      }
    }
  }

  void _searchMeals() async {
    if (_searchController.text.isEmpty) {
      return;
    }

    setState(() {
      _isLoading = true;
      _showWelcome = false;
    });

    try {
      final meals = await _repository.searchMeals(_searchController.text);
      setState(() {
        _meals = meals;
        _isLoading = false;
      });

      if (meals.isEmpty && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No meals found")),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error searching: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.restaurant_menu, size: 28),
            SizedBox(width: 8),
            Text(
              "COOK'd",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // adds the search bar in the home page
          Container(
            padding: const EdgeInsets.all(16),
            color: const Color(0xFFFFF4E6),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: "Search for a recipe...",
                      prefixIcon: Icon(Icons.search, color: Color(0xFFFF8C42)),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    onSubmitted: (_) => _searchMeals(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _searchMeals,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF8C42),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("Search"),
                ),
              ],
            ),
          ),

          Expanded(
            child: _isLoading
                ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFFF8C42),
              ),
            )
                : _showWelcome
                ? _buildWelcomeScreen()
                : _meals.isEmpty
                ? _buildEmptyState()
                : _buildMealList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _loadRandomMeal,
        icon: const Icon(Icons.shuffle),
        label: const Text("Random Recipe"),
      ),
    );
  }

  Widget _buildWelcomeScreen() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.restaurant,
              size: 100,
              color: const Color(0xFFFF8C42).withOpacity(0.5),
            ),
            const SizedBox(height: 24),
            const Text(
              "Welcome to COOK'd!",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFF8C42),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Search for your favorite recipes or tap the button below to discover something new!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 80,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              "No recipes found",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Try searching for something else",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMealList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _meals.length,
      itemBuilder: (context, index) {
        final meal = _meals[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MealDetailScreen(mealId: meal.id),
                ),
              );
            },
            borderRadius: BorderRadius.circular(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // image of the meal
                if (meal.thumbnail != null)
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    child: Image.network(
                      meal.thumbnail!,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 200,
                          color: const Color(0xFFFFF4E6),
                          child: const Icon(
                            Icons.restaurant,
                            size: 80,
                            color: Color(0xFFFF8C42),
                          ),
                        );
                      },
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        meal.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          if (meal.category != null) ...[
                            const Icon(
                              Icons.category,
                              size: 16,
                              color: Color(0xFFFF8C42),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              meal.category!,
                              style: const TextStyle(
                                color: Colors.black54,
                              ),
                            ),
                          ],
                          if (meal.category != null && meal.area != null)
                            const SizedBox(width: 16),
                          if (meal.area != null) ...[
                            const Icon(
                              Icons.public,
                              size: 16,
                              color: Color(0xFFFF8C42),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              meal.area!,
                              style: const TextStyle(
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}