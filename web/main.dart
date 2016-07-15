// Copyright (c) 2016, pdex. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

/*
(custom-set-variables
  '(dart-analysis-server-snapshot-path
    "/usr/local/Cellar/dart/1.17.1/libexec/bin/snapshots/analysis_server.dart.snapshot"))
(setq dart-enable-analysis-server t)
(add-hook 'dart-mode-hook 'flycheck-mode)
*/

import 'dart:async';
import 'dart:collection';
//import 'dart:convert';
import 'dart:html';
import 'dart:math';
import 'package:pinball_pinball_pinball/storage.dart';

var seedData = {
  "players": [
    {"name": "Aileen S", "tags": ["Season-4"]},
    {"name": "Alex R", "tags": ["Season-4", "Px3-2016-07-05"]},
    {"name": "Alie A", "tags": ["Season-4"]},
    {"name": "Anthony P", "tags": ["Season-4"]},
    {"name": "Ben V", "tags": ["Season-4"]},
    {"name": "Bob T", "tags": ["Season-4", "Px3-2016-07-05"]},
    {"name": "Bobby L", "tags": ["Season-4"]},
    {"name": "Chris K", "tags": ["Season-4", "Px3-2016-07-05"]},
    {"name": "Collin J", "tags": ["Season-4", "Px3-2016-07-05"]},
    {"name": "Crista L", "tags": ["Season-4", "Px3-2016-07-05"]},
    {"name": "Dan M", "tags": ["Season-4", "Px3-2016-07-05"]},
    {"name": "Dana M", "tags": ["Px3-2016-07-05"]},
    {"name": "Dave F", "tags": ["Px3-2016-07-05"]},
    {"name": "Drew P", "tags": ["Season-4", "Px3-2016-07-05"]},
    {"name": "Ed L", "tags": ["Season-4"]},
    {"name": "Eric P", "tags": ["Season-4"]},
    {"name": "Eric T", "tags": ["Px3-2016-07-05"]},
    {"name": "Erik L", "tags": ["Season-4", "Px3-2016-07-05"]},
    {"name": "Hobbs", "tags": ["Px3-2016-07-05"]},
    {"name": "Ian T", "tags": ["Season-4", "Px3-2016-07-05"]},
    {"name": "Isaac C", "tags": ["Season-4", "Px3-2016-07-05"]},
    {"name": "Jane V", "tags": ["Season-4"]},
    {"name": "Jesse I", "tags": ["Season-4"]},
    {"name": "Jordan R", "tags": ["Season-4"]},
    {"name": "Kate P", "tags": ["Season-4"]},
    {"name": "Keegan K", "tags": ["Season-4"]},
    {"name": "Kelly J", "tags": ["Season-4"]},
    {"name": "Kevin B", "tags": ["Px3-2016-07-05"]},
    {"name": "Laurel", "tags": ["Px3-2016-07-05"]},
    {"name": "Leslie R", "tags": ["Px3-2016-07-05"]},
    {"name": "Linus L", "tags": ["Season-4"]},
    {"name": "Lisa", "tags": ["Season-4"]},
    {"name": "Margarito", "tags": ["Px3-2016-07-05"]},
    {"name": "Mark P", "tags": ["Season-4"]},
    {"name": "Mark S", "tags": ["Season-4"]},
    {"name": "Matt C", "tags": ["Season-4"]},
    {"name": "Matt K", "tags": ["Season-4"]},
    {"name": "Matt S", "tags": ["Season-4"]},
    {"name": "Mike G", "tags": ["Px3-2016-07-05"]},
    {"name": "Nancy", "tags": ["Season-4"]},
    {"name": "Noel S", "tags": ["Season-4", "Px3-2016-07-05"]},
    {"name": "Rachel K", "tags": ["Px3-2016-07-05"]},
    {"name": "Raquel Y", "tags": ["Season-4", "Px3-2016-07-05"]},
    {"name": "Rebecca H", "tags": ["Season-4", "Px3-2016-07-05"]},
    {"name": "Renee K", "tags": ["Season-4"]},
    {"name": "Rob H", "tags": ["Season-4"]},
    {"name": "Ryan O", "tags": ["Px3-2016-07-05"]},
    {"name": "Sara I", "tags": ["Px3-2016-07-05"]},
    {"name": "Scott L", "tags": ["Season-4", "Px3-2016-07-05"]},
    {"name": "Scott W", "tags": ["Season-4"]},
    {"name": "Shaun R", "tags": ["Season-4"]},
    {"name": "Sheryl S", "tags": ["Season-4"]},
    {"name": "Tavi V", "tags": ["Season-4"]},
    {"name": "Thomas KK", "tags": ["Season-4"]},
    {"name": "Todd K", "tags": ["Season-4"]},
    {"name": "Victor", "tags": ["Season-4"]},
    {"name": "Will R", "tags": ["Season-4", "Px3-2016-07-05"]}
  ],
  "machines": [
    {"name": "AC/DC", "tags": ["Season-4"]},
    {"name": "Addams Family", "tags": ["Season-4"]},
    {"name": "Big Game", "tags": ["Season-4"]},
    {"name": "Blackout", "tags": ["Season-4"]},
    {"name": "Contact", "tags": ["Season-4"]},
    {"name": "Doctor Dude", "tags": ["Season-4"]},
    {"name": "Dr Who", "tags": ["Season-4"]},
    {"name": "Elvira", "tags": ["Season-4"]},
    {"name": "Fire", "tags": ["Season-4"]},
    {"name": "Game of Thrones", "tags": ["Season-4"]},
    {"name": "Gorgar", "tags": ["Season-4"]},
    {"name": "Judge Dredd", "tags": ["Season-4"]},
    {"name": "KISS", "tags": ["Season-4"]},
    {"name": "Medieval Madness", "tags": ["Season-4"]},
    {"name": "Mousin' Around", "tags": ["Season-4"]},
    {"name": "Mustang", "tags": ["Season-4"]},
    {"name": "Pinbot", "tags": ["Season-4"]},
    {"name": "Radical", "tags": ["Season-4"]},
    {"name": "Revenge From Mars", "tags": ["Season-4"]},
    {"name": "Star Trek", "tags": ["Season-4"]},
    {"name": "Star Trek TNG", "tags": ["Season-4"]},
    {"name": "Star Wars", "tags": ["Season-4"]},
    {"name": "TRON", "tags": ["Season-4"]},
    {"name": "Twilight Zone", "tags": ["Season-4"]},
    {"name": "WWE", "tags": ["Season-4"]},
    {"name": "Walking Dead", "tags": ["Season-4"]},
    {"name": "White Water", "tags": ["Season-4"]}
  ]
};

