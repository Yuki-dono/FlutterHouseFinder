class PropertyData {
  final int propID;
  final String propName;
  final String propLocation;
  final double propPrice;
  final String propTag;
  final List<String> propURL;

  PropertyData({
    required this.propID,
    required this.propName,
    required this.propLocation,
    required this.propPrice,
    required this.propTag,
    required this.propURL,
  });

  //FromJSON - fetching/grabbing data from the database
  factory PropertyData.fromJSON(Map<String, dynamic> json){
    return PropertyData(
      propID: json['id'],
      propName: json['name'], 
      propLocation: json['location'], 
      propPrice: json['price'], 
      propTag: json['tagName'],
      propURL: List<String>.from(json['imageURL']),
    );
  }

  //ToJSON - returning of the data to the database
  Map<dynamic, dynamic> toJson(){
    return {
      'id': propID,
      'name': propName,
      'location': propLocation,
      'price': propPrice,
      'imageURL': propURL,
    };
  }
}