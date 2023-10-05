import 'dart:convert';

class TagEpc {
  final String epc;
  final String rssi;

  TagEpc({
    required this.epc,
    required this.rssi,
  });

  factory TagEpc.fromMap(Map<String, dynamic> json) => TagEpc(
        epc: json["epc"],
        rssi: json["rssi"],
      );

  Map<String, dynamic> toMap() => {
        "epc": epc,
        "rssi": rssi,
      };

  static List<TagEpc> parseTags(String str) =>
      List<TagEpc>.from(json.decode(str).map((x) => TagEpc.fromMap(x)));

  static String tagEpcToJson(List<TagEpc> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
}
