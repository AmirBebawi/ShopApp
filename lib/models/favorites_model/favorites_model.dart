class FavoritesModel
{
  late bool status ;
 late FavoritesDataModel data ;
  FavoritesModel.fromJson(Map<String,dynamic>json){
    status = json['status'];
    data = FavoritesDataModel.fromJson(json['data']);
  }
}
class FavoritesDataModel
{
  late int currentPage ;
  List<DataModel> data = [];

  FavoritesDataModel.fromJson(Map<String ,dynamic> json)
  {
    currentPage = json['current_page'];
     json['data'].forEach((element){
      data.add(DataModel.fromJson(element));
    });
  }
}
class DataModel
{
  late int id ;
   late ProductsModel products  ;
  DataModel.fromJson(Map<String,dynamic>json)
  {
    id = json['id'];
    products =ProductsModel.fromJson(json['product']);
  }
}
class ProductsModel {
  late int id;

  dynamic price;

  dynamic oldPrice;

  dynamic discount;
  late String image;

  late String name;
  late String description;


  ProductsModel.fromJson(Map<String, dynamic> json) {
    id=json['id'];
    price=json['price'];
    oldPrice=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
    description=json['description'];
  }
}
