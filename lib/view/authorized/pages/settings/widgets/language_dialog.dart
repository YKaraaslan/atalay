part of '../settings_viewmodel.dart';

class LanguageAlertDialog extends StatefulWidget {
  const LanguageAlertDialog({Key? key}) : super(key: key);

  @override
  State<LanguageAlertDialog> createState() => _LanguageAlertDialogState();
}

class _LanguageAlertDialogState extends State<LanguageAlertDialog> {
  late Languages? language = context.locale == const Locale('tr', 'TR') ? Languages.turkish : Languages.english;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: EdgeInsets.zero,
      contentPadding: const EdgeInsets.only(top: 25, left: 15, right: 15),
      buttonPadding: const EdgeInsets.only(right: 15),
      title: const Text('Uygulama Dili'),
      content: SizedBox(
        height: 120,
        child: Column(
          children: [
            RadioListTile<Languages>(
              title: const Text('Türkçe'),
              value: Languages.turkish,
              groupValue: language,
              onChanged: (value) {
                setState(() {
                  language = value;
                });
              },
              selected: language == Languages.turkish,
            ),
            RadioListTile<Languages>(
              title: const Text('English'),
              value: Languages.english,
              groupValue: language,
              onChanged: (value) {
                setState(() {
                  language = value;
                });
              },
              selected: language == Languages.english,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            if (language == Languages.turkish) {
              context.setLocale(const Locale('tr', 'TR'));
            } else {
              context.setLocale(const Locale('en', 'US'));
            }
            Navigator.pop(context);
            MyApp.restartApp(context);
          },
        ),
      ],
    );
  }
}

enum Languages { turkish, english }
