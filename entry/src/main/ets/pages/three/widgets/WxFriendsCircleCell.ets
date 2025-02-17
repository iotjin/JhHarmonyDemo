import { JhNinePicture, KColors } from "JhCommon";
import { WxFriendsCircleModel } from "../models/WxFriendsCircleModel";


@Preview
@Component
export struct WxFriendsCircleCell {
  @State model: WxFriendsCircleModel = new WxFriendsCircleModel();
  public onClickCell?: (model: WxFriendsCircleModel) => void // 点击cell
  public onClickHeadPortrait?: (model: WxFriendsCircleModel) => void
  public onClickComment?: (model: WxFriendsCircleModel) => void

  build() {
    Column() {
      Row() {
        Row() {
          Text(this.model.name?.substring(0, 1))
            .fontSize(20)
            .fontColor(Color.White)
        }
        .justifyContent(FlexAlign.Center)
        .width(50)
        .height(50)
        .margin(15)
        .borderRadius(8)
        .backgroundColor(this.model.color)
        .onClick(() => this.onClickHeadPortrait?.(this.model))

        Column() {
          Text(this.model.name)
            .fontSize(15)
            .fontColor(KColors.wxTextBlueColor)
            .margin({ top: 13 })
          Text(this.model.content)
            .fontSize(13)
            .margin({ top: 5, right: 15, bottom: 5 })
          this.imagesWidget()
          Row() {
            Text(this.model.time)
              .fontSize(13)
              .fontColor(KColors.kLightGreyTextColor)

            Image($rawfile('wechat/discover/ic_diandian.png'))
              .width(30)
              .height(20)
              .backgroundColor('rgba(240,240,240,1)')
              .borderRadius(5)
              .onClick(() => this.onClickComment?.(this.model))
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
        }
        .margin({ top: 5, right: 15, bottom: 10 })
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)
      }
      .alignItems(VerticalAlign.Top)

      Divider().color(KColors.kLineColor).strokeWidth(0.5)
    }
    .backgroundColor(Color.White)
    .onClick(() => this.onClickCell?.(this.model))
  }

  @Builder
  imagesWidget() {
    JhNinePicture({
      images: this.model.images,
      onPress: (index: number) => {
        console.error('index', JSON.stringify(index))
      }
    })
  }
}
