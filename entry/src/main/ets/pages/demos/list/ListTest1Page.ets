import { BaseNavigation } from 'JhCommon'


@Entry
@Preview
@Component
struct ListTest1Page {
  @State dataArr: ESObject[] = []

  aboutToAppear() {
    this.dataArr = this.getData()
    console.error('data', JSON.stringify(this.dataArr))
  }

  getData() {
    let dataArr: ESObject[] = [];
    for (let i = 0; i < 35; i++) {
      let map: Record<string, ESObject> = {};
      map['title'] = `title${i}`;
      map['content'] = `content${i}-content${i}-content${i}-content${i}`;
      map['phone'] = `${i}${i}${i} xxxxxxx`;
      map['imageUrl'] = 'https://gitee.com/iotjh/Picture/raw/master/lufei.png';
      dataArr.push(map);
    }
    return dataArr;
  }

  build() {
    Column() {
      BaseNavigation({ title: 'ListTest1 - 假数据' })
      Scroll() {
        Column() {
          this.header('header')
          this.body()
          this.header('footer')
        }
        .backgroundColor(Color.Yellow)
      }
      .layoutWeight(1)
    }
  }

  @Builder
  header(text: string) {
    Row() {
      Text(text).fontColor(Color.White)
    }
    .width('100%')
    .height(50)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(Color.Orange)
  }

  @Builder
  body() {
    List() {
      ListItem() {
        Text('Text: -1')
          .fontSize(20)
          .height(50)
          .backgroundColor("#aabbcc")
          .width('100%')
      }

      ForEach(this.dataArr, (item: ESObject, index: number) => {
        ListItem() {
          this.cell(item)
        }
      })
    }
    .layoutWeight(1)
    .divider({
      strokeWidth: 1,
      // startMargin: 20,
      // endMargin: 20,
      color: Color.Gray,
    })
    // 设置成水平方向
    // .listDirection(Axis.Horizontal)
    // 滑动事件
    .onScrollIndex((firstIndex: number, lastIndex: number) => {
      console.info('滑动起始位置索引值' + firstIndex)
      console.info('滑动结束位置索引值' + lastIndex)
    })
    .onDidScroll((scrollOffset: number, scrollState: ScrollState) => {
      console.info('滑动偏移量' + scrollOffset)
      console.info('当前滑动状态' + scrollState)
    })
    .onReachStart(() => {
      console.info('列表起始位置到达')
    })
    .onReachEnd(() => {
      console.info('列表末尾位置到达')
    })
    .onScrollStop(() => {
      console.info('列表滑动停止')
    })

    // nestedScroll 设置向前向后两个方向上的嵌套滚动模式，实现与父组件的滚动联动
    //
    // .nestedScroll({
    //   scrollForward: NestedScrollMode.PARENT_FIRST, // 滚动组件往末尾端滚动时的嵌套滚动选项。
    //   scrollBackward: NestedScrollMode.SELF_FIRST // 滚动组件往起始端滚动时的嵌套滚动选项。
    // })
    // NestedScrollMode
    // https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-appendix-enums-V5#nestedscrollmode10枚举说明
    //
    // SELF_ONLY	只自身滚动，不与父组件联动。
    // SELF_FIRST	自身先滚动，自身滚动到边缘以后父组件滚动。父组件滚动到边缘以后，如果父组件有边缘效果，则父组件触发边缘效果，否则子组件触发边缘效果。
    // PARENT_FIRST	父组件先滚动，父组件滚动到边缘以后自身滚动。自身滚动到边缘后，如果有边缘效果，会触发自身的边缘效果，否则触发父组件的边缘效果。
    // PARALLEL	自身和父组件同时滚动，自身和父组件都到达边缘以后，如果自身有边缘效果，则自身触发边缘效果，否则父组件触发边缘效果。
  }

  @Builder
  cell(item: ESObject) {
    Text('Text: ' + item['title'])
      .fontSize(20)
      .height(50)
      .backgroundColor("#aabbcc")
      .width('100%')
  }
}