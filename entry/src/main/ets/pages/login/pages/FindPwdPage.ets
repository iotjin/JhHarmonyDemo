///  FindPwdPage.ets
///
///  Created by iotjin on 2024/11/28.
///  description:  重置密码

import { router } from '@kit.ArkUI'
import { BaseNavigation, JhButton, JhLoginTextInput, JhProgressHUD } from 'JhCommon'


@Entry
@Preview
@Component
struct FindPwdPage {
  @State @Watch('onChange') name: string = 'jin'
  @State @Watch('onChange') pwd: string = ''
  @State disabled: boolean = true

  onChange() {
    let isClick = true
    if (this.name.length < 3) {
      isClick = false
    }
    if (this.pwd.length < 6) {
      isClick = false
    }
    this.disabled = !isClick
  }

  build() {
    Column() {
      BaseNavigation({ title: '重置密码' })
      Scroll() {
        Column() {
          this.body()
        }
        .margin(15)
      }
    }
  }

  @Builder
  body() {
    JhLoginTextInput({
      text: this.name,
      labelText: '用户名',
      placeholder: '请输入用户名',
      // leftIcon: $rawfile("svg/ic_login_user.svg"),
      inputCallBack: (value) => {
        this.name = value as string
      },
    })
    Blank().height(8)
    JhLoginTextInput({
      text: this.pwd,
      labelText: '密码',
      placeholder: '请输入密码',
      // leftIcon: $rawfile("svg/ic_login_pwd.svg"),
      isPwd: true,
      inputCallBack: (value) => {
        this.pwd = value as string
      },
    })
    JhButton({
      text: '重 置',
      // disabled: this.disabled,
      onPressed: (): void => this.clickBtn()
    })
      .margin({ top: 50, bottom: 30 })
  }

  clickBtn() {
    JhProgressHUD.showLoadingText('正在重置...')
    setTimeout(() => {
      JhProgressHUD.hide()
      router.back()
    }, 1000)
  }
}