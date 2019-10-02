// TODO(Sayeed): Is this a good name for this mixin
import 'package:flutter/material.dart';

mixin LaunchSetupMember {
  Future<void> load();
}

class LaunchSetup {
  LaunchSetup({@required this.members});
  final List<LaunchSetupMember> members;

  Future<void> load() async {
    for (LaunchSetupMember member in members) {
      await member.load();
    }
  }
}
