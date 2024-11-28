import { BaseNavigation } from 'JhCommon'


@Entry
@Preview
@Component
struct FindPwdPage {
  build() {
    Column() {
      BaseNavigation({ title: '重置密码' })
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