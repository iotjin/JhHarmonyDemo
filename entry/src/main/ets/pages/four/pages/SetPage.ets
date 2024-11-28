import { JhTextList, ItemType, JhProgressHUD, JhAESPreferencesUtils, kUserDefault_UserInfo } from 'JhCommon'
import { router } from '@kit.ArkUI'


@Entry
@Preview
@Component
export struct SetPage {
  dataArr: ItemType[] = [
    { label: '主题设置' },
    { label: '多语言' },
    { label: '关于' },
    { label: '退出登录' },
  ]

  build() {
    Scroll() {
      JhTextList({
        title: '设置',
        dataArr: this.dataArr,
        callBack: (index, str) => {
          console.log(index.toString() + str)
          if (str == '退出登录') {
            this.exitLogin()
          }
        }
      })
    }
  }

  exitLogin() {
    JhProgressHUD.showLoadingText('正在退出...')
    setTimeout(() => {
      JhAESPreferencesUtils.delete(kUserDefault_UserInfo)
      // router.replaceUrl({ url: 'pages/login/pages/LoginPage' })
      router.replaceUrl({ url: 'pages/Index' })
      JhProgressHUD.hide()
    }, 1000)
  }
}