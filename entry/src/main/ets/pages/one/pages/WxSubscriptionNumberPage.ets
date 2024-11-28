import { BaseNavigation } from 'JhCommon'


@Entry
@Preview
@Component
struct WxSubscriptionNumberPage {
  build() {
    Column() {
      BaseNavigation({ title: '订阅号消息' })
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