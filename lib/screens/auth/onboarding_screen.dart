import 'package:flutter/material.dart';  

class OnboardingScreen extends StatefulWidget {  
  const OnboardingScreen({super.key});  

  @override  
  State<OnboardingScreen> createState() => _OnboardingScreenState();  
}  

class _OnboardingScreenState extends State<OnboardingScreen> {  
  final PageController _pageController = PageController();  
  int _currentPage = 0;  

  final List<OnboardingItem> _items = [  
    OnboardingItem(  
      title: 'Welcome to Our Shop',  
      description: 'Discover amazing products from around the world',  
      image: 'assets/onboarding1.png',  
    ),  
    OnboardingItem(  
      title: 'Easy Shopping',  
      description: 'Shop with ease and get your items delivered to your doorstep',  
      image: 'assets/onboarding2.png',  
    ),  
    OnboardingItem(  
      title: 'Secure Payments',  
      description: 'Your payments are secure with our advanced payment system',  
      image: 'assets/onboarding3.png',  
    ),  
  ];  

  @override  
  void dispose() {  
    _pageController.dispose();  
    super.dispose();  
  }  

  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      body: SafeArea(  
        child: Column(  
          children: [  
            Expanded(  
              child: PageView.builder(  
                controller: _pageController,  
                itemCount: _items.length,  
                onPageChanged: (index) {  
                  setState(() {  
                    _currentPage = index;  
                  });  
                },  
                itemBuilder: (context, index) {  
                  return _OnboardingPage(item: _items[index]);  
                },  
              ),  
            ),  
            Padding(  
              padding: const EdgeInsets.all(24),  
              child: Column(  
                children: [  
                  Row(  
                    mainAxisAlignment: MainAxisAlignment.center,  
                    children: List.generate(  
                      _items.length,  
                      (index) => AnimatedContainer(  
                        duration: const Duration(milliseconds: 300),  
                        margin: const EdgeInsets.symmetric(horizontal: 4),  
                        height: 8,  
                        width: _currentPage == index ? 24 : 8,  
                        decoration: BoxDecoration(  
                          color: _currentPage == index  
                              ? Theme.of(context).colorScheme.primary  
                              : Theme.of(context).colorScheme.primary.withOpacity(0.2),  
                          borderRadius: BorderRadius.circular(4),  
                        ),  
                      ),  
                    ),  
                  ),  
                  const SizedBox(height: 32),  
                  Row(  
                    children: [  
                      if (_currentPage > 0)  
                        Expanded(  
                          child: OutlinedButton(  
                            onPressed: () {  
                              _pageController.previousPage(  
                                duration: const Duration(milliseconds: 300),  
                                curve: Curves.easeInOut,  
                              );  
                            },  
                            child: const Text('Previous'),  
                          ),  
                        ),  
                      if (_currentPage > 0) const SizedBox(width: 16),  
                      Expanded(  
                        child: FilledButton(  
                          onPressed: () {  
                            if (_currentPage < _items.length - 1) {  
                              _pageController.nextPage(  
                                duration: const Duration(milliseconds: 300),  
                                curve: Curves.easeInOut,  
                              );  
                            } else {  
                              Navigator.pushReplacementNamed(context, '/login');  
                            }  
                          },  
                          child: Text(  
                            _currentPage < _items.length - 1 ? 'Next' : 'Get Started',  
                          ),  
                        ),  
                      ),  
                    ],  
                  ),  
                  if (_currentPage < _items.length - 1) ...[  
                    const SizedBox(height: 16),  
                    TextButton(  
                      onPressed: () {  
                        Navigator.pushReplacementNamed(context, '/login');  
                      },  
                      child: const Text('Skip'),  
                    ),  
                  ],  
                ],  
              ),  
            ),  
          ],  
        ),  
      ),  
    );  
  }  
}  

class OnboardingItem {  
  final String title;  
  final String description;  
  final String image;  

  OnboardingItem({  
    required this.title,  
    required this.description,  
    required this.image,  
  });  
}  

class _OnboardingPage extends StatelessWidget {  
  final OnboardingItem item;  

  const _OnboardingPage({required this.item});  

  @override  
  Widget build(BuildContext context) {  
    return Padding(  
      padding: const EdgeInsets.all(24),  
      child: Column(  
        mainAxisAlignment: MainAxisAlignment.center,  
        children: [  
          Image.asset(  
            item.image,  
            height: 240,  
          ),  
          const SizedBox(height: 48),  
          Text(  
            item.title,  
            style: Theme.of(context).textTheme.headlineMedium,  
            textAlign: TextAlign.center,  
          ),  
          const SizedBox(height: 16),  
          Text(  
            item.description,  
            style: Theme.of(context).textTheme.bodyLarge,  
            textAlign: TextAlign.center,  
          ),  
        ],  
      ),  
    );  
  }  
}