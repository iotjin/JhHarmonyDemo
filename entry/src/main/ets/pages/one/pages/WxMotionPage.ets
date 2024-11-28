import { BaseNavigation } from 'JhCommon'


@Entry
@Preview
@Component
struct WxMotionPage {
  build() {
    Column() {
      BaseNavigation({ title: '微信运动' })
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