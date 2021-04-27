class Item {
  int id;
  String name;
  String text;
  String date;

  Item({this.id, this.name, this.text, this.date});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    text = json['text'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['text'] = this.text;
    data['date'] = this.date;
    return data;
  }

  @override
  String toString() {
    return 'Item(id: $id, name: $name, text: $text, date: $date)';
  }
}
