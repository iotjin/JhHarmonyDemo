import { router } from '@kit.ArkUI';
import { JhTextList, ItemType } from 'JhCommon';

@Entry
@Component
struct TestNav {
  dataArr: ItemType[] = [
    { label: 'UI', value: 'pages/demos/ui/UIDemoListPage' },
    { label: '网络请求', value: 'pages/demos/http/HttpDemoListPage' },
    { label: 'AES、MD5和本地加密存储', value: 'pages/demos/other/AESTestPage' },
    { label: '底部、中间、toast、自定义弹框', value: 'pages/demos/alert/AlertDemoListPage' },
    { label: 'JhForm表单', value: 'pages/demos/form/FormDemoListPage' },
  ]

  build() {
    Scroll() {
      JhTextList({
        title: 'DemoList', dataArr: this.dataArr, callBack(index, str) {
          console.log(index.toString() + str)
          router.pushUrl({ url: this.dataArr[index].value })
        }
      })
    }
  }
}
