import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moneytracker/core/currency/currency_formatter.dart';
import 'package:moneytracker/core/currency/currency_notifier.dart';
import 'package:moneytracker/core/currency/currency_option.dart';
import 'package:moneytracker/core/formatting/relative_date_formatter.dart';
import 'package:moneytracker/core/locale/locale_notifier.dart';
import 'package:moneytracker/core/theme/app_colors.dart';
import 'package:moneytracker/features/transactions/domain/entities/transaction.dart';
import 'package:moneytracker/features/transactions/presentation/providers/transactions_notifier.dart';
import 'package:moneytracker/features/transactions/presentation/utils/transaction_grouper.dart';
import 'package:moneytracker/l10n/app_localizations.dart';
import 'package:moneytracker/features/transactions/presentation/widgets/transaction_delete_dialog.dart';
import 'package:moneytracker/features/transactions/presentation/widgets/transaction_options_dialog.dart';
import 'package:moneytracker/shared/presentation/widgets/app_snackbar.dart';

class TransactionsList extends ConsumerStatefulWidget {
  const TransactionsList({super.key});

  @override
  ConsumerState<TransactionsList> createState() => _TransactionsListState();
}

class _TransactionsListState extends ConsumerState<TransactionsList> {
  bool _hasAnimatedInitially = false;

  void _showTransactionOptions(BuildContext context, Transaction transaction) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: AppLocalizations.of(context)!.dismiss,
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return TransactionOptionsDialog(
          onEdit: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(AppLocalizations.of(context)!.editFeatureComingSoon),
                duration: const Duration(seconds: 2),
              ),
            );
          },
          onDelete: () {
            _showDeleteConfirmation(context, transaction);
          },
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
          child: child,
        );
      },
    );
  }

  void _showDeleteConfirmation(BuildContext context, Transaction transaction) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: AppLocalizations.of(context)!.dismiss,
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return TransactionDeleteDialog(
          onConfirm: () {
            ref
                .read(transactionsNotifierProvider.notifier)
                .deleteTransaction(transaction.id!);
            AppSnackbar.show(
              context,
              message: AppLocalizations.of(context)!.transactionDeleted,
              type: AppSnackbarType.error,
            );
          },
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
          child: child,
        );
      },
    );
  }

  String _labelFor(DateTime date, AppLocalizations l10n, String locale) {
    return RelativeDateFormatter.format(
      date,
      todayLabel: l10n.today,
      yesterdayLabel: l10n.yesterday,
      locale: locale,
    );
  }

  @override
  Widget build(BuildContext context) {
    final transactionsAsync = ref.watch(transactionsNotifierProvider);
    final currency = ref.watch(currencyNotifierProvider);
    final locale = ref.watch(localeNotifierProvider).toLocale().languageCode;
    final l10n = AppLocalizations.of(context)!;

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: transactionsAsync.when(
          loading: () => Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          ),
          error: (error, stackTrace) => Center(
            child: Text('${l10n.noTransactionsYet}\n$error'),
          ),
          data: (transactions) {
            if (!_hasAnimatedInitially && transactions.isNotEmpty) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  setState(() {
                    _hasAnimatedInitially = true;
                  });
                }
              });
            }

            if (transactions.isEmpty) {
              return const _EmptyState();
            }

            final sections = TransactionGrouper.groupByDate(
              transactions,
              labelFor: (date) => _labelFor(date, l10n, locale),
            );

            return _GroupedTransactionsList(
              sections: sections,
              currency: currency,
              onTransactionLongPress: _showTransactionOptions,
              hasAnimatedInitially: _hasAnimatedInitially,
            );
          },
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final secondaryColor =
        Theme.of(context).textTheme.bodyMedium?.color ?? Colors.grey.shade600;
    final l10n = AppLocalizations.of(context)!;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.account_balance_wallet_outlined,
            size: 80,
            color: secondaryColor.withValues(alpha: 0.4),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.noTransactionsYet,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: secondaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.noTransactionsHint,
            style: TextStyle(
              fontSize: 14,
              color: secondaryColor.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}

