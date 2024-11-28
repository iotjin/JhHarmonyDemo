import { router } from '@kit.ArkUI';
import { JhTextList, ItemType } from 'JhCommon';

@Entry
@Component
struct UIDemoListPage {
  dataArr: ItemType[] = [
    { label: 'TabBar', value: 'pages/demos/ui/TestTabBar' },
    { label: 'Navigation', value: 'pages/demos/ui/TestNav' },
  ]

  build() {
    Scroll() {
      JhTextList({
        title: 'UI', dataArr: this.dataArr, callBack: (index, str) => {
          console.log(index.toString() + str)
          router.pushUrl({ url: this.dataArr[index].value })
        }
      })
    }
  }
}
