import { BaseNavigation, JhAESPreferencesUtils, JhProgressHUD, kUserDefault_UserInfo } from 'JhCommon';
import { router } from '@kit.ArkUI';

@Entry
@Component
export struct FourPage {
  @State message: string = 'Four'

  aboutToAppear() {
    let useInfo = JhAESPreferencesUtils.getModel(kUserDefault_UserInfo)
    console.log('useInfo: ', JSON.stringify(useInfo))
  }

  build() {
    Column() {
      BaseNavigation({ title: "Four", leftItem: {} })
      Button('退出登录').onClick((event: ClickEvent) => {
        this.exitLogin()
      })

      RelativeContainer() {
        Text(this.message)
          .id('FourPage')
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .alignRules({
            center: { anchor: '__container__', align: VerticalAlign.Center },
            middle: { anchor: '__container__', align: HorizontalAlign.Center }
          })
      }
      .height('100%')
      .width('100%')
    }
  }

  exitLogin() {
    JhProgressHUD.showLoadingText('正在退出...')
    setTimeout(() => {
      JhAESPreferencesUtils.delete(kUserDefault_UserInfo)
      router.replaceUrl({ url: 'pages/login/LoginPage' })
      JhProgressHUD.hide()
    }, 1000)
  }
}