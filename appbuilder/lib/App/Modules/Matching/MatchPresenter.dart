import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Match.dart';

class MatchPresenter {
  List<Match> list = List<Match>();

  loadMatchesIntoList(FirebaseUser currentUser) async {
    list.clear();
    List _matchDataList = List();
    await CloudFunctions.instance.getHttpsCallable(functionName: 'getMatchesForLunch',).call(<String, dynamic>{'userId': ''}).then(
            (matchIds) async => await Firestore.instance.collection('users').where('id', whereIn: matchIds.data).getDocuments().then(
                    (matchQuery) => matchQuery.documents.forEach((matchData) => _matchDataList.add(matchData.data))));

    _matchDataList.forEach((match)=> {
      list.add(Match(
        id: match['id'],
        gender: match['gender'],
        name: match['nickname'],
        job: match['job'],
        department: match['department'],
        photoUrl: match['photoUrl'],
        sector: match['sector'],
        company: match['company'],
        bio: match['bio'],
        age: match['age'],
        accountType: match['accountType'],
        points: match['points'],
      ))
    });

    list.sort((a, b) => a.name.compareTo(b.name));
    list.sort((a, b) => b.accountType.compareTo(a.accountType));
  }

  void acceptMatch() {

  }

  void deleteMatch() {

  }

  void chatMatch() {

  }

  void getMatchProfile() {

  }
}