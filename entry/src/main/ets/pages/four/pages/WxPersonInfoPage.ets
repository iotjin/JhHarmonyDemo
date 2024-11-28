import { BaseNavigation } from 'JhCommon'


@Entry
@Preview
@Component
struct WxPersonInfoPage {
  build() {
    Column() {
      BaseNavigation({ title: $r('app.string.wxPersonInfo') })
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