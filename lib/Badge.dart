class Badge
{
  String name;
  String imageSRC;
  bool isObtained;
  String description;
  DateTime unlockDate;


  //Constructor
  Badge(String name, String src) {
    this.name = name;
    this.imageSRC = src;
  }

  getName() {
    return name;
  }

  getSrc() {
    if(isObtained)
      {
        return imageSRC;
      }
    return imageSRC/*.substring(0,imageSRC.indexOf(".jpg"))+"(grayscale).jpg"*/;
  }

  obtained() {
    this.isObtained = true;
  }
}