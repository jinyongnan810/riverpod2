import 'package:flutter/material.dart';
import 'package:instantgram/components/base_text.dart';
import 'package:instantgram/components/rich_text_widget.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LoginViewSignupLinks extends StatelessWidget {
  const LoginViewSignupLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return RichTextWidget(
      commonStyle: Theme.of(context).textTheme.subtitle1?.copyWith(height: 1.5),
      texts: [
        BaseText.plain(text: "Don't have an account?\n"),
        BaseText.plain(text: "Sign up with "),
        BaseText.link(
          text: "Google",
          callback: () {
            launchUrlString(
                'https://accounts.google.com/signup/v2/webcreateaccount?flowName=GlifWebSignIn&flowEntry=SignUp');
          },
        ),
        BaseText.plain(text: "."),
      ],
    );
  }
}
