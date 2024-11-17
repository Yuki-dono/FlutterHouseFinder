class PropertyData {
  final int propID;
  final DateTime dateListed;
  final String propName;
  final String propLocation;
  final double propPrice;
  final String propURL;

  PropertyData({
    required this.propID,
    required this.dateListed,
    required this.propName,
    required this.propLocation,
    required this.propPrice,
    required this.propURL
  });

  //FromJSON - fetching/grabbing data from the database
  factory PropertyData.fromJSON(Map<String, dynamic> json){
    return PropertyData(
      propID: json['id'],
      propName: json['name'], 
      propLocation: json['location'], 
      propPrice: json['price'], 
      propURL: json['imageURL'],
      dateListed: json['dateListed']
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
      'dateListed': dateListed , 
    };
  }
}