import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dartz/dartz.dart';
import 'package:prueba_jairo_rios/core/strings_constants.dart';
import 'package:prueba_jairo_rios/presentation/widgets/text_widget.dart';

class SelectWithLoadingWidget<T> extends ConsumerWidget {
  final FutureProvider provider;
  final String hint;
  final String Function(T item) labelBuilder;
  final List<T> Function(dynamic data) itemsExtractor;
  final void Function(T? value)? onChanged;
  final T? value;

  const SelectWithLoadingWidget({
    super.key,
    required this.provider,
    required this.hint,
    required this.labelBuilder,
    required this.itemsExtractor,
    this.onChanged,
    this.value,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(provider);

    return asyncData.when(
      data: (data) {
        dynamic result;
        if (data is Either) {
          data.fold((l) => result = null, (r) => result = r);
        } else {
          result = data;
        }

        final items = itemsExtractor(result);

        return SizedBox(
          width: double.infinity,
          child: DropdownButtonFormField<T>(
            isExpanded: true,
            hint: TextWidget(text: hint),
            items: items
                .toSet()
                .map((item) => DropdownMenuItem<T>(
                      value: item,
                      child: Text(
                        labelBuilder(item),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ))
                .toList(),
            value: value,
            onChanged: onChanged,
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => TextWidget(text: '${StringConstants.error} $err'),
    );
  }
}
