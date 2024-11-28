import { BaseNavigation } from 'JhCommon'


@Entry
@Preview
@Component
struct WxGroupChatPage {
  build() {
    Column() {
      BaseNavigation({ title: '群聊' })
      Scroll() {
        Column() {
          this.body()
        }
      }
    }
  }

  @Builder
  body() {

  }
}