import 'package:flutter/material.dart';
import 'package:flutter_rpg/models/character.dart';
import 'package:flutter_rpg/models/vocation.dart';
import 'package:flutter_rpg/screens/create_screen/vocation_card.dart';
//import 'package:flutter_rpg/screens/home/home.dart';
import 'package:flutter_rpg/services/character_store.dart';
import 'package:flutter_rpg/shared/styled_button.dart';
import 'package:flutter_rpg/shared/styled_text.dart';
import 'package:flutter_rpg/styles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final _nameController = TextEditingController();
  final _sloganController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _sloganController.dispose();
    super.dispose();
  }

  // Handling Vocation Selection
  Vocation selectedVocation = Vocation.junkie;

  void updateVocation(Vocation vocation) {
    setState(() {
      selectedVocation = vocation;
    });
  }

  // submit handler
  void handleSubmit() {
    if (_nameController.text.trim().isEmpty) {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const StyledHeadline('Missing Character Name'),
              content: const StyledText(
                  'Every good RPG Character needs a great name...'),
              actions: [
                StyledButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: const StyledHeadline('close'))
              ],
              actionsAlignment: MainAxisAlignment.center,
            );
          });
      return;
    }
    if (_sloganController.text.trim().isEmpty) {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const StyledHeadline('Missing Slogan'),
              content: const StyledText('Remember to add a catchy Slogan...'),
              actions: [
                StyledButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: const StyledHeadline('close'))
              ],
              actionsAlignment: MainAxisAlignment.center,
            );
          });
      return;
    }

    Provider.of<CharacterStore>(context, listen: false).addCharacter(Character(
        name: _nameController.text.trim(),
        slogan: _sloganController.text.trim(),
        vocation: selectedVocation,
        id: uuid.v4()));

    //Navigator.push(context, MaterialPageRoute(builder: (ctx) => const Home()));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const StyledTitle('Character Creation'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Welcome message
              Center(
                child: Icon(
                  Icons.code,
                  color: AppColors.primaryColor,
                ),
              ),
              const Center(
                child: StyledHeadline('Welcome, new player.'),
              ),
              const Center(
                child:
                    StyledText('Create a name and slogan for your character.'),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _nameController,
                style: GoogleFonts.kanit(
                  textStyle: Theme.of(context).textTheme.bodyMedium,
                ),
                cursorColor: AppColors.textColor,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_2),
                  label: StyledText('Character Name'),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _sloganController,
                style: GoogleFonts.kanit(
                  textStyle: Theme.of(context).textTheme.bodyMedium,
                ),
                cursorColor: AppColors.textColor,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.chat_bubble),
                  label: StyledText('Character Slogan'),
                ),
              ),
              const SizedBox(
                height: 30,
              ),

              //select vocation title
              Center(
                child: Icon(
                  Icons.code,
                  color: AppColors.primaryColor,
                ),
              ),
              const Center(
                child: StyledHeadline('Choose a Vocation'),
              ),
              const Center(
                child: StyledText('This determines your available skills.'),
              ),
              const SizedBox(height: 30),

              //vocation cards
              VocationCard(
                  selected: selectedVocation == Vocation.junkie,
                  onTap: updateVocation,
                  vocation: Vocation.junkie),
              VocationCard(
                  selected: selectedVocation == Vocation.ninja,
                  onTap: updateVocation,
                  vocation: Vocation.ninja),
              VocationCard(
                  selected: selectedVocation == Vocation.raider,
                  onTap: updateVocation,
                  vocation: Vocation.raider),
              VocationCard(
                  selected: selectedVocation == Vocation.wizard,
                  onTap: updateVocation,
                  vocation: Vocation.wizard),

              //Goodbye Message
              Center(
                child: Icon(
                  Icons.code,
                  color: AppColors.primaryColor,
                ),
              ),
              const Center(
                child: StyledHeadline('Good Luck.'),
              ),
              const Center(
                child: StyledText('And Enjoy The Journey...'),
              ),
              const SizedBox(height: 30),

              Center(
                child: StyledButton(
                  onPressed: handleSubmit,
                  child: const StyledHeadline('Create Character'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
