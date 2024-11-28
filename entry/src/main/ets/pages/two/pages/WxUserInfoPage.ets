import { BaseNavigation } from 'JhCommon'
import { router } from '@kit.ArkUI'


@Entry
@Preview
@Component
struct WxUserInfoPage {
  jumpParams = (router.getParams() as Record<string, string>)['data']

  aboutToAppear() {
    console.log('jumpParams', JSON.stringify(this.jumpParams))
    console.log('用户名称：', JSON.stringify(this.jumpParams['name']))
  }

  build() {
    Column() {
      BaseNavigation({ title: '用户信息' })
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