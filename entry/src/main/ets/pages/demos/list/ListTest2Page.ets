import { BaseNavigation } from 'JhCommon'
import { ComposeListItem, IconType, promptAction } from '@kit.ArkUI'


@Entry
@Preview
@Component
struct ListTest2Page {
  aboutToAppear() {

  }

  build() {
    Column() {
      BaseNavigation({ title: 'ListTest2 - ComposeListItem' })
      Scroll() {
        Column() {
          this.header('header')
          this.body()
        }
      }
      .layoutWeight(1)
    }
  }

  @Builder
  header(text: string) {
    Row() {
      Text(text).fontColor(Color.White)
    }
    .width('100%')
    .height(50)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(Color.Orange)
  }

  @Builder
  body() {
    List() {
      ListItem() {
        Text('Text: -1')
          .fontSize(20)
          .height(50)
          .backgroundColor("#aabbcc")
          .width('100%')
      }

      // ComposeListItem 官方文档
      // https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ohos-arkui-advanced-composelistitem-V5#composelistitem-1
      ListItem() {
        ComposeListItem({
          contentItem: ({
            // iconStyle: IconType.NORMAL_ICON,
            iconStyle: 4,
            icon: $r('sys.media.ohos_app_icon'),
            primaryText: '双行列表',
            secondaryText: '辅助文字',
            description: '描述内容文字'
          }),
          operateItem: ({
            icon: {
              value: $r('sys.media.ohos_app_icon'),
              action: () => {
                promptAction.showToast({ message: 'icon' });
              }
            },
            text: '右侧文本'
          })
        })
      }

      ListItem() {
        ComposeListItem({
          contentItem: ({
            iconStyle: IconType.SYSTEM_ICON,
            icon: $r('sys.media.ohos_app_icon'),
            primaryText: '双行列表',
            secondaryText: '辅助文字',
            description: '描述内容文字'
          }),
          operateItem: ({
            image: $r('sys.media.ohos_app_icon'),
            text: '右侧文本'
          })
        })
      }

      ListItem() {
        ComposeListItem({
          contentItem: ({
            iconStyle: IconType.SYSTEM_ICON,
            icon: $r('sys.media.ohos_app_icon'),
            primaryText: '双行列表',
            secondaryText: '辅助文字',
            // description: '描述内容文字'
          }),
          operateItem: ({
            text: '右侧文本'
          })
        })
      }

      ListItem() {
        ComposeListItem({
          contentItem: ({
            iconStyle: IconType.SYSTEM_ICON,
            icon: $r('sys.media.ohos_app_icon'),
            primaryText: '双行列表',
            secondaryText: '辅助文字',
            // description: '描述内容文字'
          }),
          operateItem: ({
            button: {
              text: '按钮'
            },
          })
        })
      }

      ListItem() {
        ComposeListItem({
          contentItem: ({
            iconStyle: IconType.SYSTEM_ICON,
            icon: $r('sys.media.ohos_app_icon'),
            primaryText: '双行列表',
            secondaryText: '辅助文字',
            // description: '描述内容文字'
          }),
          operateItem: ({
            icon: {
              value: $rawfile("common/ic_arrow_black.png"),
              action: () => {
                promptAction.showToast({ message: 'icon' });
              }
            },
            text: '右侧文本'
          })
        })
      }

      ListItem() {
        ComposeListItem({
          contentItem: ({
            iconStyle: IconType.SYSTEM_ICON,
            icon: $r('sys.media.ohos_app_icon'),
            primaryText: '双行列表',
            // secondaryText: '辅助文字',
            description: '描述内容文字'
          }),
          operateItem: ({
            checkbox: {
              isCheck: true,
              onChange: (value: boolean) => {
                console.log('value', value)
              }
            }
          })
        })
      }

      ListItem() {
        ComposeListItem({
          contentItem: ({
            iconStyle: IconType.SYSTEM_ICON,
            icon: $r('sys.media.ohos_app_icon'),
            primaryText: '双行列表',
            // secondaryText: '辅助文字',
            description: '描述内容文字'
          }),
          operateItem: ({
            checkbox: {
              isCheck: true,
              onChange: (value: boolean) => {
                console.log('value', value)
              }
            }
          })
        })
      }

      ListItem() {
        ComposeListItem({
          contentItem: ({
            iconStyle: IconType.SYSTEM_ICON,
            icon: $r('sys.media.ohos_app_icon'),
            primaryText: '双行列表',
            secondaryText: '辅助文字',
            // description: '描述内容文字'
          }),
          operateItem: ({
            switch: {
              isCheck: true,
              onChange: (value: boolean) => {
                console.log('value', value)
              }
            }
          })
        })
      }

      ListItem() {
        ComposeListItem({
          contentItem: ({
            iconStyle: IconType.SYSTEM_ICON,
            icon: $r('sys.media.ohos_app_icon'),
            primaryText: '双行列表',
            secondaryText: '辅助文字',
            // description: '描述内容文字'
          }),
          operateItem: ({
            radio: {
              isCheck: false,
              onChange: (value: boolean) => {
                console.log('value', value)
              }
            }
          })
        })
      }
    }
    .layoutWeight(1)
    .backgroundColor(Color.Yellow)
    .divider({
      strokeWidth: 1,
      // startMargin: 20,
      // endMargin: 20,
      color: Color.Gray,
    })
  }
}