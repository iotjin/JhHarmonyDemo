import { BaseNavigation, KColors } from 'JhCommon'
import { List1Cell } from './List1Cell'
import { List1Model } from './List1Model'
import { promptAction } from '@kit.ArkUI'


@Entry
@Preview
@Component
struct List1Page {
  @State dataArr: List1Model[] = []

  aboutToAppear() {
    this.dataArr = this.getData()
    console.error('data', JSON.stringify(this.dataArr))
  }

  getData() {
    let dataArr: ESObject[] = [];
    for (let i = 0; i < 35; i++) {
      let map: Record<string, ESObject> = {};
      map['title'] = `title${i}`;
      map['content'] = `这是内容这是内容这是内容这是内容这是内容这是内容这是内容{i}`;
      map['phone'] = `${i}${i}${i} xxxxxxx`;
      map['imageUrl'] = 'https://gitee.com/iotjh/Picture/raw/master/lufei.png';
      map['place'] = `place${i}`;
      map['state'] = `流转中${i}`;
      dataArr.push(map);
    }
    return dataArr;
  }

  build() {
    Column() {
      BaseNavigation({ title: 'List1' })
      Scroll() {
        Column() {
          this.header('header')
          this.body()
          this.header('footer')
        }
        .backgroundColor(KColors.wxBgColor)
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

      ForEach(this.dataArr, (item: List1Model, index: number) => {
        ListItem() {
          List1Cell({
            model: item,
            onClickCell: () => {
              console.log('点击cell', JSON.stringify(item))
              promptAction.showToast({ message: item.title });
            },
          })
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
  }
}