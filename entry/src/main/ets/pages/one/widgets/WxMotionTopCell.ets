import { KColors } from "JhCommon";
import { WxMotionTopModel } from "../models/WxMotionTopModel";


@Preview
@Component
export struct WxMotionTopCell {
  @State model: WxMotionTopModel = new WxMotionTopModel();
  public onClickCell?: (model: WxMotionTopModel) => void // 点击cell

  build() {
    Column() {
      Blank().height(10)
      Row() {
        Text((this.model.id! + 1).toString())
          .margin({ left: 15 })
          .fontSize(16)
          .fontColor(this.model.color).layoutWeight(15)

        Row() {
          Row() {
            Text(this.model.name?.substring(0, 1))
              .fontSize(20)
              .fontColor(Color.White)
          }
          .justifyContent(FlexAlign.Center)
          .width(50)
          .height(50)
          .borderRadius(25)
          .backgroundColor(this.model.color)

          Text(this.model.name)
            .fontSize(16)
            .margin({ left: 10 })
          Blank()
          Text(this.model.steps?.toString())
            .fontSize(28)
            .fontColor(this.model.steps! > 10000 ? '#FF9800' : KColors.wxTextColor)
            .margin({ right: 20 })
        }
        .layoutWeight(70)

        Column() {
          Text(this.model.starNum?.toString())
            .fontSize(12)
            .fontColor(Color.Gray)
          Blank().height(5)

          Text() {
            SymbolSpan($r('sys.symbol.heart_fill'))
              .fontWeight(FontWeight.Bold)
              .fontSize(20)
              .fontColor([this.model.isStar ? Color.Red : Color.Gray])
          }
          .onClick(() => {
            this.model.isStar = !this.model.isStar
            if (this.model.isStar == true) {
              this.model.starNum!++
            } else {
              this.model.starNum!--
            }
          })
        }
        .layoutWeight(15)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Blank().height(10)
      Divider().color(KColors.kLineColor).strokeWidth(this.model.isOwn ? 10 : 1)
    }
    .backgroundColor(Color.White)
    .onClick(() => this.onClickCell?.(this.model))
  }
}
