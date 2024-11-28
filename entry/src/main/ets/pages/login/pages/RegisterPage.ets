import { BaseNavigation } from 'JhCommon'


@Entry
@Preview
@Component
struct RegisterPage {
  build() {
    Column() {
      BaseNavigation({ title: '账号注册' })
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