import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:js/js.dart';

// Dropbox interop {{{
@JS()
@anonymous
class Options {
  external String get key;

  external factory Options({String key});
}

@JS("Dropbox.Client")
class Dropbox {
  external Dropbox(Options options);
  external Dropbox authenticate(callback);
  external mkdir(path, callback);
  external readdir(path, callback);
  external readFile(path, options, callback);
  external writeFile(path, data, options, callback);
}
// Dropbox interop }}}

Dropbox dbClient = null;

void setupDropbox(Completer<Map> completer) {

  dbClient = new Dropbox(new Options(key: "lx0nwm2xq5qereu"));
  void dropboxAuthenticateComplete(error, client) {
    if (error) {
      print('dropboxAuthenticateComplete error - ' + error);
      completer.completeError(error);
    } else {
      print('dropboxAuthenticateComplete all good!');
      Future<Map> future = loadCurrent();
      future.then((current) => completer.complete(current));
      future.catchError((error) => completer.completeError(error));
    }
  }

  dbClient.authenticate(allowInterop(dropboxAuthenticateComplete));
}

Future<Map> loadCurrent() {
  Completer<Map> completer = new Completer<Map>();

  void readComplete(error, data, stat, rangeInfo) {
    if (error) {
      print('readComplete error - ' + error);
      completer.completeError(error);
    } else {
      print('readComplete all good!');
      var current = JSON.decode(data);

      completer.complete(current);
    }
  }
  dbClient.readFile('/logan_arcade/current.json', null, allowInterop(readComplete));

  return completer.future;
}

/*
  Future<Dropbox> saveCurrent(Tournament tournament, Dropbox dbClient) {
    Completer<Dropbox> completer = new Completer<Dropbox>();

    void writeComplete(error, stat) {
      if (error) {
        print('writeComplete error - ' + error);
        completer.completeError(error);
      } else {
        print('writeComplete all good!');
        completer.complete(dbClient);
      }
    }
    var data = {
      "roster": [],
      "machines": [],
      "active_machines": [],
      "active_players": [],
      "match_history": [],
      "rankings": [],
    };
    for (Player player in players) {
      data["roster"].add({"name": player.name});
    }
    for (Machine machine in machines) {
      data["machines"].add({"name": machine.name});
    }
    String json = JSON.encode(data);
    dbClient.writeFile('/logan_arcade/${tournament.tagName}.json', json, null, allowInterop(writeComplete));

    return completer.future;
  }
*/