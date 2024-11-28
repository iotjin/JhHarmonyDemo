import { BaseNavigation } from 'JhCommon'


@Entry
@Preview
@Component
struct CodeLoginPage {
  build() {
    Column() {
      BaseNavigation({ title: '验证码登录' })
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