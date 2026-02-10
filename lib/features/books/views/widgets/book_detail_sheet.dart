import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../features/auth/models/book_model.dart';
import 'book_helper_widgets.dart';

void showBookDetail(BuildContext context, BookModel book) {
  final cs = Theme.of(context).colorScheme;
  final re = Responsive(context);
  final vi = book.volumeInfo;
  final imageUrl = book.imageUrl;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: cs.surface,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(re.r(28))),
    ),
    builder: (_) => DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (_, ctrl) => ListView(
        controller: ctrl,
        padding: EdgeInsets.fromLTRB(re.w(24), re.h(12), re.w(24), re.h(32)),
        children: [
          Center(
            child: Container(
              width: re.w(40),
              height: re.h(4),
              decoration: BoxDecoration(
                color: cs.onSurfaceVariant.withValues(alpha: 0.35),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          SizedBox(height: re.h(24)),
          Center(
            child: Hero(
              tag: 'book_${book.id}',
              child: Container(
                width: re.w(140),
                height: re.h(200),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(re.r(14)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.18),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(re.r(14)),
                  child: imageUrl != null
                      ? CachedNetworkImage(
                          imageUrl: imageUrl,
                          fit: BoxFit.cover,
                          width: re.w(140),
                          height: re.h(200),
                          placeholder: (_, __) => const Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                          errorWidget: (_, __, ___) =>
                              ImagePlaceholder(colorScheme: cs),
                        )
                      : ImagePlaceholder(colorScheme: cs),
                ),
              ),
            ),
          ),
          SizedBox(height: re.h(24)),
          Text(
            vi?.title ?? 'Untitled',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: re.sp(22),
              fontWeight: FontWeight.w800,
              color: cs.onSurface,
              letterSpacing: -0.3,
            ),
          ),
          if (vi?.authors != null) ...[
            SizedBox(height: re.h(6)),
            Text(
              vi!.authors!.join(', '),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: re.sp(14),
                fontWeight: FontWeight.w500,
                color: cs.primary.withValues(alpha: 0.8),
              ),
            ),
          ],
          SizedBox(height: re.h(16)),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 6,
            children: [
              if (vi?.publishedDate != null)
                DetailChip(
                  icon: Icons.calendar_today_rounded,
                  label: vi!.publishedDate!,
                  colorScheme: cs,
                ),
              if (vi?.pageCount != null)
                DetailChip(
                  icon: Icons.auto_stories_rounded,
                  label: '${vi!.pageCount} pages',
                  colorScheme: cs,
                ),
              if (vi?.publisher != null)
                DetailChip(
                  icon: Icons.business_rounded,
                  label: vi!.publisher!,
                  colorScheme: cs,
                ),
              if (vi?.language != null)
                DetailChip(
                  icon: Icons.language_rounded,
                  label: vi!.language!.toUpperCase(),
                  colorScheme: cs,
                ),
            ],
          ),
          if (vi?.categories != null && vi!.categories!.isNotEmpty) ...[
            SizedBox(height: re.h(12)),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: re.w(6),
              children: vi.categories!
                  .map(
                    (c) => Chip(
                      label: Text(c, style: TextStyle(fontSize: re.sp(12))),
                      backgroundColor: cs.primaryContainer.withValues(
                        alpha: 0.4,
                      ),
                      side: BorderSide.none,
                      padding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                    ),
                  )
                  .toList(),
            ),
          ],
          if (vi?.description != null) ...[
            SizedBox(height: re.h(20)),
            Text(
              'Description',
              style: TextStyle(
                fontSize: re.sp(16),
                fontWeight: FontWeight.w700,
                color: cs.onSurface,
              ),
            ),
            SizedBox(height: re.h(8)),
            Text(
              vi!.description!,
              style: TextStyle(
                fontSize: re.sp(14),
                height: 1.6,
                color: cs.onSurfaceVariant,
              ),
            ),
          ],
          if (book.webReaderUrl != null) ...[
            SizedBox(height: re.h(24)),
            SizedBox(
              width: double.infinity,
              height: re.h(50),
              child: FilledButton.icon(
                onPressed: () async {
                  final url = Uri.parse(book.webReaderUrl!);
                  await launchUrl(url, mode: LaunchMode.platformDefault);
                },
                icon: const Icon(Icons.open_in_new_rounded),
                label: Text(
                  'Read Book',
                  style: TextStyle(
                    fontSize: re.sp(16),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(re.r(14)),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    ),
  );
}
