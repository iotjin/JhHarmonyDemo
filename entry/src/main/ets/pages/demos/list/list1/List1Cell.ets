import { List1Model, ListType } from "./List1Model"

@Preview
@Component
export struct List1Cell {
  model: List1Model = new List1Model();
  public onClickCell?: () => void // 点击cell

  build() {
    Column() {
      Row() {
        Text(this.model.title).fontSize(18)
        Row() {
          Text(this.model.state).fontSize(15)
          Blank().width(10)
          Image(this.model.imageUrl).width(30).height(30)
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Blank().height(6)
      Text(this.model.phone).fontSize(15)
      Blank().height(6)
      Text(this.model.content).fontSize(15)
    }
    .onClick(() => this.onClickCell?.())
    .alignItems(HorizontalAlign.Start)
    .padding(15)
    .backgroundColor(Color.White)
  }
}
