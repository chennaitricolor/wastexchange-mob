abstract class SetUpCompliant {
  void load();
}

class LaunchSetup implements SetUpCompliant {
  LaunchSetup([this.setUpParticipants]);
  final List<SetUpCompliant> setUpParticipants;
  @override
  void load() {
    for (SetUpCompliant participant in setUpParticipants) {
      participant.load();
    }
  }
}
