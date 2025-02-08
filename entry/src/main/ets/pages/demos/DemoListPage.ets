import { router } from '@kit.ArkUI';
import { JhTextList, ItemType } from 'JhCommon';

@Entry
@Component
struct DemoListPage {
  dataArr: ItemType[] = [
    { label: 'UI', value: 'pages/demos/ui/UIDemoListPage' },
    { label: 'List组件', value: 'pages/demos/list/ListDemoListPage' },
    { label: 'Grid组件', value: 'pages/demos/grid/GridDemoListPage' },
    { label: '网络请求', value: 'pages/demos/http/HttpDemoListPage' },
    { label: 'AES、MD5和本地加密存储', value: 'pages/demos/other/AESTestPage' },
    { label: '底部、中间、toast、自定义弹框', value: 'pages/demos/alert/AlertDemoListPage' },
    { label: 'JhForm表单', value: 'pages/demos/form/FormDemoListPage' },
    { label: '城市选择列表', value: 'pages/demos/other/citySelect/CitySelectListPage' },
  ]

  build() {
    Scroll() {
      JhTextList({
        title: 'DemoList', dataArr: this.dataArr, callBack: (index, str) => {
          console.log(index.toString() + str)
          router.pushUrl({ url: this.dataArr[index].value })
        }
      })
    }
  }
}
