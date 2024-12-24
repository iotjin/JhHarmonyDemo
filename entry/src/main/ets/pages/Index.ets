import { BaseTabBar } from './BaseTabBar'
import { JhAESPreferencesUtils, kUserDefault_UserInfo } from 'JhCommon';
import { JhAlert, JhDialog, JhProgressHUD } from 'JhCommon';
import { LoginPage } from './login/pages/LoginPage';

@Entry
@Component
struct Index {
  aboutToAppear() {
    // 初始化Loading和Dialog
    let uiContext: UIContext = this.getUIContext()
    JhDialog.initConfig(uiContext)
    JhProgressHUD.initUIConfig(uiContext)
    JhAlert.initConfig()
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
