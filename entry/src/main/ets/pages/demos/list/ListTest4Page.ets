import { BaseNavigation, KColors } from 'JhCommon'
import data from '../../res/json_data.json'

import { common } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { buffer } from '@kit.ArkTS';

@Entry
@Preview
@Component
struct ListTest4Page {
  @State dataArr: ESObject[] = []
  private context = getContext(this) as common.UIAbilityContext;

  async aboutToAppear() {
    // this.dataArr = this.getData()
    // console.log('dataArr', JSON.stringify(this.dataArr))
    this.dataArr = data['data']
    console.error('data', JSON.stringify(data))
  }

  getRawFile() {
    try {
      let context = getContext(this) as common.UIAbilityContext;
      context.resourceManager.getRawFileContent("/json/json_data.json", (error: BusinessError, value: Uint8Array) => {
        if (error != null) {
          console.error("error is " + error);
        } else {
          let rawFile = value;
          let str = buffer.from(rawFile.buffer).toString();
          console.log("json:" + value)
        }
      });
    } catch (error) {
      let code = (error as BusinessError).code;
      let message = (error as BusinessError).message;
      console.error(`callback getRawFileContent failed, error code: ${code}, message: ${message}.`);
    }
  }

  getData() {
    let dataArr: ESObject[] = [];
    for (let i = 0; i < 35; i++) {
      let map: Record<string, ESObject> = {};
      map['title'] = `title${i}`;
      map['content'] = `这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容${i}`;
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
      BaseNavigation({ title: 'ListTest4 - 自定义cell2' })
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
      ForEach(this.dataArr, (item: ESObject, index: number) => {
        ListItem() {
          this.cell(item, index)
        }
      })
    }
    .layoutWeight(1)

    // .divider({
    //   strokeWidth: 1,
    //   startMargin: 15,
    //   endMargin: 15,
    //   color: Color.Orange,
    // })
  }

  @Builder
  cell(item: ESObject, index: number) {
    Column() {
      Image(item['imageUrl'])
        .width('100%').height('calc(100% * 0.3)')
      // .borderRadius({ topLeft: 15, topRight: 15 })
      // .clip(true)

      Row() {
        Image(item['imageUrl']).width(40).height(40).borderRadius(20)
        Blank().width(5)
        Column() {
          Text(item['title']).fontSize(15)
          Blank().height(3)
          Text(item['content'])
            .fontSize(15)
            .maxLines(2)
            .textOverflow(
              index % 2 == 0 ?
                { overflow: TextOverflow.Ellipsis } : // 文本超长显示省略号
                { overflow: TextOverflow.MARQUEE } // 滚动显示
            )
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)
      }
      .margin(10)
      .justifyContent(FlexAlign.SpaceBetween)
    }
    // .borderRadius({ topLeft: 15, topRight: 15 })
    .borderRadius({ bottomLeft: 15, bottomRight: 15 })
    .clip(true)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(Color.White)
    .margin({
      top: index == 0 ? 10 : 0,
      bottom: 10,
      left: 10,
      right: 10
    })
  }
}