import 'package:instantgram/components/dialogs/alert_dialog_model.dart';
import 'package:instantgram/constants/strings.dart';

class LogoutDialog extends AlertDialogModel<bool> {
  const LogoutDialog()
      : super(
          title: Strings.logout,
          message: Strings.confirmLogout,
          buttons: const {Strings.no: false, Strings.yes: true},
        );
}
