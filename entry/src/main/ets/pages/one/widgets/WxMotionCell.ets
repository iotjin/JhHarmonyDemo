import { WxMotionModel } from "../models/WxMotionModel";


@Preview
@Component
export struct WxMotionCell {
  model: WxMotionModel = new WxMotionModel();
  public onClickCell?: (model: WxMotionModel) => void // 点击cell

  build() {
    Column() {
      Text(this.model.time)
        .width('100%')
        .padding(10)
        .fontSize(13)
        .fontColor(Color.Gray)
        .textAlign(TextAlign.Center)

      this.cell2()
    }
  }

  @Builder
  cell2() {
    Column() {
      Row() {
        Column() {
          Text(this.model.ranking)
            .fontSize(35)
            .fontColor(this.model.color)
          Text('名次')
            .fontSize(12)
            .fontColor(this.model.color)
        }
        .padding({ left: 30 })

        Column() {
          Text(this.model.steps)
            .fontSize(35)
            .fontColor(this.model.color)
          Text('步数')
            .fontSize(12)
            .fontColor(this.model.color)
        }
        .padding({ right: 30 })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .layoutWeight(5)

      Divider().margin({ left: 15, right: 15 })

      Row() {
        Image($rawfile(this.model.img))
          .width(40)
          .height(40)
          .borderRadius(20)
          .margin({
            left: 15,
            right: 15,
          })
        Text(this.model.text).fontColor(this.model.color).fontSize(15)
        Blank()
        Image($rawfile("common/ic_arrow_black.png")).width(18).height(18).margin({ right: 20 })
      }
      .width('100%')
      .layoutWeight(2)
    }
    .height(200)
    .margin({
      left: 15,
      right: 15,
      top: 5,
      bottom: 5
    })
    .borderRadius(10)
    .backgroundColor(Color.White)
    .shadow({
      radius: 5,
      color: '#bebebe',
      offsetX: 0,
      offsetY: 10,
    })
    .onClick(() => this.onClickCell?.(this.model))
  }
}
