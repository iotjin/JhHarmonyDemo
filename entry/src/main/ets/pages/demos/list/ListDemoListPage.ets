import { router } from '@kit.ArkUI';
import { JhTextList, ItemType } from 'JhCommon';

@Entry
@Component
struct ListDemoListPage {
  dataArr: ItemType[] = [
    { label: 'ListTest1 - 假数据', value: 'pages/demos/list/ListTest1Page' },
    { label: 'ListTest2 - ComposeListItem', value: 'pages/demos/list/ListTest2Page' },
    { label: 'ListTest3 - 自定义cell1', value: 'pages/demos/list/ListTest3Page' },
    { label: 'ListTest4 - 自定义cell2', value: 'pages/demos/list/ListTest4Page' },
    { label: 'ListGroup1 - 分组', value: 'pages/demos/list/ListGroupTest1Page' },
    { label: 'ListGroup2 - 通讯录', value: 'pages/demos/list/ListGroupTest2Page' },
    { label: 'List1', value: 'pages/demos/list/list1/List1Page' },
  ]

  build() {
    Scroll() {
      JhTextList({
        title: 'ListDemoList', dataArr: this.dataArr, callBack: (index, str) => {
          console.log(index.toString() + str)
          router.pushUrl({ url: this.dataArr[index].value })
        }
      })
    }
  }
}
