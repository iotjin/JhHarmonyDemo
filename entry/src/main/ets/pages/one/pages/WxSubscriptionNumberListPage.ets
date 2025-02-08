///  WxSubscriptionNumberListPage.ets
///
///  Created by iotjin on 2025/01/17. 
///  description:  订阅号列表

import { BaseNavigation, JhProgressHUD, KColors } from 'JhCommon'
import { WxSubscriptionNumberListModel } from '../models/WxSubscriptionNumberListModel';
import { WxSubscriptionNumberListCell } from '../widgets/WxSubscriptionNumberListCell'


@Entry
@Preview
@Component
struct WxSubscriptionNumberListPage {
  @State dataArr: WxSubscriptionNumberListModel[] = []

  aboutToAppear() {
    this.dataArr = this.getData()
    // console.error('data', JSON.stringify(this.dataArr))
  }

  build() {
    Column() {
      BaseNavigation({
        title: '订阅号',
        bgColor: Color.Transparent,
        rightImgPath: $rawfile("images/ic_more_black.png"),
        rightItemCallBack: () => {
          this.clickCell('更多')
        },
      })
      this.body()
    }
    .backgroundColor(KColors.wxBgColor)
  }

  @Builder
  body() {
    List() {
      if (this.dataArr.length == 0) {
        ListItem() {
          Text('暂无数据')
            .width('100%')
            .padding({ top: 50 })
            .textAlign(TextAlign.Center)
            .fontSize(18)
        }
      } else {
        this.header()
        ForEach(this.dataArr, (item: WxSubscriptionNumberListModel, index: number) => {
          ListItem() {
            WxSubscriptionNumberListCell({
              model: item,
              onClickCell: () => {
                this.clickCell(item.title!)
              },
            })
          }
        })
      }
    }
    .layoutWeight(1)
    .edgeEffect(EdgeEffect.Spring, {
      alwaysEnabled: true
    })
  }

  @Builder
  header() {
    Search({ value: '', placeholder: '微信号/手机号' })
      .borderRadius(5)
      .margin(10)
      .backgroundColor(Color.White)
      .onSubmit((value: string) => {
        console.log('搜索框 onSubmit 文字：', JSON.stringify(value))
      })
      .onChange((value: string) => {
        console.log('搜索框 onChange 文字：', JSON.stringify(value))
      })
  }

  clickCell(text: string) {
    JhProgressHUD.showText(`点击 ${text}`)
  }

  getData() {
    let dataArr: ESObject[] = [];
    for (let i = 0; i < 50; i++) {
      let map: Record<string, ESObject> = {};
      map['title'] = `title${i}`;
      map['subtitle'] =
        `这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容${i}`;
      map['img'] = 'images/ic_demo1.png';
      map['time'] = '17:30';
      dataArr.push(map);
    }
    return dataArr;
  }
}