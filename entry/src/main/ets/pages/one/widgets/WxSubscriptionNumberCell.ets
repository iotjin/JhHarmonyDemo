import { KColors } from "JhCommon";
import { WxSubscriptionNumberModel } from "../models/WxSubscriptionNumberModel";


@Preview
@Component
export struct WxSubscriptionNumberCell {
  model: WxSubscriptionNumberModel = new WxSubscriptionNumberModel()
  index: number = 0
  public onClickCell?: (model: WxSubscriptionNumberModel) => void // 点击cell

  build() {
    Column() {
      if (this.index % 2 == 0) {
        this.cell1()
      } else {
        this.cell2()
      }
    }
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

  @Builder
  cell1() {
    Row() {
      Image($rawfile(this.model.img2))
        .width(40)
        .height(40)
        .borderRadius(20)
        .margin({
          left: 15,
          right: 15,
        })
      Text(this.model.title).fontColor(KColors.wxTextBlueColor).fontSize(16)
      Blank()
      Text(this.model.time).fontSize(13).margin({ right: 20 })
    }
    .width('100%')
    .margin({
      top: 10,
      bottom: 10
    })

    Stack({ alignContent: Alignment.BottomStart }) {
      Image($rawfile(this.model.img1)).objectFit(ImageFit.Cover).aspectRatio(20 / 9)
      Text(this.model.subtitle)
        .fontSize(20).fontWeight(FontWeight.Bold).fontColor(Color.White)
        .margin({ left: 18, bottom: 10 })
    }

    Row() {
      Text(this.model.text2).fontColor(KColors.wxTextBlueColor).fontSize(15).layoutWeight(1)
      Blank().width(15)
      Image($rawfile(this.model.img2))
        .width(50)
        .height(50)
    }
    .width('100%')
    .padding({
      left: 15,
      right: 15,
      top: 25,
      bottom: 25
    })
  }

  @Builder
  cell2() {
    Row() {
      Image($rawfile(this.model.img2))
        .width(30)
        .height(30)
        .borderRadius(5)
        .margin({
          left: 15,
          right: 15,
        })
      Text(this.model.title)
    }
    .width('100%')
    .margin({
      top: 10,
      bottom: 10
    })

    Row() {
      Text(this.model.text2).fontColor(KColors.wxTextBlueColor).fontSize(15).layoutWeight(1)
      Blank().width(15)
      Image($rawfile(this.model.img2))
        .width(60)
        .height(60)
    }
    .width('100%')
    .padding(15)
  }
}
