import 'package:flutter/material.dart';
import 'package:prueba_jairo_rios/core/size_constans.dart';
import 'package:prueba_jairo_rios/presentation/widgets/text_widget.dart';

class CardAddressInformationWidget extends StatelessWidget {
  const CardAddressInformationWidget({
    super.key,
    required this.countryName,
    required this.stateName,
    required this.cityName,
  });

  final String countryName;
  final String stateName;
  final String cityName;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(SizeConstants.size8),
        child: Row(
          children: [
            const SizedBox(width: SizeConstants.size8),
            const CircleAvatar(
                radius: SizeConstants.size24,
                backgroundColor: Colors.indigoAccent,
                child: Icon(
                  Icons.maps_home_work,
                  size: SizeConstants.size24,
                )),
            const SizedBox(width: SizeConstants.size8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: countryName,
                  ),
                  TextWidget(
                    text: stateName,
                  ),
                  TextWidget(
                    text: cityName,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
