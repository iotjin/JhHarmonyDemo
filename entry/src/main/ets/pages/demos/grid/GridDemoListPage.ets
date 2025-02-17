import { router } from '@kit.ArkUI';
import { JhTextList, ItemType } from 'JhCommon';

@Entry
@Component
struct GridDemoListPage {
  dataArr: ItemType[] = [
    { label: 'GridTest1 - 假数据', value: 'pages/demos/grid/GridTest1Page' },
    { label: 'GridTest2 - 自定义cell', value: 'pages/demos/grid/GridTest2Page' },
    { label: 'GridTest3 - 横向滚动', value: 'pages/demos/grid/GridTest3Page' },
    { label: 'GridTest4 - 九宫格', value: 'pages/demos/grid/GridTest4Page' },
    { label: 'GridGroup1 - 分组', value: 'pages/demos/grid/GridGroupTest1Page' },
  ]

  build() {
    Scroll() {
      JhTextList({
        title: 'GridDemoList', dataArr: this.dataArr, callBack: (index, str) => {
          console.log(index.toString() + str)
          router.pushUrl({ url: this.dataArr[index].value })
        }
      })
    }
  }
}
