///  FindPwdPage.ets
///
///  Created by iotjin on 2024/11/28.
///  description:  验证码登录


import { router } from '@kit.ArkUI'
import { APIs, HttpUtils, ResType } from 'JhCommon';
import { BaseNavigation, JhLoginTextInput, JhProgressHUD, JhButton, JhCountDownBtn } from 'JhCommon';
import { JhAESPreferencesUtils, kUserDefault_UserInfo } from 'JhCommon';


@Entry
@Preview
@Component
struct CodeLoginPage {
  @State @Watch('onChange') phone: string = ''
  @State @Watch('onChange') code: string = ''
  @State disabled: boolean = true

  onChange() {
    let isClick = true
    if (this.phone.length < 11) {
      isClick = false
    }
    if (this.code.length < 4) {
      isClick = false
    }
    this.disabled = !isClick
  }

  build() {
    Column() {
      BaseNavigation({ title: '', bgColor: Color.Transparent })
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
    Text('验证码登录').fontSize(26).fontWeight(FontWeight.Bold)
    Blank().height(80)
    JhLoginTextInput({
      text: this.phone,
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
    JhButton({
      text: '登 录',
      // disabled: this.disabled,
      onPressed: (): void => this.clickLogin()
    })
      .margin({ top: 50, bottom: 30 })
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

  clickLogin() {
    const params: object = Object({ 'userName': 'jin', 'pwd': '123456' })
    HttpUtils.post(APIs.login, params, '正在登录...').then((res: ResType) => {
      console.log('登录返回数据：', JSON.stringify(res))
      JhProgressHUD.showSuccess(res.msg)
      JhAESPreferencesUtils.saveModel(kUserDefault_UserInfo, res.data)
      // router.replaceUrl({ url: 'pages/BaseTabBar' })
      router.replaceUrl({ url: 'pages/Index' })
    })
  }
}