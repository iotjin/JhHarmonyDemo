import { BaseNavigation } from 'JhCommon'


@Entry
@Preview
@Component
struct WxSubscriptionNumberListPage {
  build() {
    Column() {
      BaseNavigation({ title: '订阅号' })
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