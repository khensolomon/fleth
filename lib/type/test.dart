part of data.type;

@HiveType(typeId: 12)
class Person extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  HiveList? friends;
  // late final List<String> friends;

  Person({required this.name, this.friends});

  @override
  String toString() => name;
}

class PersonAdapter extends TypeAdapter<Person> {
  @override
  final typeId = 12;

  @override
  Person read(BinaryReader reader) {
    return Person(name: reader.read())..friends = reader.read();
  }

  @override
  void write(BinaryWriter writer, Person obj) {
    writer.write(obj.name);
    writer.write(obj.friends);
  }
}

class AssFs {
  final Box<VerseSelection> box;
  const AssFs(this.box);

  // ValueListenable<Box<VerseSelection>> get listen => box.listenable;
  // ValueListenable<Box<VerseSelection>> listenable({List<dynamic>? keys})
  // ValueListenable<Box<VerseSelection>> listens({List<dynamic>? keys}) {
  //   return box.listenable(keys: keys);
  // }
  // ValueListenable<Box<VerseSelection>> listens({List<dynamic>? keys}) {
  //   return box.listenable(keys: keys);
  // }
}

@HiveType(typeId: 13)
class VerseSelection extends HiveObject {
  @HiveField(0)
  final int chapter;

  @HiveField(1)
  HiveList? verse;

  @HiveField(2)
  DateTime? date;

  VerseSelection({
    required this.chapter,
    this.verse,
    this.date,
  });
}

class VerseSelectionAdapter extends TypeAdapter<VerseSelection> {
  @override
  final typeId = 13;

  @override
  VerseSelection read(BinaryReader reader) {
    return VerseSelection(chapter: reader.read())..verse = reader.read();
  }

  @override
  void write(BinaryWriter writer, VerseSelection obj) {
    writer.write(obj.chapter);
    writer.write(obj.verse);
  }
}
