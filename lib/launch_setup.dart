// TODO(Sayeed): Is this a good name for this mixin
mixin LaunchSetupMember {
  Future<void> load();
}

class LaunchSetup {
  LaunchSetup([this.setUpParticipants]);
  final List<LaunchSetupMember> setUpParticipants;

  Future<void> load() async {
    for (LaunchSetupMember participant in setUpParticipants) {
      await participant.load();
    }
  }
}
