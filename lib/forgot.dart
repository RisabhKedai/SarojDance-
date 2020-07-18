import 'package:flutter/material.dart';
import "package:gsheets/gsheets.dart";
import 'texteditorcomponent.dart';
//import 'dropdown.dart';

final TextEditingController uc = new TextEditingController();
final TextEditingController nc = new TextEditingController();
final TextEditingController sqc = new TextEditingController();
// final TextEditingController pc = new TextEditingController();
// final TextEditingController cc = new TextEditingController();
// final TextEditingController sqc = new TextEditingController();

class ForgotForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10.0),
                  width: 400.0,
                  height: 80,
                  child: TextEditor('Name', 'eg:-Risabh', Icons.people, nc),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  width: 400.0,
                  height: 80,
                  child: TextEditor(
                      'Username', 'enter username', Icons.person, uc),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  width: 400.0,
                  height: 80,
                  child: TextEditor('SECURITY QUESTION',
                      'Your favourite animal', Icons.lock, sqc),
                ),
                Container(
                  child: RaisedButton(
                    onPressed: () {
                      showRegDialog(context);
                    },
                    color: Colors.deepPurple[900],
                    child: Text(
                      'SUBMIT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                  padding: EdgeInsets.all(10.0),
                  width: 200.0,
                  height: 60,
                ),
              ],
            ),
          ),
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }
}

// your google auth credentials
const _credentials = r'''
{
  "type": "service_account",
  "project_id": "saroj-dance-academy",
  "private_key_id": "4fc30410dbe24244386e86c46e94471328012ede",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCrw5YNSDr8yU9r\n4UWiSBJoyDth+6VKVvVRhnhXY5rqVUx3P9wGIstz84u5xxf6oNDeZE5ZX6Q+fLHJ\n9I+kSlJ5wYuZ3m6FvuMKtxW6IDMt2O0dP2KTMdcIr4nGNixZR/2VSKr5H0sOj66n\nOGv+9t52kyT5u1dhnNU/cOrdc33IBQTaJ0s9Gnhtqtr0tfUbZYTJEEOTrAsth3K4\nDEFbHLNAdgGXDUHWBm9ShV/x5D//2sMHdYNlFj/xmBCA2BRFTFLA3s8k61vXHOSQ\nvzDxt11Y/124C1+j+lAq0BBJAiodI6z83vhYqc7es0f/OT110RPsZHtWetG7Ur+E\n1vSbKo4xAgMBAAECggEAMua3yYDdxjrsN+ae6awdFIM+Idfe0Gx7r6i/cfpZFten\nXPGGRSU7kMWcYzYuk33j1/v2wgKXXFM8psI8bS3/SgjC05r4utbqVqsSG8HeGNif\n0BqQHlnXRUIr/JriQqUUb5CE5mXRKuQGmJSeYIUNQSty+jT7/Lfq9C2E1JKctFDX\n8Nw8aQ2IevA6+AD9KlnrF4YupjrCcO7Mxe9g+ab7LYum/rrcr8zvnaHClmLxrd1Q\n6+H8l8bMskicSte5A7/gstM8/uwN4uSfXSF6+5tEtGpqRzlY8vFxZ+EHZC5Zws2c\nyuk8XMPpEW9LBc5s/HXlc8nWyamrpWQljqwY/X2bnwKBgQDenpCBaCvx4Y4EoZaq\ngrwFJPRIxJJnU0scbNFLVM4AWF5XGU2LTStvtdc5Uy1tDewx070iBRpI1JfUaCB+\nGMjWEpDF6gEOP77Vw2PDCctwojFjT89jlbXHF1w+HoW2Lvw6SR/SGsVjdQ8CkwBF\nSsCpMG0V0lyJ7RzLEu4C+0GzywKBgQDFhOTxc2re4cgR13TFCgvYRBzz7fVtyXdH\n77X05bDhu5Mv5n7m3j+qOQ7Rw31Ogj9Ap7/jLjujRCHOcuPWiCNWQur5fwWu4Fa7\ndCRMEzf/CksNeoc78ra0/eHUCPF2t1JaEOeojUDKHZMM6CCMGLREkMEdde3f8xF9\nVAalTB8ecwKBgBUWcBnSBFelRg6qP9tnBuh1164M8NFY0oSeyjSYk+r0c/tMKkxH\nwxWR5BFKD8OEzhrqM8BFO3gqqzczpeBL+LpOh+g3gmIXJ7yYBZs0ElFZC9Scesi0\nJcP2Moav3XqkeMAMrTb50jjZndJgmmX17soYDD1E7/8gttmFsYYWxuKBAoGAL8N7\nOYgXh95Ba08Wxa8wPhP6jGI2v13AonytG5OPuoaJiUPL3DhSXO9/TepgGuQUN6ZZ\nGK7NbSXEpw/RWMeDBBEakUrOLQPC9YGYZW0gVWQ/0fqXST/gPtRGD+g5u+OI3o7H\n9lJyIG4WaUCY3kf7D7mReXZTF5zH1e7DzKUjwVECgYBlQFBsM+YczExJ+0W5Xchj\nLhEUoB+G700F1lZcqkJGNiJs2CJBsBJHrCwfGzgqT6LKf7RqcNk5Tw32FM5Yug1M\nNdL28Iqrh+7zz4T7dePk1VgcKlONqC6RtEsKiMZJG7CkAOMTMHn6lN42Oz183VgR\ne9jy75dEw9KJ7jLlSeJ60g==\n-----END PRIVATE KEY-----\n",
  "client_email": "sarojdance@saroj-dance-academy.iam.gserviceaccount.com",
  "client_id": "101421642497906673208",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/sarojdance%40saroj-dance-academy.iam.gserviceaccount.com"
}
''';

