// class UserModel {
//   name: String
//   image: ResourceStr
//   price: number
//   discount: number
//   // constructor(name: String, imagee: ResourceStr, price: number, discount: number = 0) {
//   //   this.name = name
//   //   this.image = imagee
//   //   this.price = price
//   //   this.discount = discount
//   // }
// }

export class UserModel {
  userID?: string = "";
  userName?: string = "";
  phone?: string = "";
  pwd?: string = "";
  token?: string = "";
  avatarUrl?: string = "";
}