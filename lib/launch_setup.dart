abstract class SetUpCompliant {
  Future<void> load();
}

class LaunchSetup implements SetUpCompliant {
  LaunchSetup([this.setUpParticipants]);
  final List<SetUpCompliant> setUpParticipants;
  @override
  Future<void> load() async {
    for (SetUpCompliant participant in setUpParticipants) {
      await participant.load();
    }
  }
}
