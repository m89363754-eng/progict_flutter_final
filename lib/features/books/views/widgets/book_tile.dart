import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../features/auth/models/book_model.dart';
import '../../../../features/favorites/logic/favorites_cubit.dart';
import 'book_detail_sheet.dart';
import 'book_helper_widgets.dart';

class BookTile extends StatefulWidget {
  final BookModel book;
  const BookTile({super.key, required this.book});

  @override
  State<BookTile> createState() => _BookTileState();
}

class _BookTileState extends State<BookTile> {
  bool _pressed = false;

  String? get _imageUrl => widget.book.imageUrl;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final re = Responsive(context);
    final vi = widget.book.volumeInfo;
    final title = vi?.title ?? 'Untitled';
    final authors = vi?.authors?.join(', ') ?? 'Unknown author';
    final categories = vi?.categories;
    final pageCount = vi?.pageCount;

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: () => showBookDetail(context, widget.book),
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          decoration: BoxDecoration(
            color: cs.surfaceContainer,
            borderRadius: BorderRadius.circular(re.r(18)),
            border: Border.all(
              color: cs.outlineVariant.withValues(alpha: 0.25),
            ),
            boxShadow: _pressed
                ? []
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: Padding(
            padding: EdgeInsets.all(re.w(12)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _BookImage(id: widget.book.id, imageUrl: _imageUrl, cs: cs),
                const SizedBox(width: 14),
                Expanded(
                  child: SizedBox(
                    height: 115,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  color: cs.onSurface,
                                  height: 1.25,
                                  letterSpacing: -0.2,
                                ),
                              ),
                            ),
                            _FavoriteButton(book: widget.book),
                          ],
                        ),
                        const SizedBox(height: 4),
                        _AuthorRow(authors: authors, cs: cs),
                        const SizedBox(height: 6),
                        Wrap(
                          spacing: 6,
                          runSpacing: 4,
                          children: [
                            if (categories != null && categories.isNotEmpty)
                              TagChip(
                                label: categories.first,
                                color: cs.primaryContainer,
                                textColor: cs.onPrimaryContainer,
                              ),
                            if (pageCount != null && pageCount > 0)
                              TagChip(
                                label: '$pageCount pg',
                                color: cs.tertiaryContainer.withValues(
                                  alpha: 0.6,
                                ),
                                textColor: cs.onTertiaryContainer,
                                icon: Icons.auto_stories_outlined,
                              ),
                          ],
                        ),
                        const Spacer(),
                        if (vi?.description != null)
                          Text(
                            vi!.description!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: cs.onSurfaceVariant.withValues(
                                alpha: 0.65,
                              ),
                              fontSize: 11.5,
                              height: 1.4,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AuthorRow extends StatelessWidget {
  final String authors;
  final ColorScheme cs;
  const _AuthorRow({required this.authors, required this.cs});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.person_outline_rounded,
          size: 13,
          color: cs.primary.withValues(alpha: 0.7),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            authors,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: cs.primary.withValues(alpha: 0.7),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _BookImage extends StatelessWidget {
  final String? id;
  final String? imageUrl;
  final ColorScheme cs;
  const _BookImage({
    required this.id,
    required this.imageUrl,
    required this.cs,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'book_$id',
      child: Container(
        width: 80,
        height: 115,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 8,
              offset: const Offset(2, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: imageUrl != null
              ? CachedNetworkImage(
                  imageUrl: imageUrl!,
                  fit: BoxFit.cover,
                  width: 80,
                  height: 115,
                  placeholder: (_, __) => const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  errorWidget: (_, __, ___) =>
                      ImagePlaceholder(colorScheme: cs),
                )
              : ImagePlaceholder(colorScheme: cs),
        ),
      ),
    );
  }
}

class _FavoriteButton extends StatelessWidget {
  final BookModel book;
  const _FavoriteButton({required this.book});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        final isFav = context.read<FavoritesCubit>().isFavorite(book.id);
        return GestureDetector(
          onTap: () => context.read<FavoritesCubit>().toggleFavorite(book),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            transitionBuilder: (child, anim) =>
                ScaleTransition(scale: anim, child: child),
            child: Icon(
              isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
              key: ValueKey(isFav),
              color: isFav ? Colors.red.shade400 : cs.onSurfaceVariant,
              size: 22,
            ),
          ),
        );
      },
    );
  }
}
