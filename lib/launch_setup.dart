// TODO(Sayeed): Is this a good name for this mixin
mixin SetUpCompliant {
  Future<void> load();
}

class LaunchSetup with SetUpCompliant {
  LaunchSetup([this.setUpParticipants]);
  final List<SetUpCompliant> setUpParticipants;
  @override
  Future<void> load() async {
    for (SetUpCompliant participant in setUpParticipants) {
      await participant.load();
    }
  }
}
