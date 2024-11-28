import { BaseNavigation } from 'JhCommon'


@Entry
@Preview
@Component
struct WxInfoSetPage {
  build() {
    Column() {
      BaseNavigation({ title: '资料设置' })
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