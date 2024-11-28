import { BaseNavigation } from 'JhCommon'


@Entry
@Preview
@Component
struct WxFriendsCirclePage {
  build() {
    Column() {
      BaseNavigation({ title: '朋友圈' })
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