final String tableQuotes = 'quotes';

class QuoteFields {
  static final List<String> values = [id, quote];

  static final String id = '_id';
  static final String quote = 'quote';
}

class Quote {
  final int? id;
  final String quote;

  const Quote({
    this.id,
    required this.quote,
  });

  Map<String, Object?> toJson() =>
      {QuoteFields.id: id, QuoteFields.quote: quote};

  Quote copy({
    int? id,
    String? quote,
  }) =>
      Quote(id: id ?? this.id, quote: quote ?? this.quote);

  static Quote fromJson(Map<String, Object?> json) => Quote(
        id: json[QuoteFields.id] as int?,
        quote: json[QuoteFields.quote] as String,
      );

  String toString() {
    return this.quote;
  }
}
