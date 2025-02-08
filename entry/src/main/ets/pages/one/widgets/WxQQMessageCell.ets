import { ComposeListItem } from "@kit.ArkUI";
import { WxQQMessageModel } from "../models/WxQQMessageModel";


@Preview
@Component
export struct WxQQMessageCell {
  model: WxQQMessageModel = new WxQQMessageModel();
  public onClickCell?: (model: WxQQMessageModel) => void // 点击cell

  build() {
    Column() {
      ComposeListItem({
        contentItem: ({
          primaryText: this.model.title,
          secondaryText: this.model.subtitle,
        }),
      })
    }
    .margin({ left: 15, right: 15 })
    .padding({ top: 5, bottom: 5 })
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
