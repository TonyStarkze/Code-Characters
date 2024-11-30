import 'package:flutter/material.dart';
import 'package:flutter_rpg/models/vocation.dart';
import 'package:flutter_rpg/shared/styled_text.dart';
import 'package:flutter_rpg/styles.dart';

class VocationCard extends StatelessWidget {
  const VocationCard(
      {required this.vocation,
      required this.onTap,
      required this.selected,
      super.key});

  final Vocation vocation;
  final bool selected;
  final void Function(Vocation) onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(vocation);
      },
      child: Card(
          color: selected ? AppColors.secondaryColor : Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(9),
            child: Row(
              children: [
                //vocation image
                Image.asset(
                  'assets/img/vocations/${vocation.image}',
                  width: 80,
                  colorBlendMode: BlendMode.color,
                  color: !selected
                      ? Colors.black.withOpacity(0.8)
                      : Colors.transparent,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      StyledHeadline(vocation.title),
                      StyledText(vocation.description),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
