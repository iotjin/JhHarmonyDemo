import { BaseNavigation } from 'JhCommon'


@Entry
@Preview
@Component
struct WxPayManagerPage {
  build() {
    Column() {
      BaseNavigation({ title: $r('app.string.wxPayManager') })
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