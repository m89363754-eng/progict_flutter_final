import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/widgets/blue_header.dart';
import '../../../core/GetFeaturesBookscubit/get_feature_books_cubit.dart';
import 'widgets/book_tile.dart';
import 'widgets/books_empty_view.dart';
import 'widgets/books_error_view.dart';
import 'widgets/books_initial_view.dart';
import 'widgets/books_shimmer_tile.dart';

class BooksScreen extends StatefulWidget {
  const BooksScreen({super.key});

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen>
    with SingleTickerProviderStateMixin {
  final _searchCtrl = TextEditingController();
  final _focusNode = FocusNode();
  late final AnimationController _animCtrl;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    context.read<GetFeatureBooksCubit>().getFeaturebooks();
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    _searchCtrl.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onSearch() {
    final q = _searchCtrl.text.trim();
    if (q.isEmpty) return;
    _focusNode.unfocus();
    _animCtrl.reset();
    context.read<GetFeatureBooksCubit>().searchBooks(q);
  }

  void _onClear() {
    _searchCtrl.clear();
    _animCtrl.reset();
    context.read<GetFeatureBooksCubit>().getFeaturebooks();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FF),
      body: Column(
        children: [
          const BlueHeader(title: 'Library'),
          _buildSearchBar(cs),
          Expanded(
            child: BlocConsumer<GetFeatureBooksCubit, GetFeatureBooksState>(
              listener: (_, s) {
                if (s is GetFeatureBooksSuccess) _animCtrl.forward();
              },
              builder: (ctx, state) {
                if (state is GetFeatureBooksLoading) {
                  return const BooksShimmerList();
                }
                if (state is GetFeatureBooksFailure) {
                  return BooksErrorView(
                    message: state.errorMessage,
                    onRetry: () {
                      final q = _searchCtrl.text.trim();
                      q.isNotEmpty
                          ? ctx.read<GetFeatureBooksCubit>().searchBooks(q)
                          : ctx.read<GetFeatureBooksCubit>().getFeaturebooks();
                    },
                  );
                }
                if (state is GetFeatureBooksSuccess) {
                  return state.books.isEmpty
                      ? const BooksEmptyView()
                      : _buildList(state);
                }
                return const BooksInitialView();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(ColorScheme cs) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Container(
        decoration: BoxDecoration(
          color: cs.surfaceContainerHighest.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.25)),
        ),
        child: TextField(
          controller: _searchCtrl,
          focusNode: _focusNode,
          textInputAction: TextInputAction.search,
          onSubmitted: (_) => _onSearch(),
          decoration: InputDecoration(
            hintText: 'Search books, authors, topics...',
            hintStyle: TextStyle(
              color: cs.onSurfaceVariant.withValues(alpha: 0.5),
              fontSize: 14,
            ),
            prefixIcon: Icon(
              Icons.search_rounded,
              color: cs.onSurfaceVariant.withValues(alpha: 0.6),
            ),
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ValueListenableBuilder<TextEditingValue>(
                  valueListenable: _searchCtrl,
                  builder: (_, v, __) => v.text.isEmpty
                      ? const SizedBox.shrink()
                      : IconButton(
                          icon: Icon(
                            Icons.close_rounded,
                            size: 18,
                            color: cs.onSurfaceVariant,
                          ),
                          onPressed: _onClear,
                        ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 4),
                  decoration: BoxDecoration(
                    color: cs.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_forward_rounded, size: 18),
                    color: cs.onPrimary,
                    onPressed: _onSearch,
                    visualDensity: VisualDensity.compact,
                  ),
                ),
              ],
            ),
            filled: false,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildList(GetFeatureBooksSuccess state) {
    return RefreshIndicator(
      onRefresh: () async {
        _animCtrl.reset();
        final q = _searchCtrl.text.trim();
        q.isNotEmpty
            ? await context.read<GetFeatureBooksCubit>().searchBooks(q)
            : await context.read<GetFeatureBooksCubit>().getFeaturebooks();
      },
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
        itemCount: state.books.length,
        itemBuilder: (_, i) {
          final d = (i * 0.06).clamp(0.0, 0.6);
          final anim = CurvedAnimation(
            parent: _animCtrl,
            curve: Interval(
              d,
              (d + 0.4).clamp(0.0, 1.0),
              curve: Curves.easeOutCubic,
            ),
          );
          return FadeTransition(
            opacity: anim,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.15),
                end: Offset.zero,
              ).animate(anim),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: BookTile(book: state.books[i]),
              ),
            ),
          );
        },
      ),
    );
  }
}
