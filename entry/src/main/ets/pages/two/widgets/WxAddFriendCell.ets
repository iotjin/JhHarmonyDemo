import { ComposeListItem } from "@kit.ArkUI";
import { WxAddFriendModel } from "../models/WxAddFriendModel";


@Preview
@Component
export struct WxAddFriendCell {
  model: WxAddFriendModel = new WxAddFriendModel();
  public onClickCell?: (model: WxAddFriendModel) => void // 点击cell

  build() {
    Column() {
      ComposeListItem({
        contentItem: ({
          iconStyle: 4,
          icon: $rawfile(this.model.img),
          primaryText: this.model.title,
          secondaryText: this.model.subtitle,
        }),
        operateItem: ({
          icon: {
            value: $rawfile("common/ic_arrow_black.png"),
          },
        })
      })

    }
    .backgroundColor(Color.White)
    .onClick(() => this.onClickCell?.(this.model))
  }
}
