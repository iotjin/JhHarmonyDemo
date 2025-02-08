import { WxSubscriptionNumberListModel } from "../models/WxSubscriptionNumberListModel";


@Preview
@Component
export struct WxSubscriptionNumberListCell {
  model: WxSubscriptionNumberListModel = new WxSubscriptionNumberListModel();
  public onClickCell?: (model: WxSubscriptionNumberListModel) => void // 点击cell

  build() {
    Column() {
      Row() {
        Image($rawfile(this.model.img))
          .width(60)
          .height(60)
          .borderRadius(5)
          .padding(10)
        Column() {
          Row() {
            Text(this.model.title).fontSize(18).layoutWeight(70)
            Text(this.model.time)
              .fontSize(13)
              .fontColor(Color.Gray)
              .textAlign(TextAlign.End)
              .margin({ right: 15 })
              .layoutWeight(30)
          }

          Blank().height(6)
          Text(this.model.subtitle)
            .fontSize(13)
            .fontColor(Color.Gray)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .maxLines(1)
            .padding(3)
        }
        .layoutWeight(1)
      }
      .width('100%')
      .margin({
        top: 10,
        bottom: 10
      })

      Divider().margin({ left: 60, right: 10 })
    }
    .backgroundColor(Color.White)

    // .margin({ left: 15, right: 15 })
    // .borderRadius(10)
    // .backgroundColor(Color.White)
    // .shadow({
    //   radius: 5,
    //   color: '#bebebe',
    //   offsetX: 0,
    //   offsetY: 10,
    // })
    .onClick(() => this.onClickCell?.(this.model))
  }
}
