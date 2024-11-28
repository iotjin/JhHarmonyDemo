import { BaseNavigation } from 'JhCommon'


@Entry
@Preview
@Component
struct WxNewFriendPage {
  build() {
    Column() {
      BaseNavigation({ title: '新的朋友' })
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