// your spreadsheet id
const _spreadsheetId = '1DOlTvVCARtMxb3z_BSMd3chND2l9EGezyMh_eN47NhE';

Future<Worksheet> getSheet(BuildContext context) async {
  print('getting the gsheet');
// init GSheets
  final gsheets = await GSheets(_credentials);
// fetch spreadsheet by its id
  final ss = await gsheets.spreadsheet(_spreadsheetId);
// get worksheet by its title
  final Worksheet sheet = await ss.worksheetByTitle('Sheet1');
  //int numb = await sheet.values.rowIndexOf(sheet.values.lastRow());
  //print(numb);
  return sheet;
}

Future<Widget> fromData(TextEditingController nc, TextEditingController uc,
    TextEditingController sqc, BuildContext context) async {
  Widget oc;
  var sheet = await getSheet(context);
  var nu = await sheet.values.allRows();
  var nusr = nu.length;
  String disp;
  if (nc.text != '' && uc.text != '' && sqc.text != '') {
    for (int i = 1; i < nusr; i++) {
      if (nu[i][0] == uc.text) {
        print('user found now verify');
        if (nc.text == nu[i][2] && sqc.text == nu[i][6]) {
          print('name');
          disp = 'your password is ' + nu[i][1];
        } else {
          disp = 'Invalid Info';
        }
      } else {
        disp = 'Invalid credentials';
      }
    }
    if (disp == '') {
      disp = 'USER NOT FOUND';
    }
  } else {
    disp = 'ENTER ALL FIELDS';
  }
  return Column(
    children: <Widget>[
      Icon(
        Icons.done,
        size: 100,
        color: Colors.green,
      ),
      Container(
        width: 200,
        child: Text(
          disp,
          style: TextStyle(
            color: Colors.deepPurple[900],
            fontFamily: 'Orbitron',
            fontSize: 20,
          ),
        ),
      ),
    ],
  );
}

showRegDialog(BuildContext context) {
  Dialog dialog = Dialog(
    backgroundColor: Colors.white,
    child: Container(
      //color: Colors.lightBlueAccent,
      width: 20.0,
      height: 190.0,
      child: FutureBuilder(
        future: fromData(nc, uc, sqc, context),
        builder: (context, logmess) {
          if (logmess.hasData) {
            return logmess.data;
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    ),
  );
  showDialog(context: context, builder: (BuildContext context) => dialog);
}
