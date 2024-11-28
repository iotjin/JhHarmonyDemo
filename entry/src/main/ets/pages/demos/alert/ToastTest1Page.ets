import { JhProgressHUD, JhTextList } from 'JhCommon';

@Entry
@Component
struct ToastTest1Page {
  dataArr: ESObject[] = [
    { label: '系统Toast' },
    { label: '文字' },
    { label: '长文字' },
    { label: '成功' },
    { label: '失败' },
    { label: '警告' },
    { label: '加载中 - 系统样式' },
    { label: '加载中 - 圆环样式' },
    { label: '下载中 - 圆环进度条' },
    { label: '下载中 - 水平进度条' },
  ]
  interval: number | null = null

  aboutToAppear() {
    // 初始化Loading
    let uiContext: UIContext = this.getUIContext()
    JhProgressHUD.initUIConfig(uiContext)
  }

  build() {
    Scroll() {
      JhTextList({
        title: 'JhProgressHUD示例', dataArr: this.dataArr, callBack: (index, str) => {
          if (str == '系统Toast') {
            JhProgressHUD.showToast('Toast')
          }
          if (str == '文字') {
            JhProgressHUD.showText('这是一条提示文字')
          }
          if (str == '长文字') {
            JhProgressHUD.showText('这是一条提示文字这是一条提示文字这是一条提示文字这是一条提示文字这是一条提示文字这是一条提示文字这是一条提示文字这是一条提示文字这是一条提示文字')
          }
          if (str == '成功') {
            JhProgressHUD.showSuccess('加载成功')
          }
          if (str == '失败') {
            JhProgressHUD.showError('加载失败')
          }
          if (str == '警告') {
            JhProgressHUD.showInfo('注意注意')
          }
          if (str == '加载中 - 系统样式') {
            JhProgressHUD.showLoadingText()
            setTimeout(() => {
              JhProgressHUD.hide()
            }, 5000)
          }
          if (str == '加载中 - 圆环样式') {
            JhProgressHUD.showRingLoadingText()
            setTimeout(() => {
              JhProgressHUD.hide()
            }, 5000)
          }

          if (str == '下载中 - 圆环进度条') {
            let progress = 0
            this.interval = setInterval(() => {
              progress++
              JhProgressHUD.showProgressLoadingText(progress, '下载中...')
              if (progress >= 100) {
                clearInterval(this.interval)
              }
            }, 50)
          }

          if (str == '下载中 - 水平进度条') {
            let progress = 0
            this.interval = setInterval(() => {
              progress++
              JhProgressHUD.showBarProgressLoadingText(progress, '下载中...')
              if (progress >= 100) {
                clearInterval(this.interval)
              }
            }, 50)
          }
        }
      })
    }
  }
}
