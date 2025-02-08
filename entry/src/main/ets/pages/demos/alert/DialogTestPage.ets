import { AnimationHelper } from '@pura/harmony-dialog';
import { JhCustomOptions, JhDialog, JhProgressHUD, JhTextList } from 'JhCommon';


@Entry
@Component
struct DialogTestPage {
  dataArr: ESObject[] = [
    { label: 'JhDialog-标题' },
    { label: 'JhDialog-标题内容' },
    { label: 'JhDialog-内容' },
    { label: 'JhDialog-标题内容只有确定' },
    { label: 'JhDialog-修改按钮文字' },
    { label: 'JhDialog-点击按钮弹框不消失' },
    { label: 'JhDialog-拦截取消按钮点击事件' },
    { label: 'JhDialog-录入框' },
    { label: 'JhDialog-录入框(数字类型，正整数，最大三位)' },
    { label: 'JhDialog-多行录入框' },
    { label: 'JhDialog-自定义内容' },
    { label: 'JhDialog-自定义内容2' },
    { label: 'JhDialog-自定义内容3-文字' },
    { label: 'JhDialog-底部完全自定义' },
    { label: 'JhDialog-完全自定义-顶部弹出' },
    { label: 'JhDialog-完全自定义-左侧弹出' },
  ]

  aboutToAppear() {
    // 初始化 JhDialog
    let uiContext: UIContext = this.getUIContext()
    JhDialog.initConfig(uiContext)
    console.error('data', JSON.stringify(this))
  }

