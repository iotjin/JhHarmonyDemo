import { BaseNavigation } from 'JhCommon'


@Entry
@Preview
@Component
struct WxAddFriendPage {
  build() {
    Column() {
      BaseNavigation({ title: '添加朋友' })
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