class PropertyData {
  final int propID;
  final String propName;
  final String propLocation;
  final double propPrice;
  final String propTag;
  final List<String> propURL;
  final String propDesc; // Add this line

  PropertyData({
    required this.propID,
    required this.propName,
    required this.propLocation,
    required this.propPrice,
    required this.propTag,
    required this.propURL,
    required this.propDesc, // Add this to the constructor
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
      propDesc: json['description'] ?? '', // Add this line with a default empty string
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
      'description': propDesc, // Add this line
    };
  }
}