

class Product {
  String title;
  String imgUrl;
  double price;
  int qty;

  Product({this.title, this.price, this.imgUrl, this.qty});
}

double totalCost = 0.00;

List <Product> breads = [
  Product(
    title: "Plain Bagel",
    imgUrl: "assets/images/bagel.jpg",
    price: 3.40,
    qty: 0,
  ),
  Product(
      title: "Salted Pretzel",
      imgUrl: "assets/images/pretzel.png",
      price: 2.90,
      qty: 0,
  ),
  Product(
      title: "Rye Sourdough",
      imgUrl: "assets/images/sourdough.png",
      price: 6.50,
      qty: 0,
  ),
];

void resetEntries() {
  breads.forEach((e) {
    e.qty = 0;
    totalCost = 0.00;
  });
}
