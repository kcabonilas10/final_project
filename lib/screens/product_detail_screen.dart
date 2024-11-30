import 'package:flutter/material.dart';  

class ProductDetailScreen extends StatelessWidget {  
  final int productId;  

  const ProductDetailScreen({  
    super.key,  
    required this.productId,  
  });  

  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      body: CustomScrollView(  
        slivers: [  
          SliverAppBar.large(  
            expandedHeight: 400,  
            pinned: true,  
            actions: [  
              IconButton(  
                icon: const Icon(Icons.share),  
                onPressed: () {  
                  // Implement share functionality  
                },  
              ),  
              IconButton(  
                icon: const Icon(Icons.favorite_border),  
                onPressed: () {  
                  // Implement wishlist functionality  
                },  
              ),  
            ],  
            flexibleSpace: FlexibleSpaceBar(  
              background: Hero(  
                tag: 'product-$productId',  
                child: Image.network(  
                  'https://via.placeholder.com/400',  
                  fit: BoxFit.cover,  
                ),  
              ),  
            ),  
          ),  
          SliverToBoxAdapter(  
            child: Padding(  
              padding: const EdgeInsets.all(16),  
              child: Column(  
                crossAxisAlignment: CrossAxisAlignment.start,  
                children: [  
                  Row(  
                    children: [  
                      Expanded(  
                        child: Text(  
                          'Product Name',  
                          style: Theme.of(context).textTheme.headlineSmall,  
                        ),  
                      ),  
                      Text(  
                        '\$99.99',  
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(  
                              color: Theme.of(context).colorScheme.primary,  
                            ),  
                      ),  
                    ],  
                  ),  
                  const SizedBox(height: 8),  
                  Row(  
                    children: [  
                      const Icon(Icons.star, size: 20, color: Colors.amber),  
                      const SizedBox(width: 4),  
                      const Text('4.5'),  
                      const SizedBox(width: 8),  
                      Text(  
                        '(123 reviews)',  
                        style: Theme.of(context).textTheme.bodySmall,  
                      ),  
                    ],  
                  ),  
                  const SizedBox(height: 16),  
                  const Text(  
                    'Description',  
                    style: TextStyle(  
                      fontSize: 18,  
                      fontWeight: FontWeight.bold,  
                    ),  
                  ),  
                  const SizedBox(height: 8),  
                  const Text(  
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',  
                  ),  
                  const SizedBox(height: 16),  
                  const Text(  
                    'Specifications',  
                    style: TextStyle(  
                      fontSize: 18,  
                      fontWeight: FontWeight.bold,  
                    ),  
                  ),  
                  const SizedBox(height: 8),  
                  _buildSpecificationItem(context, 'Brand', 'Brand Name'),  
                  _buildSpecificationItem(context, 'Model', 'Model Number'),  
                  _buildSpecificationItem(context, 'Color', 'Available Colors'),  
                  _buildSpecificationItem(context, 'Size', 'Available Sizes'),  
                  const SizedBox(height: 16),  
                  const Text(  
                    'Reviews',  
                    style: TextStyle(  
                      fontSize: 18,  
                      fontWeight: FontWeight.bold,  
                    ),  
                  ),  
                  const SizedBox(height: 8),  
                  _buildReviewItem(context),  
                  _buildReviewItem(context),  
                  _buildReviewItem(context),  
                ],  
              ),  
            ),  
          ),  
        ],  
      ),  
      bottomNavigationBar: SafeArea(  
        child: Padding(  
          padding: const EdgeInsets.all(16),  
          child: Row(  
            children: [  
              Expanded(  
                child: OutlinedButton.icon(  
                  onPressed: () {},  
                  icon: const Icon(Icons.chat_bubble_outline),  
                  label: const Text('Chat'),  
                ),  
              ),  
              const SizedBox(width: 16),  
              Expanded(  
                flex: 2,  
                child: FilledButton.icon(  
                  onPressed: () {},  
                  icon: const Icon(Icons.shopping_cart),  
                  label: const Text('Add to Cart'),  
                ),  
              ),  
            ],  
          ),  
        ),  
      ),  
    );  
  }  

  Widget _buildSpecificationItem(BuildContext context, String label, String value) {  
    return Padding(  
      padding: const EdgeInsets.only(bottom: 8),  
      child: Row(  
        children: [  
          Text(  
            '$label: ',  
            style: const TextStyle(fontWeight: FontWeight.w500),  
          ),  
          Text(value),  
        ],  
      ),  
    );  
  }  

  Widget _buildReviewItem(BuildContext context) {  
    return Padding(  
      padding: const EdgeInsets.only(bottom: 16),  
      child: Column(  
        crossAxisAlignment: CrossAxisAlignment.start,  
        children: [  
          Row(  
            children: [  
              const CircleAvatar(  
                radius: 16,  
                child: Icon(Icons.person),  
              ),  
              const SizedBox(width: 8),  
              Expanded(  
                child: Column(  
                  crossAxisAlignment: CrossAxisAlignment.start,  
                  children: [  
                    const Text(  
                      'John Doe',  
                      style: TextStyle(fontWeight: FontWeight.w500),  
                    ),  
                    Row(  
                      children: [  
                        Icon(  
                          Icons.star,  
                          size: 16,  
                          color: Theme.of(context).colorScheme.primary,  
                        ),  
                        const SizedBox(width: 4),  
                        const Text('4.5'),  
                        const SizedBox(width: 8),  
                        Text(  
                          '2 days ago',  
                          style: Theme.of(context).textTheme.bodySmall,  
                        ),  
                      ],  
                    ),  
                  ],  
                ),  
              ),  
            ],  
          ),  
          const SizedBox(height: 8),  
          const Text(  
            'Great product! Really satisfied with the quality and delivery.',  
          ),  
        ],  
      ),  
    );  
  }  
}