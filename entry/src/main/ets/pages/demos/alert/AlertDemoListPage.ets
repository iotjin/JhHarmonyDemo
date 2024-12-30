import { router } from '@kit.ArkUI';
import { JhTextList, ItemType } from 'JhCommon';

@Entry
@Component
struct AlertDemoListPage {
  dataArr: ItemType[] = [
    { label: 'JhProgressHUD示例', value: 'pages/demos/alert/ToastTest1Page' },
    { label: 'JhToast示例', value: 'pages/demos/alert/ToastTest2Page' },
    { label: 'JhAlert示例', value: 'pages/demos/alert/AlertTestPage' },
    { label: 'JhDialog示例', value: 'pages/demos/alert/DialogTestPage' },
    { label: '底部弹框示例', value: 'pages/demos/alert/PickerTestPage' },
  ]

  build() {
    Scroll() {
      JhTextList({
        title: 'AlertDemoList', dataArr: this.dataArr, callBack: (index, str) => {
          console.log(index.toString() + str)
          router.pushUrl({ url: this.dataArr[index].value })
        }
      })
    }
  }
}