class Player {
  String name;
  String id;
  String activeId;
  Player(String name) {
    this.name = name;
    this.id = 'player-' + name.toLowerCase().replaceAll(new RegExp(r'[^a-z]'), '-');
    this.activeId = 'active-' + this.id;
  }
  int wins = 0;
  int losses = 0;
  num score = 0.0;
//   num get score => this.wins / (this.wins + this.losses);
  /*
  num get score {
    if (this.wins + this.losses == 0) {
      return 0.0;
    }
    else {
      return this.wins / (this.wins + this.losses);
    }
  }
  */
  void calcScore() {
    this.score = this.wins / (this.wins + this.losses);
  }
  void win() {
    this.wins++;
    calcScore();
  }
  void lose() {
    this.losses++;
    calcScore();
  }
}

class Location {
  String name;
  Player loser;
  Location(this.name);
}

class Machine {
  String name;
  String id;
  String activeId;
  Player loser;
  Machine(String name) {
    this.name = name;
    this.id = 'machine-' + name.toLowerCase().replaceAll(new RegExp(r'[^a-z]'), '-');
    this.activeId = 'active-' + this.id;
  }
}

class Match {
  Machine machine;
  Player first;
  Player second;
  Player loser;
  Player winner;
  Match(this.machine, this.first, this.second);
}

class Tournament {
  String name;
  String tagName;
  Tournament(String name) {
    this.name = name;
    this.tagName = name.replaceAll(new RegExp(r' '), '-');
  }
}

class PinballX3 {
  //Dropbox dbClient;
  var current = null;

  bool started = false;

  var players = [];

  var activePlayers = [];

  var machines = [];

  var activeMachines = [];

  var matches = new SplayTreeMap<String, Match>();

  var matchHistory = new List<Match>();

  var waitQueue = new ListQueue<Player>();

  var rankedList = new List<Player>();

  var random = new Random.secure();

  void _winner(Match match, Player winner, Player loser) {
    match.loser = loser;
    match.winner = winner;
    loser.lose();
    winner.win();
    Player toQueue;
    Player fromQueue = waitQueue.removeFirst();
    if (match.machine.loser == loser) {
      // player has lost twice on this machine, send them to the back of the queue
      toQueue = loser;
    } else {
      // send the winner to the back of the queue
      toQueue = winner;
    }
    Player first;
    Player second;
    if (match.first == toQueue) {
      first = fromQueue;
      second = match.second;
    } else {
      first = match.first;
      second = fromQueue;
    }
    Match nextMatch = new Match(match.machine, first, second);
    match.machine.loser = loser;
    matches[match.machine.name] = nextMatch;
    matchHistory.add(match);
    waitQueue.addLast(toQueue);
    render();
  }

