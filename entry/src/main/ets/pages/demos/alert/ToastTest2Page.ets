import { JhToast, JhTextList, JhDialog } from 'JhCommon';

@Entry
@Component
struct ToastTest2Page {
  dataArr: ESObject[] = [
    { label: '系统Toast' },
    { label: '文字' },
    { label: '长文字' },
    { label: '长时间Toast' },
    { label: '成功' },
    { label: '失败' },
    { label: '警告' },
    { label: '加载中 - 系统样式' },
    { label: '加载中 - 圆环样式' },
    { label: '下载中 - 圆环进度条' },
  ]
  interval: number | null = null

  aboutToAppear() {
    // 初始化Loading
    let uiContext: UIContext = this.getUIContext()
    JhDialog.initConfig(uiContext)
  }

  build() {
    Scroll() {
      JhTextList({
        title: 'JhProgressHUD2示例', dataArr: this.dataArr, callBack: (index, str) => {
          if (str == '系统Toast') {
            JhToast.showToast('Toast')
          }
          if (str == '文字') {
            JhToast.showText('这是一条提示文字')
          }
          if (str == '长文字') {
            JhToast.showText('这是一条提示文字这是一条提示文字这是一条提示文字这是一条提示文字这是一条提示文字这是一条提示文字这是一条提示文字这是一条提示文字这是一条提示文字')
          }
          if (str == '长时间Toast') {
            JhToast.showTextLong('这是一条提示文字')
          }
          if (str == '成功') {
            JhToast.showSuccess('加载成功')
          }
          if (str == '失败') {
            JhToast.showError('加载失败')
          }
          if (str == '警告') {
            JhToast.showInfo('注意注意')
          }
          if (str == '加载中 - 系统样式') {
            JhToast.showLoadingText()
            setTimeout(() => {
              JhToast.hide()
            }, 5000)
          }
          if (str == '加载中 - 圆环样式') {
            JhToast.showRingLoadingText()
            setTimeout(() => {
              JhToast.hide()
            }, 5000)
          }

          if (str == '下载中 - 圆环进度条') {
            let progress = 0
            this.interval = setInterval(() => {
              progress++
              JhToast.showProgressLoadingText(progress, '下载中...')
              if (progress >= 100) {
                JhToast.hide()
                clearInterval(this.interval)
              }
            }, 50)
          }
        }
      })
    }
  }
}
