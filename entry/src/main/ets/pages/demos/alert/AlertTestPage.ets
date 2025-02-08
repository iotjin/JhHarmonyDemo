import { JhAlert, JhProgressHUD, JhTextList } from 'JhCommon';


@Entry
@Component
struct AlertTestPage {
  dataArr: ESObject[] = [
    { label: '系统Alert' },
    { label: 'Alert标题' },
    { label: 'Alert标题2' },
    { label: 'Alert多按钮' },
    { label: '时间选择器(YMD)' },
    { label: '时间选择器(YMD-HM)' },
    { label: '时间选择器(YMD-HM)-指定时间' },
    { label: '时间选择器(YMD-HM)-农历' },
    { label: '文本选择器' },
  ]

  aboutToAppear() {
    // 初始化 JhAlert
    JhAlert.initConfig()
    console.error('data', JSON.stringify(this))
  }

  build() {
    Scroll() {
      Column() {
        JhTextList({
          title: 'JhAlert示例', dataArr: this.dataArr, callBack: (index, str) => {
            if (str == '系统Alert') {
              JhAlert.showSystemAlert({
                title: '标题',
                message: '这是内容',
                onCancel: () => {
                  console.log(`点击了取消按钮`)
                },
                onConfirm: () => {
                  console.log(`点击了确认按钮`)
                  JhProgressHUD.showText(`点击了确认按钮`)
                },
              })
            }
            if (str == 'Alert标题') {
              JhAlert.showAlert({
                title: '标题',
                message: '这是内容',
                // leftText: '取消',
                // rightText: '确认',
                onCancel: () => {
                  console.log(`点击了取消按钮`)
                },
                onConfirm: () => {
                  console.log(`点击了确认按钮`)
                  JhProgressHUD.showText(`点击了确认按钮`)
                },
              })
            }
            if (str == 'Alert标题2') {
              JhAlert.showDialog({
                title: '标题',
                message: '这是内容',
                // leftText: '取消',
                // rightText: '确认',
                onCancel: () => {
                  console.log(`点击了取消按钮`)
                },
                onConfirm: () => {
                  console.log(`点击了确认按钮`)
                  JhProgressHUD.showText(`点击了确认按钮`)
                },
              })
            }
            if (str == 'Alert多按钮') {
              JhAlert.showMultiButtonsAlert({
                title: '标题',
                message: '内容',
                buttons: [
                  {
                    value: '取消',
                    fontColor: Color.Blue,
                    action: () => {
                      console.log(`点击了取消按钮`)
                    },
                  },
                  {
                    value: '确认一',
                    fontColor: Color.Red,
                    action: () => {
                      console.log(`点击了确认一按钮`)
                    },
                  },
                  {
                    value: '确认二',
                    fontColor: Color.Orange,
                    action: () => {
                      console.log(`点击了确认二按钮`)
                    },
                  },
                ],
              })
            }
            if (str == '时间选择器(YMD)') {
              JhAlert.showDatePicker({
                type: 0,
                onCancel: () => {
                  console.log(`点击了取消按钮`)
                },
                onConfirm: (value) => {
                  console.log(`点击了确认按钮`)
                  console.error(`选择了： ${JSON.stringify(value)}}`)
                  JhProgressHUD.showText(JSON.stringify(value))
                },
              })
            }
            if (str == '时间选择器(YMD-HM)') {
              JhAlert.showDatePicker({
                type: 1,
                showTime: true,
                onCancel: () => {
                  console.log(`点击了取消按钮`)
                },
                onConfirm: (value) => {
                  console.log(`点击了确认按钮`)
                  console.error(`选择了： ${JSON.stringify(value)}}`)
                  JhProgressHUD.showText(JSON.stringify(value))
                },
              })
            }
            if (str == '时间选择器(YMD-HM)-指定时间') {
              JhAlert.showDatePicker({
                selected: new Date('2024-08-08'),
                start: new Date('2024-08-08'),
                end: new Date('2024-08-18'),
                type: 1,
                showTime: true,
                onCancel: () => {
                  console.log(`点击了取消按钮`)
                },
                onConfirm: (value) => {
                  console.log(`点击了确认按钮`)
                  console.error(`选择了： ${JSON.stringify(value)}}`)
                  JhProgressHUD.showText(JSON.stringify(value))
                },
              })
            }
            if (str == '时间选择器(YMD-HM)-农历') {
              JhAlert.showDatePicker({
                type: 1,
                lunar: true,
                lunarSwitch: true,
                onCancel: () => {
                  console.log(`点击了取消按钮`)
                },
                onConfirm: (value) => {
                  console.log(`点击了确认按钮`)
                  console.error(`选择了： ${JSON.stringify(value)}}`)
                  JhProgressHUD.showText(value.toString())
                },
              })
            }
            if (str == '文本选择器') {
              let data: string[] = ["黑龙江省", "哈尔滨市", "道里区", "砂山", "砀山", "高薪区"]
              JhAlert.showTextPicker({
                data: data,
                selected: 2,
                onCancel: () => {
                  console.log(`点击了取消按钮`)
                },
                onConfirm: (item: TextPickerResult) => {
                  console.log(`点击了确认按钮`)
                  console.error(`选择了： ${JSON.stringify(item)}}`)
                  console.error('data', item.value)
                  JhProgressHUD.showText(JSON.stringify(item))
                },
              })
            }

          }
        })

      }

    }
  }
}
