// Copyright (c) 2016, pdex. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

/*
(custom-set-variables
  '(dart-analysis-server-snapshot-path
    "/usr/local/Cellar/dart/1.17.1/libexec/bin/snapshots/analysis_server.dart.snapshot"))
(setq dart-enable-analysis-server t)
(add-hook 'dart-mode-hook 'flycheck-mode)
*/

import 'dart:collection';
import 'dart:html';
import 'dart:math';

class Player {
  String name;
  Player(this.name);
  int wins = 0;
  int losses = 0;
//   num get score => this.wins / (this.wins + this.losses);
  num get score {
    if (this.wins + this.losses == 0) {
      return 0.0;
    }
    else {
      return this.wins / (this.wins + this.losses);
    }
  }
  void win() {
    this.wins++;
  }
  void lose() {
    this.losses++;
  }
}

class Location {
  String name;
  Player loser;
  Location(this.name);
}

class Match {
  Location location;
  Player first;
  Player second;
  Player loser;
  Player winner;
  Match(this.location, this.first, this.second);
}

var players = [
  new Player('Alice'),
  new Player('Bob'),
  new Player('Charlie'),
  new Player('Dana'),
  new Player('Eric'),
  new Player('Freya'),
  new Player('Gilbert'),
  new Player('Ida'),
];

var locations = [
  new Location('Scared Stiff'),
  new Location('Metallica'),
  new Location('Ghostbusters'),
];

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
  if (match.location.loser == loser) {
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
  Match nextMatch = new Match(match.location, first, second);
  match.location.loser = loser;
  matches[match.location.name] = nextMatch;
  matchHistory.add(match);
  waitQueue.addLast(toQueue);
  renderMatches(querySelector('#matches'), matches);
  renderQueue(querySelector('#waiting'), waitQueue);
  renderHistory(querySelector('#history'), matchHistory);
  renderRanking(querySelector('#ranking'), rankedList);
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

    var location = new Element.tag('span');
    location.text = '@ ${match.location.name}';

    item.nodes.add(first);
    item.nodes.add(firstWinner);
    item.nodes.add(vs);
    item.nodes.add(second);
    item.nodes.add(secondWinner);
    item.nodes.add(location);

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

    var location = new Element.tag('span');
    location.text = '@ ${match.location.name}';

    item.nodes.add(winner);
    item.nodes.add(defeated);
    item.nodes.add(loser);
    item.nodes.add(location);

    container.children.add(item);
  }
}

void main() {
  players.shuffle(random);
  locations.shuffle(random);
  rankedList.addAll(players);
  int location_idx = 0;
  Player first = null;
  for (var player in players) {
    if (location_idx < locations.length) {
      Location location = locations[location_idx];
      if (first == null) {
        first = player;
      } else {
        Match match = new Match(location, first, player);
        matches[location.name] = match;
        location_idx += 1;
        first = null;
      }
    } else {
      // stuff players into queue
      waitQueue.addLast(player);
    }
  }
  renderMatches(querySelector('#matches'), matches);
  renderQueue(querySelector('#waiting'), waitQueue);
  renderHistory(querySelector('#history'), matchHistory);
  renderRanking(querySelector('#ranking'), rankedList);
}