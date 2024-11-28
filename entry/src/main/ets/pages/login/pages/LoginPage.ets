import { router } from '@kit.ArkUI';
import { APIs, HttpUtils, JhAESPreferencesUtils, JhColorUtils, JhProgressHUD, kUserDefault_UserInfo, ResType } from 'JhCommon';
import { JhLoginTextInput } from 'JhCommon';
import { JhButton } from 'JhCommon/src/main/ets/JhCommon/components/JhButton';

@Entry
@Component
export struct LoginPage {
  @State @Watch('onChange') name: string = 'jin'
  @State @Watch('onChange') pwd: string = ''
  @State disabled: boolean = true

  // onChangeName(propName: string) {}
  // onChangePwd(propName: string) {}

  aboutToAppear() {
    console.log('LoginPage aboutToAppear')
  }

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
    Scroll() {
      Column() {
        Row() {
          Text('注册')
            .fontSize(18)
            .onClick(() => {
              this.clickBtn('注册')
            })
        }
        .justifyContent(FlexAlign.End)
        .width('100%')

        Row() {
          Text('Logo')
            .fontSize(20)
            .fontColor(Color.White)
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .width(100)
        .height(100)
        .margin({ top: 80, bottom: 30 })
        .backgroundColor(JhColorUtils.randomColor())
        .borderRadius(50)

        JhLoginTextInput({
          text: this.name,
          // labelText: '用户名',
          placeholder: '请输入用户名',
          leftIcon: $rawfile("svg/ic_login_user.svg"),
          inputCallBack: (value) => {
            this.name = value as string
          },
        })
        Blank().height(8)
        JhLoginTextInput({
          text: this.pwd,
          // labelText: '密码',
          placeholder: '请输入密码',
          leftIcon: $rawfile("svg/ic_login_pwd.svg"),
          isPwd: true,
          inputCallBack: (value) => {
            this.pwd = value as string
          },
        })
        JhButton({
          text: '登录',
          disabled: this.disabled,
          onPressed: (): void => this.clickLogin()
        })
          .margin({ top: 50, bottom: 30 })

        Row() {
          Text('验证码登录')
            .fontSize(18)
            .onClick(() => {
              this.clickBtn('验证码登录')
            })
          Text('忘记密码')
            .fontSize(18)
            .onClick(() => {
              this.clickBtn('忘记密码')
            })
        }
        .justifyContent(FlexAlign.SpaceBetween)
        .width('100%')
      }
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Start)
      .height('100%')
      .width('100%')
      .padding(15)
    }
  }

  clickLogin() {
    const params: object = Object({ 'userName': this.name, 'pwd': this.pwd })
    HttpUtils.post(APIs.login, params, '正在登录...').then((res: ResType) => {
      console.log('登录返回数据：', JSON.stringify(res))
      JhProgressHUD.showSuccess(res.msg)
      JhAESPreferencesUtils.saveModel(kUserDefault_UserInfo, res.data)
      // router.replaceUrl({ url: 'pages/BaseTabBar' })
      router.replaceUrl({ url: 'pages/Index' })
    })
  }

  clickBtn(text: string) {
    if (text == '注册') {
      router.pushUrl({ url: 'pages/login/pages/RegisterPage' })
    }
    if (text == '验证码登录') {
      router.pushUrl({ url: 'pages/login/pages/CodeLoginPage' })
    }
    if (text == '忘记密码') {
      router.pushUrl({ url: 'pages/login/pages/FindPwdPage' })
    }
  }
}