import 'package:flutter/material.dart';
import 'package:prueba_jairo_rios/core/size_constans.dart';
import 'package:prueba_jairo_rios/presentation/widgets/text_widget.dart';

class CardUserInformationWidget extends StatelessWidget {
  const CardUserInformationWidget({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          const SizedBox(width: SizeConstants.size8),
          const CircleAvatar(
              radius: SizeConstants.size24,
              backgroundColor: Colors.indigoAccent,
              child: Icon(
                Icons.person,
                size: SizeConstants.size24,
              )),
          const SizedBox(width: SizeConstants.size8),
          Expanded(
            child: ListTile(
              title: TextWidget(
                text: title,
              ),
              subtitle: TextWidget(
                text: subtitle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