  build() {
    Scroll() {
      Column() {
        JhTextList({
          title: 'JhDialog示例', dataArr: this.dataArr, callBack: (index, str) => {
            if (str == 'JhDialog-标题') {
              JhDialog.show({
                title: '提示',
                // leftText: '取消',
                // rightText: '确认',
                onCancel: () => {
                  console.log(`点击了取消按钮`)
                },
                onConfirm: () => {
                  console.log(`点击了确认按钮`)
                  JhProgressHUD.showText(`点击了确认按钮`)
                },
              });
            }
            if (str == 'JhDialog-标题内容') {
              JhDialog.show({
                title: '提示',
                message: '您确定要退出登录吗',
                onCancel: () => {
                  console.log(`点击了取消按钮`)
                },
                onConfirm: () => {
                  console.log(`点击了确认按钮`)
                  JhProgressHUD.showText(`点击了确认按钮`)
                },
              });
            }
            if (str === 'JhDialog-内容') {
              JhDialog.show({
                title: '',
                message: '您确定要退出登录吗？',
                onCancel: () => {
                  console.log(`点击了取消按钮`)
                },
                onConfirm: () => {
                  console.log(`点击了确认按钮`)
                  JhProgressHUD.showText(`点击了确认按钮`)
                },
              });
            }
            if (str === 'JhDialog-标题内容只有确定') {
              JhDialog.show({
                title: '警告',
                message: '您的账号在异地登录，请重新登录！',
                hiddenCancel: true,
                rightText: '好的',
                onConfirm: () => {
                  console.log(`点击了确认按钮`)
                  JhProgressHUD.showText(`点击了确认按钮`)
                },
              });
            }
            if (str == 'JhDialog-修改按钮文字') {
              JhDialog.show({
                title: '提示',
                message: '您需要同意相关协议才能使用！',
                leftText: '不同意',
                rightText: '同意',
                onCancel: () => {
                  console.log(`点击了取消按钮`)
                },
                onConfirm: () => {
                  console.log(`点击了确认按钮`)
                  JhProgressHUD.showText(`点击了确认按钮`)
                },
              });
            }
            if (str == 'JhDialog-点击按钮弹框不消失') {
              JhDialog.show({
                title: '提示',
                message: '点击取消按钮弹框消失，点击确认按钮延时3秒后弹框消失',
                clickBtnClose: false,
                onCancel: (action, dialogId, content) => {
                  console.log(`点击了取消按钮`)
                  JhDialog.hide(dialogId)
                },
                onConfirm: (action, dialogId, content) => {
                  console.log(`点击了确认按钮`)
                  setTimeout(() => {
                    JhDialog.hide(dialogId)
                  }, 3000)
                },
              });
            }
            if (str == 'JhDialog-拦截取消按钮点击事件') {
              JhDialog.show({
                title: '提示',
                message: '点击取消按钮弹框不消失，点击确认按钮弹框消失',
                clickBtnClose: false,
                onCancel: (action, dialogId, content) => {
                  console.log(`点击了取消按钮`)
                  JhProgressHUD.showText(`点击了取消按钮`)
                },
                onConfirm: (action, dialogId, content) => {
                  console.log(`点击了确认按钮`)
                  JhDialog.hide(dialogId)
                  JhProgressHUD.showText(`点击了确认按钮`)
                },
              });
            }
            if (str == 'JhDialog-录入框') {
              JhDialog.showInputDialog({
                title: '提示',
                onCancel: (action, dialogId, content) => {
                  console.log(`点击了取消按钮`)
                  JhProgressHUD.showText(`点击了取消按钮`)
                },
                onConfirm: (action, dialogId, content) => {
                  console.log(`点击了确认按钮, 此时录入的文字为: ${content}}`)
                  JhDialog.hide(dialogId)
                  JhProgressHUD.showText(`点击了确认按钮`)
                },
              });
            }
            if (str == 'JhDialog-录入框(数字类型，正整数，最大三位)') {
              JhDialog.showInputDialog({
                title: '提示',
                placeholder: "请输入年龄",
                inputType: InputType.Number,
                maxLength: 3,
                inputFilter: {
                  value: "[0-9]",
                  error: (value) => {
                    console.error("inputFilter: " + value);
                  }
                },
                onCancel: (action, dialogId, content) => {
                  console.log(`点击了取消按钮`)
                  JhProgressHUD.showText(`点击了取消按钮`)
                },
                onConfirm: (action, dialogId, content) => {
                  console.log(`点击了确认按钮, 此时录入的文字为: ${content}}`)
                  JhDialog.hide(dialogId)
                  JhProgressHUD.showText(`点击了确认按钮`)
                },
              });
            }
            if (str == 'JhDialog-多行录入框') {
              JhDialog.showTextAreaDialog({
                title: '提示',
                onCancel: (action, dialogId, content) => {
                  console.log(`点击了取消按钮`)
                  JhProgressHUD.showText(`点击了取消按钮`)
                },
                onConfirm: (action, dialogId, content) => {
                  console.log(`点击了确认按钮, 此时录入的文字为: ${content}}`)
                  JhDialog.hide(dialogId)
                  JhProgressHUD.showText(`点击了确认按钮`)
                },
              });
            }

            if (str == "JhDialog-自定义内容") {
              JhDialog.showCustomDialog({
                title: '',
                contentAreaPadding: {
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0
                },
                contentBuilder: () => {
                  this.customBuilder()
                },
                onCancel: () => {
                  console.log(`点击了取消按钮`)
                },
                onConfirm: () => {
                  console.log(`点击了确认按钮`)
                  JhProgressHUD.showText(`点击了确认按钮`)
                },
              });
            }
            if (str == "JhDialog-自定义内容2") {
              JhDialog.showCustomDialog({
                title: '提示',
                contentAreaPadding: {
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0
                },
                contentBuilder: () => {
                  this.customBuilder()
                },
                onCancel: () => {
                  console.log(`点击了取消按钮`)
                },
                onConfirm: () => {
                  console.log(`点击了确认按钮`)
                  JhProgressHUD.showText(`点击了确认按钮`)
                },
              });
            }
            if (str == "JhDialog-自定义内容3-文字") {
              JhDialog.showCustomDialog({
                title: '提示',
                contentBuilder: () => {
                  this.customTextBuilder("我是一个自定义弹框！")
                },
                onCancel: () => {
                  console.log(`点击了取消按钮`)
                },
                onConfirm: () => {
                  console.log(`点击了确认按钮`)
                  JhProgressHUD.showText(`点击了确认按钮`)
                },
              });
            }

            if (str == "JhDialog-底部完全自定义") {
              let custom: JhCustomOptions = {
                height: 360,
                alignment: DialogAlignment.Bottom,
                offset: { dx: 0, dy: 0 },
                transition: AnimationHelper.transitionInDown(0),
                autoCancel: true, // 点击遮障层时，是否关闭弹窗，true表示关闭弹窗。
                backCancel: false, // 点击返回键或手势返回时，是否关闭弹窗；实现onWillDismiss函数时，该参数不起作用。
              };
              JhDialog.showBottomAllCustomDialog(wrapBuilder(AllCustomBuilder))
              // JhDialog.showBottomAllCustomDialog(wrapBuilder(AllCustomBuilder), custom)
            }
            if (str == "JhDialog-完全自定义-顶部弹出") {
              let custom: JhCustomOptions = {
                height: 360,
                alignment: DialogAlignment.Top,
                offset: { dx: 0, dy: 0 },
                transition: AnimationHelper.transitionInDown(0),
                autoCancel: true, // 点击遮障层时，是否关闭弹窗，true表示关闭弹窗。
                backCancel: false, // 点击返回键或手势返回时，是否关闭弹窗；实现onWillDismiss函数时，该参数不起作用。
              };
              JhDialog.showAllCustomDialog(wrapBuilder(AllCustomBuilder), custom)
            }
            if (str == "JhDialog-完全自定义-左侧弹出") {
              let custom: JhCustomOptions = {
                width: 260,
                height: '100%',
                alignment: DialogAlignment.CenterStart,
                offset: { dx: 0, dy: 0 },
                transition: AnimationHelper.transitionInLeft(200),
                autoCancel: true, // 点击遮障层时，是否关闭弹窗，true表示关闭弹窗。
                backCancel: false, // 点击返回键或手势返回时，是否关闭弹窗；实现onWillDismiss函数时，该参数不起作用。
              };
              JhDialog.showAllCustomDialog(wrapBuilder(AllCustomBuilder), custom)
            }
          }
        })
      }
    }
  }

  //自定义文本
  @Builder
  customTextBuilder(content: string) {
    Text(content)
      .fontColor(Color.Black)
      .fontSize(16)
      .padding(10)
  }

  @Builder
  customBuilder() {
    Column() {
    }
    .width('100%')
    .height(200)
    .backgroundColor(Color.Red)
  }
}

@Builder
function AllCustomBuilder(options: JhCustomOptions) {
  Column() {
    Text('这是一个完全自定义弹框')
      .fontColor(Color.Blue)
      .fontWeight(FontWeight.Bold)
      .fontSize(16)
      .padding(20)
    Button('关闭，自定义弹框')
      .onClick(() => {
        JhDialog.hide(options.dialogId ?? ""); //关闭弹框
      })
  }
  .width(options.width ?? '100%')
  .height(options.height)
  .backgroundColor(Color.Yellow)
}