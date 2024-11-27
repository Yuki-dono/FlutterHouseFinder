class PropertyData {
  int propID;
  String? userID;
  String propName;
  String propLocation;
  double propPrice;
  String propTag;
  List<String> propURL;
  bool hidden;
  double? duration;
  String? propDesc; // Add this line
  double? distance;

  PropertyData({
    required this.propID,
    required this.userID,
    required this.propName,
    required this.propLocation,
    required this.propPrice,
    required this.propTag,
    required this.propURL,
    required this.hidden,
    required this.duration,
    required this.distance,
    required this.propDesc, // Add this to the constructor
  });

  //FromJSON - fetching/grabbing data from the database
  factory PropertyData.fromJSON(Map<String, dynamic> json){
    return PropertyData(
      propID: json['id'],
      userID: json['userID'],
      propName: json['name'], 
      propLocation: json['location'], 
      propPrice: json['price'], 
      propTag: json['tagName'],
      propURL: List<String>.from(json['imageURL']),
      hidden: json['hidden'],
      propDesc: json['description'] ?? '', // Add this line with a default empty string
      duration: json['duration'],
      distance: json['distance'],
    );
  }

  //ToJSON - returning of the data to the database
  Map<dynamic, dynamic> toJson(){
    return {
      'id': propID,
      'userID': userID,
      'name': propName,
      'location': propLocation,
      'price': propPrice,
      'imageURL': propURL,
      'description': propDesc, // Add this line
      'hidden': hidden,
      'duration': duration,
      'distance': distance,
      'tagName': propTag
    };
  }
}