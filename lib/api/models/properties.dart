class PropertyData {
  final int pID;
  final DateTime dateAdded;
  final String pName;
  final String pLocation;
  final double pPrice;
  final String pURL;

  PropertyData({
    required this.pID,
    required this.dateAdded,
    required this.pName,
    required this.pLocation,
    required this.pPrice,
    required this.pURL
  });

  //FromJSON
  factory PropertyData.fromJSON(Map<String, dynamic> json){
    return PropertyData(
      pID: pID, 
      dateAdded: dateAdded, 
      pName: pName, 
      pLocation: pLocation, 
      Price: pPrice, 
      pURL: pURL
    );
  }

  //ToJSON
}