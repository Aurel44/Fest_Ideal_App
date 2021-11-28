class Band {
  final String name;
  final String musicstyle;

  Band(this.name, this.musicstyle);

  Band.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        musicstyle = json['music_style'];

  // Map<String, dynamic> toJson() => {
  //       'name': name,
  //       'music_style': music_style
  //     };
}