/// Renders a list of date sections (header + cards), preserving the
/// original cascading entry animation across the flattened card order
/// — only the very first card is re-animated on subsequent rebuilds
/// (e.g. after adding a new transaction), while historical ones stay
/// static.
class _GroupedTransactionsList extends StatelessWidget {
  final List<TransactionSection> sections;
  final CurrencyOption currency;
  final Function(BuildContext, Transaction) onTransactionLongPress;
  final bool hasAnimatedInitially;

  const _GroupedTransactionsList({
    required this.sections,
    required this.currency,
    required this.onTransactionLongPress,
    required this.hasAnimatedInitially,
  });

  @override
  Widget build(BuildContext context) {
    var cardIndex = 0;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      children: [
        for (final section in sections) ...[
          _SectionHeader(label: section.label),
          const SizedBox(height: 8),
          for (final transaction in section.transactions) ...[
            Builder(
              builder: (context) {
                final shouldAnimateCascade = !hasAnimatedInitially;
                final shouldAnimateNew =
                    hasAnimatedInitially && cardIndex == 0;
                final thisCardIndex = cardIndex;
                cardIndex++;

                return _TransactionCard(
                  key: ValueKey(transaction.id),
                  transaction: transaction,
                  currency: currency,
                  onLongPress: () =>
                      onTransactionLongPress(context, transaction),
                  animateEntry: shouldAnimateCascade || shouldAnimateNew,
                  cascadeIndex: shouldAnimateCascade ? thisCardIndex : 0,
                );
              },
            ),
            const SizedBox(height: 12),
          ],
          const SizedBox(height: 12),
        ],
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String label;

  const _SectionHeader({required this.label});

  @override
  Widget build(BuildContext context) {
    final secondaryColor =
        Theme.of(context).textTheme.bodyMedium?.color ?? Colors.grey.shade600;

    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: secondaryColor,
          letterSpacing: 1.0,
        ),
      ),
    );
  }
}

class _TransactionCard extends StatefulWidget {
  final Transaction transaction;
  final CurrencyOption currency;
  final VoidCallback onLongPress;
  final bool animateEntry;
  final int cascadeIndex;

  const _TransactionCard({
    super.key,
    required this.transaction,
    required this.currency,
    required this.onLongPress,
    required this.animateEntry,
    required this.cascadeIndex,
  });

  @override
  State<_TransactionCard> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<_TransactionCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    final delay = widget.cascadeIndex * 80;

    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: widget.animateEntry ? 0.0 : 1.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _slideAnimation = Tween<Offset>(
      begin: widget.animateEntry ? const Offset(0, 0.2) : Offset.zero,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    if (widget.animateEntry && widget.cascadeIndex > 0) {
      Future.delayed(Duration(milliseconds: delay), () {
        if (mounted) _controller.forward();
      });
    } else {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isIncome = widget.transaction.type == TransactionType.income;
    final color = isIncome ? AppColors.accent : AppColors.expense;
    final icon = isIncome ? Icons.trending_up : Icons.trending_down;
    final typeLabel = isIncome
        ? AppLocalizations.of(context)!.income
        : AppLocalizations.of(context)!.expense;

    final value = CurrencyFormatter.format(
      widget.currency,
      widget.transaction.amount,
      showSign: true,
    );

    final surfaceColor = Theme.of(context).colorScheme.surface;
    final borderColor = Theme.of(context).dividerColor;
    final titleColor =
        Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black87;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: InkWell(
          onLongPress: widget.onLongPress,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: borderColor,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
              border: Border.all(color: borderColor, width: 1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          color.withValues(alpha: 0.15),
                          color.withValues(alpha: 0.05),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: color.withValues(alpha: 0.2),
                        width: 1.5,
                      ),
                    ),
                    child: Center(child: Icon(icon, color: color, size: 22)),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.transaction.description,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: titleColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 3),
                        Text(
                          typeLabel,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: color,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 110),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerRight,
                      child: Text(
                        value,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: color,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
