class User {
  String _user_name;
  String _email;
  String _password;
  String _password_hash;
  int _number_of_collection;
  int _number_of_card;
  double _coin;
  List<Collection> _collections;
  List<Card> _cards;

  String get getUserName {
    return _user_name;
  }

  String get getEmail {
    return _email;
  }

  String get getPassword {
    return _password;
  }

  String get getPasswordHash {
    return _password_hash;
  }

  int get getNumberOfCollection {
    return _number_of_collection;
  }

  int get getNumberOfCard {
    return _number_of_card;
  }

  double get getCoin {
    return _coin;
  }

  set setUserName(String userName) {
    _user_name = userName;
  }

  set setEmail(String email) {
    _email = email;
  }

  set setPassword(String password) {
    _password = password;
  }

  set setPasswordHash(String passwordHash) {
    _password_hash = passwordHash;
  }

  set setNumberOfcollection(int numOfCollection) {
    _number_of_collection = numOfCollection;
  }

  set setNumberOfCard(int numOfcard) {
    _number_of_card = numOfcard;
  }

  set setCoin(double coin) {
    _coin = coin;
  }

  void sellCard(double cardPrice) {
    _coin += cardPrice;
    _number_of_card -= 1;
  }

  void buyCard(double cardPrice) {
    _coin -= cardPrice;
    _number_of_card += 1;
  }
}

class Card {
  String _name;
  double price;
  String owner;
}

class Collection {
  String _collection_name;
  List<Card> cards;
}

class Rarity {
  bool _common;
  bool _rare;
  bool _epic;
  bool _legendary;

  void common_card(Card card) {
    _common = true;
    _rare = false;
    _epic = false;
    _legendary = false;
  }

  void rare_card(Card card) {
    _common = false;
    _rare = true;
    _epic = false;
    _legendary = false;
  }

  void epic_card(Card card) {
    _common = false;
    _rare = false;
    _epic = true;
    _legendary = false;
  }

  void legendary_card(Card card) {
    _common = false;
    _rare = false;
    _epic = false;
    _legendary = true;
  }
}
