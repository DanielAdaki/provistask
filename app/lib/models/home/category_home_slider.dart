class CategoryHomeSlider {
  String id;
  String text;
  String slug;
  String? image;
  String? url;
  CategoryHomeSlider(
      {required this.id,
      required this.text,
      required this.slug,
      this.image,
      this.url});
  String getId() {
    return id;
  }

  void setId(String newId) {
    id = newId;
  }

  String getText() {
    return text;
  }

  void setText(String newText) {
    text = newText;
  }

  String getImage() {
    return image ?? "";
  }

  void setImage(String newImage) {
    image = newImage;
  }

  String getUrl() {
    return url ?? "";
  }

  void setUrl(String newUrl) {
    url = newUrl;
  }
}
