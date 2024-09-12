import { router } from '@kit.ArkUI';
import { JhTextList, ItemType } from 'JhCommon';

@Entry
@Component
struct AlertDemoListPage {
  dataArr: ItemType[] = [
    { label: 'JhProgressHUD示例', value: 'pages/demos/alert/ToastTest1Page' },
    { label: 'JhAlert示例', value: 'pages/demos/alert/AlertTestPage' },
  ]

  build() {
    Scroll() {
      JhTextList({
        title: 'AlertDemoList', dataArr: this.dataArr, callBack(index, str) {
          console.log(index.toString() + str)
          router.pushUrl({ url: this.dataArr[index].value })
        }
      })
    }
  }
}
