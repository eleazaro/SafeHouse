import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../config/strings/app_strings.dart';
import '../../../config/theme/app_colors.dart';
import '../../../data/repositories/property_repository.dart';
import '../../auth/view_models/auth_view_model.dart';
import '../../core/widgets/filter_chips_bar.dart';
import '../../core/widgets/property_card.dart';
import '../../core/widgets/property_card_shimmer.dart';
import '../../core/widgets/safe_house_app_bar.dart';
import '../view_models/home_view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(
        context.read<PropertyRepository>(),
      ),
      child: const _HomeScreenBody(),
    );
  }
}

class _HomeScreenBody extends StatefulWidget {
  const _HomeScreenBody();

  @override
  State<_HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<_HomeScreenBody> {
  final ScrollController _scrollController = ScrollController();
  int _currentNavIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<HomeViewModel>().loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthViewModel>();
    final viewModel = context.watch<HomeViewModel>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.primary,
          backgroundColor: AppColors.surface,
          onRefresh: viewModel.refresh,
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              // App Bar
              SliverToBoxAdapter(
                child: SafeHouseAppBar(
                  userName: auth.currentUser?.name.split(' ').first ?? AppStrings.defaultUserName,
                  photoUrl: auth.currentUser?.photoUrl,
                ),
              ),
              // Title
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                  child: Text(
                    AppStrings.homeFeedTitle,
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: AppColors.onBackground,
                      height: 1.2,
                    ),
                  ),
                ),
              ),
              // Filter chips
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: FilterChipsBar(
                    activeFilter: viewModel.activeFilter,
                    onFilterChanged: viewModel.applyFilter,
                  ),
                ),
              ),
              // Feed
              if (viewModel.isLoading)
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (_, _) => const PropertyCardShimmer(),
                    childCount: 3,
                  ),
                )
              else if (viewModel.hasError)
                SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: AppColors.error,
                          size: 48,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          AppStrings.homeErrorMessage,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: AppColors.onBackgroundSecondary,
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextButton(
                          onPressed: viewModel.refresh,
                          child: const Text(AppStrings.homeRetry),
                        ),
                      ],
                    ),
                  ),
                )
              else if (viewModel.properties.isEmpty)
                SliverFillRemaining(
                  child: Center(
                    child: Text(
                      AppStrings.homeEmpty,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: AppColors.onBackgroundSecondary,
                      ),
                    ),
                  ),
                )
              else ...[
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final property = viewModel.properties[index];
                      return PropertyCard(
                        property: property,
                        onTap: () => context.push('/property/${property.id}'),
                      );
                    },
                    childCount: viewModel.properties.length,
                  ),
                ),
                if (viewModel.isLoadingMore)
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                          strokeWidth: 2,
                        ),
                      ),
                    ),
                  ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 16),
                ),
              ],
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentNavIndex,
        onTap: (index) => setState(() => _currentNavIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: AppStrings.navHome,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: AppStrings.navSearch,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            activeIcon: Icon(Icons.favorite),
            label: AppStrings.navFavorites,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: AppStrings.navProfile,
          ),
        ],
      ),
    );
  }
}
