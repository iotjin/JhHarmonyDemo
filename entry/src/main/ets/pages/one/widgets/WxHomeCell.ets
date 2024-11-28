import { WxHomeModel } from "../models/WxHomeModel";


@Preview
@Component
export struct WxHomeCell {
  model: WxHomeModel = new WxHomeModel();
  public onClickCell?: (model: WxHomeModel) => void // 点击cell

  build() {
    Row() {
      Row() {
        // Image($rawfile(this.model.img))
        //   .width(55).height(55)
        //   .borderRadius(5)
        //   .clip(true)

        Badge({ value: '', position: { x: 55 - 5, y: -5 }, style: { badgeSize: this.model.isNew ? 10 : 0, badgeColor: '#FA2A2D' } }) {
          Image($rawfile(this.model.img))
            .width(55)
            .height(55)
            .borderRadius(5)
            .clip(true)
        }
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .width(70)
      .height(70)

      Column() {
        Blank().height(8)
        Row() {
          Flex() {
            Text(this.model.title)
              .flexGrow(70)
              .fontSize(18)
            Text(this.model.time)
              .flexGrow(30)
              .fontSize(13)
              .fontColor(Color.Gray)
              .textAlign(TextAlign.End)
            Blank().width(10)
          }
        }
        .justifyContent(FlexAlign.Start)

        Blank().height(8)

        Text(this.model.subtitle)
          .fontSize(15)
          .fontColor(Color.Gray)
      }
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Start)
      .layoutWeight(1)
    }
    .justifyContent(FlexAlign.Start)
    .alignItems(VerticalAlign.Top)
    .width('100%')
    .height(70)
    .backgroundColor(Color.White)
    .onClick(() => this.onClickCell?.(this.model))
  }
}
