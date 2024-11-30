import 'package:flutter/material.dart';
import 'package:flutter_rpg/models/character.dart';
import 'package:flutter_rpg/screens/profile/heart.dart';
import 'package:flutter_rpg/screens/profile/skill_list.dart';
import 'package:flutter_rpg/screens/profile/stats_table.dart';
import 'package:flutter_rpg/services/character_store.dart';
import 'package:flutter_rpg/shared/styled_button.dart';
import 'package:flutter_rpg/shared/styled_text.dart';
import 'package:flutter_rpg/styles.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({required this.character, super.key});

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StyledHeadline(character.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //basic info - image, vocation, description
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  color: AppColors.secondaryColor.withOpacity(0.3),
                  child: Row(
                    children: [
                      Hero(
                        tag: character.id.toString(),
                        child: Image.asset(
                          'assets/img/vocations/${character.vocation.image}',
                          width: 140,
                          height: 140,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            StyledHeadline(character.vocation.title),
                            StyledText(character.vocation.description),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                    top: 3, right: 10, child: Heart(character: character)),
              ],
            ),

            //weapon and ability and slogan
            const SizedBox(
              height: 20,
            ),
            Center(child: Icon(Icons.code, color: AppColors.primaryColor)),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                color: AppColors.secondaryColor.withOpacity(0.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const StyledHeadline('Solgan'),
                    StyledText(character.slogan),
                    const SizedBox(height: 10),
                    const StyledHeadline('Weapon Of Choice'),
                    StyledText(character.vocation.weapon),
                    const SizedBox(height: 10),
                    const StyledHeadline('Unique Ability'),
                    StyledText(character.vocation.ability),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),

            //stats and skills
            Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  StatsTable(character),
                  SkillList(character),
                ],
              ),
            ),

            //save button
            StyledButton(
              onPressed: () {
                Provider.of<CharacterStore>(context, listen: false)
                    .saveCharacter(character);

                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const StyledHeadline('Character was saved!'),
                  showCloseIcon: true,
                  duration: const Duration(seconds: 2),
                  backgroundColor: AppColors.secondaryColor,
                ));
              },
              child: const StyledHeadline('Save Character'),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
