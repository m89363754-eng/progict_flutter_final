import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/widgets/blue_header.dart';
import '../logic/favorites_cubit.dart';
import '../../books/views/widgets/book_detail_sheet.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final re = Responsive(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FF),
      body: Column(
        children: [
          const BlueHeader(title: 'Favorites'),
          Expanded(
            child: BlocBuilder<FavoritesCubit, FavoritesState>(
              builder: (context, state) {
                if (state.books.isEmpty) return _buildEmpty(cs, re);
                return ListView.builder(
                  padding: EdgeInsets.fromLTRB(
                    re.w(16),
                    re.h(8),
                    re.w(16),
                    re.h(16),
                  ),
                  itemCount: state.books.length,
                  itemBuilder: (_, i) {
                    final book = state.books[i];
                    final vi = book.volumeInfo;
                    final imageUrl = book.imageUrl;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Dismissible(
                        key: ValueKey(book.id),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 24),
                          decoration: BoxDecoration(
                            color: Colors.red.shade700,
                            borderRadius: BorderRadius.circular(18),
                          ),

                          child: Icon(
                            Icons.delete_outline_rounded,
                            color: Colors.white,
                            size: re.icon(28),
                          ),
                        ),
                        onDismissed: (_) {
                          context.read<FavoritesCubit>().removeFavorite(
                            book.id,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '${vi?.title ?? "Book"} removed from favorites',
                              ),
                              behavior: SnackBarBehavior.floating,
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                        child: GestureDetector(
                          onTap: () => showBookDetail(context, book),
                          child: Container(
                            decoration: BoxDecoration(
                              color: cs.surfaceContainer,
                              borderRadius: BorderRadius.circular(re.r(18)),
                              border: Border.all(
                                color: cs.outlineVariant.withValues(
                                  alpha: 0.25,
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(re.w(12)),
                              child: Row(
                                children: [
                                  _FavImage(imageUrl: imageUrl, cs: cs, re: re),
                                  SizedBox(width: re.w(14)),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          vi?.title ?? 'Untitled',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: re.sp(15),
                                            color: cs.onSurface,
                                          ),
                                        ),
                                        SizedBox(height: re.h(4)),
                                        Text(
                                          vi?.authors?.join(', ') ?? 'Unknown',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: re.sp(12),
                                            fontWeight: FontWeight.w600,
                                            color: cs.primary.withValues(
                                              alpha: 0.7,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.favorite_rounded,
                                      color: Colors.red.shade400,
                                    ),
                                    onPressed: () {
                                      context
                                          .read<FavoritesCubit>()
                                          .toggleFavorite(book);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmpty(ColorScheme cs, Responsive re) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: const Duration(milliseconds: 600),
            curve: Curves.elasticOut,
            builder: (_, v, child) => Transform.scale(scale: v, child: child),
            child: Container(
              width: re.w(120),
              height: re.w(120),
              decoration: BoxDecoration(
                color: cs.errorContainer.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.favorite_outline_rounded,
                size: re.icon(56),
                color: Colors.red.shade300,
              ),
            ),
          ),
          SizedBox(height: re.h(24)),
          Text(
            'No Favorites Yet',
            style: TextStyle(
              fontSize: re.sp(20),
              fontWeight: FontWeight.w700,
              color: cs.onSurface,
            ),
          ),
          SizedBox(height: re.h(8)),
          Text(
            'Tap the heart on any book to save it here',
            style: TextStyle(color: cs.onSurfaceVariant, fontSize: re.sp(14)),
          ),
        ],
      ),
    );
  }
}

class _FavImage extends StatelessWidget {
  final String? imageUrl;
  final ColorScheme cs;
  final Responsive re;
  const _FavImage({required this.imageUrl, required this.cs, required this.re});

  @override
  Widget build(BuildContext context) {
    final w = re.w(60);
    final h = re.h(85);
    return ClipRRect(
      borderRadius: BorderRadius.circular(re.r(12)),
      child: SizedBox(
        width: w,
        height: h,
        child: imageUrl != null
            ? CachedNetworkImage(
                imageUrl: imageUrl!,
                fit: BoxFit.cover,
                width: w,
                height: h,
                placeholder: (_, __) => const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                errorWidget: (_, __, ___) => _placeholder(),
              )
            : _placeholder(),
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      color: cs.surfaceContainerHighest,
      child: Icon(
        Icons.menu_book_rounded,
        color: cs.onSurfaceVariant.withValues(alpha: 0.4),
      ),
    );
  }
}
