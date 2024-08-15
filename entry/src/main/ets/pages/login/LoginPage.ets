import { router } from '@kit.ArkUI';
import { APIs, HttpUtils, JhAESPreferencesUtils, JhColorUtils, JhProgressHUD, kUserDefault_UserInfo, ResType } from 'JhCommon';
import { JhButton } from 'JhCommon/src/main/ets/JhCommon/components/JhButton';

@Entry
@Component
export struct LoginPage {
  @State @Watch('onChange') name: string = 'jin'
  @State @Watch('onChange') pwd: string = ''
  @State disabled: boolean = true

  // onChangeName(propName: string) {}
  // onChangePwd(propName: string) {}

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

        TextInput({
          text: this.name,
          placeholder: '请输入用户名'
        })
          .height(50)
          .margin({ top: 20 })
          .onChange((value) => {
            this.name = value
          })
          .onSubmit((EnterKeyType) => {
            console.info(EnterKeyType + '输入法回车键的类型值')
          })
        TextInput({
          text: this.pwd,
          placeholder: '请输入密码',
        })
          .height(50)
          .type(InputType.Password)
          .margin({ top: 20 })
          .onChange((value) => {
            this.pwd = value
          })
          .onSubmit((EnterKeyType) => {
            console.info(EnterKeyType + '输入法回车键的类型值')
          })
        // Button('登录')
        //   .width('100%')
        //   .margin({ top: 50, bottom: 30 })
        //   .opacity(this.disabled ? 0.6 : 1)
        //   .backgroundColor(KColors.kThemeColor)
        //   .onClick(() => this.clickLogin())
        JhButton({
          text: '登录',
          disabled: this.disabled,
          onPressed: (): void => this.clickLogin()
        })
          .margin({ top: 50, bottom: 30 })
        Row() {
          Text('验证码登录')
            .fontSize(18)
          Text('忘记密码')
            .fontSize(18)
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
      router.replaceUrl({ url: 'pages/BaseTabBar' })
    })
  }
}