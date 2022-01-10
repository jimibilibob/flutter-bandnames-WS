class Band {
  String id;
  String name;
  int votes;

  Band({required this.id, required this.name, this.votes = 0});

  factory Band.fromMap(Map<String, dynamic> obj) => Band(
      id: obj['id'] ?? 'no-id',
      name: obj['name'] ?? 'no-name',
      votes: obj['votes'] ?? 'no-votes');
}
