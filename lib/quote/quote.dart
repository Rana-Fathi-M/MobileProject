class Quote {
  String quote;
  String author;
  String category;
  Quote({required this.quote, required this.author, required this.category});

  //string l howa l key w el value el howa dynamic lw anwa3 tania gaya f value
  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      quote: json['quote'],
      author: json['author'],
      category: json['category'],
    );
  }
}
