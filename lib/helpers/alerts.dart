part of 'helpers.dart';


showLoading( BuildContext context){

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => AlertDialog(
      title: Text('Wait please...'),
      content: LinearProgressIndicator(),
    )
  );

}

showAlert( BuildContext context, String title, String message){

  showDialog(
   context: context,
    barrierDismissible: false,
   builder: (_) => AlertDialog(
    title: Text( title ),
    content: Text(message),
    actions: [
      MaterialButton(
        child: Text('Ok'),
        onPressed: () => Navigator.of(context).pop()
        ),
    ],
   )
   );

}