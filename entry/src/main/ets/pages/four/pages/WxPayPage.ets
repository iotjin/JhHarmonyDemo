import { BaseNavigation } from 'JhCommon'


@Entry
@Preview
@Component
struct WxPayPage {
  build() {
    Column() {
      BaseNavigation({ title: $r('app.string.wxPay') })
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