///  WxPayPage.ets
///
///  Created by iotjin on 2025/01/03.
///  description:  微信支付

import { BaseNavigation, JhProgressHUD, KColors } from 'JhCommon'
import { router } from '@kit.ArkUI'


const _money = 345345.13

@Entry
@Preview
@Component
struct WxPayPage {
  @State dataArr: ESObject[] = []

  aboutToAppear() {
    this.dataArr = this.getData()
    console.error('data', JSON.stringify(this.dataArr))
  }

  getData() {
    let dataArr: ESObject[] = [];
    for (let i = 0; i < 3; i++) {
      const maxCount = i == 1 ? 2 : 8
      const title = i == 0 ? '腾讯服务' : (i == 1 ? '限时推广' : '三方服务')
      let map: Record<string, ESObject> = {}
      map['groupName'] = title
      let groups: ESObject = [];
      for (let j = 0; j < maxCount; j++) {
        let item: Record<string, ESObject> = {}
        item['text'] = `功能${i}-${j}`
        // item['imageUrl'] = 'https://gitee.com/iotjh/Picture/raw/master/lufei.png'
        item['imageUrl'] = $rawfile("images/ic_func.png")
        groups.push(item)
      }
      map['groups'] = groups;
      dataArr.push(map);
    }
    return dataArr;
  }

  build() {
    Column() {
      BaseNavigation({
        title: $r('app.string.wxPay'),
        bgColor: Color.Transparent,
        rightImgPath: $rawfile("images/ic_more_black.png"),
        rightItemCallBack: () => {
          router.pushUrl({ url: 'pages/four/pages/WxPayManagerPage' })
        },
      })
      this.body()
    }
    .backgroundColor(KColors.wxBgColor)
  }

  @Builder
  header() {
    Row() {
      Column() {
        Blank().height(30)
        Image($rawfile('wechat/mine/ic_shoufukuan.png')).width(35)
        Blank().height(8)
        Text('收付款').fontColor(Color.White).fontSize(16)
      }
      .alignItems(HorizontalAlign.Center)
      .flexGrow(1)

      Column() {
        Blank().height(30)
        Image($rawfile('wechat/mine/ic_qianbao.png')).width(35)
        Blank().height(8)
        Text('钱包').fontColor(Color.White).fontSize(16)
        Blank().height(5)
        Text(`¥${_money}`).fontColor(Color.White).fontSize(14).opacity(0.6)
      }
      .alignItems(HorizontalAlign.Center)
      .flexGrow(1)
    }
    .width('100%')
    .height(150)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Top)
    .margin({ top: 10 })
    .borderRadius(10)
    .backgroundColor(KColors.wxPayColor)
    .shadow({
      radius: 5,
      color: '#bebebe',
      offsetX: 0,
      offsetY: 5
    })
  }

  @Builder
  body() {
    List({ space: 10 }) {
      this.header()

      ForEach(this.dataArr, (item: ESObject, index: number) => {
        ListItemGroup({ header: this.itemHead(item['groupName']) }) {
          ListItem() {
            Grid() {
              ForEach(item['groups'], (groupItem: string, index2: number) => {
                GridItem() {
                  this.cell(groupItem, index2)
                }
              })
            }
            .columnsTemplate("1fr 1fr 1fr") // 设置3列，每列均分
            .columnsGap(1) // 设置列间距
            .rowsGap(1) // 设置行间距
            .padding({
              top: 1,
              bottom: 1,
              left: 1,
              right: 1
            })
            .width('calc(100% - 5px)')
          }
        }
        .divider({ strokeWidth: 1, color: Color.Blue }) // 每行之间的分界线
        .backgroundColor(Color.White)
        .borderRadius(5)
        .shadow({
          radius: 5,
          color: '#bebebe',
          offsetX: 0,
          offsetY: 5
        })
      })
    }
    .padding({ left: 10, right: 10 })
    .layoutWeight(1)
    .edgeEffect(EdgeEffect.Spring, {
      alwaysEnabled: true
    })
    // .sticky(StickyStyle.Header | StickyStyle.Footer)
    .scrollBar(BarState.Off)
  }

  @Builder
  itemHead(text: string) {
    Text(text)
      .fontSize(16)
      .width("100%")
      .padding(10)
    // .backgroundColor(0xAABBCC)
  }

  @Builder
  cell(item: ESObject, index: number) {
    Column() {
      Image(item['imageUrl']).width(25).height(25)
      Blank().height(10)
      Text(item['text'])
        .fontSize(13)
        .fontColor('#666666')
        .textAlign(TextAlign.Center)
        .width('100%')
    }
    .padding(15)
    // .backgroundColor('#F2F3F7')
    .borderRadius(5)
    .border({ width: 0.5, color: '#D2D2D2' })
    .onClick(() => {
      console.error('data', JSON.stringify(item))
      JhProgressHUD.showText(item['text'])
    })
  }
}