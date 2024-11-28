export class List1Model {
  title?: string
  content?: string
  phone?: string
  imageUrl?: string
  place?: string
  state?: string
  // constructor(title: string = '', content: string, phone: string, imageUrl: string, place: string, state: string) {
  //   this.title = title
  //   this.content = content
  //   this.phone = phone
  //   this.imageUrl = imageUrl
  // }
}

export interface ListType {
  title?: string
  content?: string
  phone?: string
  imageUrl?: string
  place?: string
  state?: string
}
