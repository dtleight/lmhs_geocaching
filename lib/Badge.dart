class Badge
{
  String imageSRC;
  bool isObtained;
  String description;
  DateTime unlockDate;


  //Constructor
  Badge(String src)
  {
    this.imageSRC = src;
  }

  getSrc()
  {
    if(isObtained)
      {
        return imageSRC;
      }
    return imageSRC.substring(0,imageSRC.indexOf(".jpg"))+"(grayscale).jpg";
  }
}