  Element build(Element e, Function f) {
    f(e);
    return e;
  }

  void renderPlayers(UListElement container) {
    container.children.clear();
    for (Player player in players) {
      var item = new LIElement();

      void selected(player, item) {
        print('selected - ${player.name}');

        activePlayers.add(player);
        item.style.display = "none";
        renderActivePlayers();
      }
      item.nodes.add(build(new CheckboxInputElement(), (e) {e.id = player.id; e.onChange.listen((e) => selected(player, item));}));
      item.nodes.add(build(new Element.tag('label'), (e) {e.text = player.name; e.htmlFor = player.id;}));

      container.children.add(item);
    }
  }

  void renderActivePlayers() {
    UListElement container = querySelector('#starting_players');
    container.children.clear();

    for (Player player in activePlayers) {
      var item = new LIElement();

      Element build(Element e, Function f) {
        f(e);
        return e;
      }

      void selected(player) {
        print('selected - ${player.name}');

        activePlayers.remove(player);
        var playerItem = querySelector('#${player.id}');
        print(playerItem);
        print('checked - ${playerItem.checked}');
        playerItem.checked = false;
        print('checked - ${playerItem.checked}');
        playerItem.parent.style.display = "list-item";
        renderActivePlayers();
      }
      item.nodes.add(build(new CheckboxInputElement(), (e) {e.id = 'active-player-${player.id}'; e.onChange.listen((e) => selected(player));}));
      item.nodes.add(build(new Element.tag('label'), (e) {e.text = player.name; e.htmlFor = 'active-player-${player.id}';}));
      container.children.add(item);
    }
  }

  void renderMachines() {
    UListElement container = querySelector('#machines');
    container.children.clear();
    for (Machine machine in machines) {

      void selected(machine, item) {
        print('selected - ${machine.name}');

        activeMachines.add(machine);
        renderActiveMachines();
      }
      container.nodes.add(build(new CheckboxInputElement(), (e) {
        e.id = machine.id;
        e.onChange.listen((e) => selected(machine, e));
        e.classes.add("hidden-checkbox");
        if (activeMachines.contains(machine)) {
          e.checked = true;
        }
      }));
      container.nodes.add(build(new Element.tag('label'), (e) {
        e.text = machine.name;
        e.htmlFor = machine.id;
        e.classes.add("label-item");
      }));

    }
  }

  void renderActiveMachines() {
    UListElement container = querySelector('#starting_machines');
    container.children.clear();

    for (Machine machine in activeMachines) {

      void selected(machine) {
        print('selected - ${machine.name}');

        activeMachines.remove(machine);
        var machineItem = querySelector('#${machine.id}');
        machineItem.checked = false;
        //machineItem.parent.style.display = "list-item";
        renderActiveMachines();
      }
      container.nodes.add(build(new CheckboxInputElement(), (e) {
        e.id = machine.activeId;
        e.onChange.listen((e) => selected(machine));
        e.classes.add("hidden-checkbox");
      }));
      container.nodes.add(build(new Element.tag('label'), (e) {
        e.text = machine.name;
        e.htmlFor = machine.activeId;
        e.classes.add("label-item");
      }));
    }
  }

  void renderMatches(UListElement container, var matches) {
    container.children.clear();
    for (var key in matches.keys) {
      var match = matches[key];
      var item = new LIElement();

                  var first = new Element.tag('span');
      first.text = match.first.name;
      var firstWinner = new Element.tag('a');
      firstWinner.text = '[Winner]';
      firstWinner.onClick.listen((e) => _winner(match, match.first, match.second));

      var vs = new Element.tag('span');
      vs.text = 'vs';

      var second = new Element.tag('span');
      second.text = match.second.name;
      var secondWinner = new Element.tag('a');
      secondWinner.text = '[Winner]';
      secondWinner.onClick.listen((e) => _winner(match, match.second, match.first));

      var machine = new Element.tag('span');
      machine.text = '@ ${match.machine.name}';

      item.nodes.add(first);
      item.nodes.add(firstWinner);
      item.nodes.add(vs);
      item.nodes.add(second);
      item.nodes.add(secondWinner);
      item.nodes.add(machine);

      container.children.add(item);
    }
  }

