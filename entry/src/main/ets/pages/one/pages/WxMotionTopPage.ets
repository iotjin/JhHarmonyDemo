import { BaseNavigation } from 'JhCommon'


@Entry
@Preview
@Component
struct WxMotionTopPage {
  build() {
    Column() {
      BaseNavigation({ title: '排行榜' })
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