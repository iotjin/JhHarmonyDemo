import { BaseNavigation } from 'JhCommon'


@Entry
@Preview
@Component
struct WxQQMessagePage {
  build() {
    Column() {
      BaseNavigation({ title: 'QQ邮箱提醒' })
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