///  FindPwdPage.ets
///
///  Created by iotjin on 2024/11/28.
///  description:  注册


import { router } from '@kit.ArkUI'
import { APIs, HttpUtils, ResType } from 'JhCommon';
import { BaseNavigation, JhLoginTextInput, JhProgressHUD, JhButton, JhCountDownBtn } from 'JhCommon';
import { JhAESPreferencesUtils, kUserDefault_UserInfo } from 'JhCommon';


@Entry
@Preview
@Component
struct RegisterPage {
  @State @Watch('onChange') phone: string = ''
  @State @Watch('onChange') code: string = ''
  @State @Watch('onChange') pwd: string = ''
  @State disabled: boolean = true

  onChange() {
    let isClick = true
    if (this.phone.length < 11) {
      isClick = false
    }
    if (this.code.length < 4) {
      isClick = false
    }
    if (this.code.length < 6) {
      isClick = false
    }
    this.disabled = !isClick
  }

  build() {
    Column() {
      BaseNavigation({ title: '账号注册' })
      Scroll() {
        Column() {
          this.body()
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)
        .margin(15)
      }
    }
  }

  @Builder
  body() {
    JhLoginTextInput({
      text: this.phone,
      labelText: '手机号',
      placeholder: '请输入手机号',
      maxLength: 11,
      inputType: InputType.Number,
      inputCallBack: (value) => {
        this.phone = value as string
      },
    })
    Blank().height(8)
    JhLoginTextInput({
      text: this.code,
      labelText: '验证码',
      placeholder: '请输入验证码',
      maxLength: 6,
      inputType: InputType.Number,
      rightWidget: () => {
        this.rightBuilder()
      },
      inputCallBack: (value) => {
        this.code = value as string
      },
    })
    Blank().height(8)
    JhLoginTextInput({
      text: this.pwd,
      labelText: '密码',
      placeholder: '请输入密码',
      isPwd: true,
      inputCallBack: (value) => {
        this.pwd = value as string
      },
    })
    JhButton({
      text: '注 册',
      // disabled: this.disabled,
      onPressed: (): void => this.clickBtn()
    })
      .margin({ top: 50, bottom: 20 })

    Text() {
      Span('注册即视为同意').fontSize(12).fontColor(Color.Grey)
      Span('《xxx服务协议》').fontColor(Color.Red).fontSize(12)
        .fontStyle(FontStyle.Italic)
    }
    .width('100%')
    .textAlign(TextAlign.Center)
    .onClick(() => this.clickAgreement())

  }

  @Builder
  rightBuilder() {
    JhCountDownBtn({
      getCodeText: '获取验证码',
      resendAfterText: '重新获取',
      showBorder: true,
      getVCode: (): Promise<boolean> => {
        return Promise.resolve(true)
        // return this.getCode()
        return this.getCode2()
      }
    })
  }

  async getCode() {
    const result = await this.getCode2()
    return result
    // return true
  }

  async getCode2(): Promise<boolean> {
    return new Promise((resolve, reject) => {
      // 模拟异步操作（例如网络请求，验证码发送等）
      setTimeout(() => {
        const isSuccess = Math.random() > 0.5 // 模拟成功与失败
        if (isSuccess) {
          resolve(true) // 模拟验证码发送成功
        } else {
          reject(false) // 模拟验证码发送失败
        }
      }, 1000)
    })
  }

  clickBtn() {
    JhProgressHUD.showLoadingText('正在注册...')
    setTimeout(() => {
      JhProgressHUD.hide()
      router.back()
    }, 1000)
  }

  clickAgreement() {
    JhProgressHUD.showText('点击服务协议')
  }
}