  void renderQueue(OListElement container, var queue) {
    container.children.clear();
    for (var player in queue) {
      var item = new LIElement();
      item.text = '${player.name} (${player.wins}/${player.losses} :: ${player.score})';
      container.children.add(item);
    }
  }

  void renderRanking(OListElement container, var players) {
    container.children.clear();
    rankedList.sort((a, b) => b.score.compareTo(a.score));
    for (var player in rankedList) {
      var item = new LIElement();
      item.text = '${player.name} (${player.wins}/${player.losses} :: ${player.score})';
      container.children.add(item);
    }
  }


  void renderHistory(UListElement container, var history) {
    container.children.clear();
    for (var match in history) {
      var item = new Element.tag('li');
      var winner = new Element.tag('span');
      winner.text = match.winner.name;
      var defeated = new Element.tag('span');
      defeated.text = 'defeated';

                  var loser = new Element.tag('span');
      loser.text = match.loser.name;

      var machine = new Element.tag('span');
      machine.text = '@ ${match.machine.name}';

      item.nodes.add(winner);
      item.nodes.add(defeated);
      item.nodes.add(loser);
      item.nodes.add(machine);

      container.children.add(item);
    }
  }

  void render() {
    renderMatches(querySelector('#matches'), matches);
    renderQueue(querySelector('#waiting'), waitQueue);
    renderHistory(querySelector('#history'), matchHistory);
    renderRanking(querySelector('#ranking'), rankedList);
  }

  void useCannedData(Completer<Map> completer) {
    completer.complete(seedData);
  }

  Future<Map> setupPlayers(Map current) {
    print('setupPlayers');

    players.clear();
    for (var player in current["players"]) {
      players.add(new Player(player["name"]));
    }
    Completer<Map> completer = new Completer<Map>();

    players.sort((a, b) => a.name.compareTo(b.name));

    querySelector('#starting_players').nodes.clear();
    querySelector('#late_players').nodes.clear();
    renderPlayers(querySelector('#players'));

    completer.complete(current);

    return completer.future;
  }

  Future<Map> setupMachines(Map current) {
    print('setup machines');
    Completer<Map> completer = new Completer<Map>();

    machines.clear();
    for (var machine in current["machines"]) {
      machines.add(new Machine(machine["name"]));
    }

    querySelector('#starting_machines').nodes.clear();
    querySelector('#replacement_machines').nodes.clear();
    renderMachines();

    completer.complete(current);
    return completer.future;
  }

  Future<bool> setup(Map current) {
    print('setup');
    Completer<bool> completer = new Completer<bool>();
    this.current = current;

    var tab = querySelector('#tab-setup');
    tab.checked = true;

    var start = querySelector('#start_playing');
    start.onClick.listen((_) {
      completer.complete(true);
      var tabMatches = querySelector('#tab-matches');
      tabMatches.checked = true;
      start.disabled = true;
    });

    return completer.future;
  }

  void startPlaying(bool started) {
    print('startPlaying');
    this.started = started;

    activePlayers.shuffle(random);
    activeMachines.shuffle(random);
    rankedList.addAll(activePlayers);
    int machine_idx = 0;
    Player first = null;
    for (var player in activePlayers) {
      if (machine_idx < activeMachines.length) {
        Machine machine = activeMachines[machine_idx];
        if (first == null) {
          first = player;
        } else {
          Match match = new Match(machine, first, player);
          matches[machine.name] = match;
          machine_idx += 1;
          first = null;
        }
      } else {
        // stuff players into queue
        waitQueue.addLast(player);
      }
    }
    render();
  }

  Future<Map> load() {
    Completer<Map> completer = new Completer<Map>();
    Element loadTab = querySelector('#tab-content-load');
    var list = new Element.tag('ul');

    // login to dropbox
    // else
    list.nodes.add(build(new Element.tag('li'), (e) {
      e.nodes.add(build(new Element.tag('a'), (a) {
        a.text = 'Load from dropbox';
        a.onClick.listen((_) => setupDropbox(completer));
     }));
    }));
    list.nodes.add(build(new Element.tag('li'), (e) {
      e.nodes.add(build(new Element.tag('a'), (a) {
        a.text = 'Use canned data';
        a.onClick.listen((_) => useCannedData(completer));
      }));
    }));

    loadTab.children.add(list);

    return completer.future;
  }

  void start() {
      //setupDropbox().then(loadCurrent).then(setupPlayers).then(setup);
    //load().then(setup).then(run);
    load().then(setupPlayers).then(setupMachines).then(setup).then(startPlaying);
  }
}
void main() {
  new PinballX3().start();
}