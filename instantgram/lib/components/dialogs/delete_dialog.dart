import 'package:instantgram/components/dialogs/alert_dialog_model.dart';
import 'package:instantgram/constants/strings.dart';

class DeleteDialog extends AlertDialogModel<bool> {
  const DeleteDialog({required String objectToDelete})
      : super(
          title: 'Delete $objectToDelete',
          message: 'Are you sure you want to delete this $objectToDelete',
          buttons: const {Strings.no: false, Strings.yes: true},
        );
}
