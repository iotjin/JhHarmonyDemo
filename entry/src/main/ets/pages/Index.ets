import { BaseTabBar } from './BaseTabBar'
import { JhAESPreferencesUtils, JhProgressHUD, kUserDefault_UserInfo } from 'JhCommon';
import { LoginPage } from './login/LoginPage';

@Entry
@Component
struct Index {
  aboutToAppear() {
    // 初始化Loading
    let uiContext: UIContext = this.getUIContext()
    JhProgressHUD.initUIConfig(uiContext)
  }

  build() {
    Column() {
      if (this.switchRootPage() == 'BaseTabBar') {
        BaseTabBar()
      } else {
        LoginPage()
      }
    }
    .backgroundColor("#eeeeee")
    .width('100%')
    .height('100%')
  }

  switchRootPage(): 'BaseTabBar' | 'LoginPage' {
    const userInfo = JhAESPreferencesUtils.getModel(kUserDefault_UserInfo)
    if (userInfo) {
      console.log('本地取出的 userInfo', JSON.stringify(userInfo))
      return 'BaseTabBar'
    } else {
      return 'LoginPage'
    }
  }
}
