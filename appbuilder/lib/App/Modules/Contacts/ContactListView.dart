import 'package:appbuilder/App/CustomWidgets/CustomError.dart';
import 'package:appbuilder/App/CustomWidgets/CustomWidgets.dart';
import 'package:appbuilder/App/Design/AppColors.dart';
import 'package:appbuilder/App/Design/AppDimensions.dart';
import 'package:appbuilder/App/Modules/Contacts/ContactListController.dart';
import 'package:appbuilder/App/Settings/GlobalSettings.dart';
import 'package:flutter/material.dart';

import 'Model/Contact.dart';

class ContactListView extends StatefulWidget {

  final ContactListController _controller;

  ContactListView(this._controller);

  @override
  _ContactListViewState createState() => _ContactListViewState();
}

class _ContactListViewState extends State<ContactListView> {
  AppDimensions ad = GlobalSettings.ad;
  AppColors ac = GlobalSettings.ac;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: null,
        body: Container(
          child: StreamBuilder(
            stream: widget._controller.stream,
            builder: (context, AsyncSnapshot<List<Contact>> contacts) {
              // Handle Connection Error
              if (contacts.hasError) {
                print('Error while loading ContactList: ${contacts.error} # ${contacts.connectionState}');
                return CustomError(() {
                  setState(() {});
                }, error: 'Verbindungsfehler');
              }

              switch (contacts.connectionState) {
                case ConnectionState.none:
                  return CustomError(() {
                    setState(() {});
                  }, error: 'Verbindungsfehler');

                case ConnectionState.waiting:
                  return CustomWidgets().getViewLoader(ac, 'Kontakte werden geladen...', ad);

                case ConnectionState.active:
                  if (contacts.hasData && contacts.data.isNotEmpty) {
                    return getContent(contacts.data);
                  } else {
                    return CustomError(() {
                      setState(() {});
                    }, error: "Noch keine Kontakte");
                  }
                  break;
                case ConnectionState.done:
                  return CustomError(() {
                    setState(() {});
                  }, error: "Noch keine Kontakte");
              }
              return null;
            },
          ),
        ));
  }

  Center getContent(List<Contact> contactList) {
    return Center(
      child: ListView(
        padding: EdgeInsets.all(ad.hSmallSpace),
        children: contactList
            .map(
              (contact) => Container(
                padding: EdgeInsets.all(ad.hTinySpace),
                child: Row(
                  children: [
                    Text(contact.name, textScaleFactor: 1.2, textAlign: TextAlign.center,),
                  ],
                ),
              ),
        )
            .toList(),
      ),
    );
  }
}
