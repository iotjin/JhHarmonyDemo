import { router } from '@kit.ArkUI';
import { JhTextList, ItemType } from 'JhCommon';

@Entry
@Component
struct HttpDemoListPage {
  dataArr: ItemType[] = [
    { label: 'axios示例', value: 'pages/demos/http/HttpTest1Page' },
    { label: 'axios封装', value: 'pages/demos/http/HttpTest2Page' },
  ]

  build() {
    Scroll() {
      JhTextList({
        title: 'HttpDemoList', dataArr: this.dataArr, callBack: (index, str) => {
          console.log(index.toString() + str)
          router.pushUrl({ url: this.dataArr[index].value })
        }
      })
    }
  }
}
