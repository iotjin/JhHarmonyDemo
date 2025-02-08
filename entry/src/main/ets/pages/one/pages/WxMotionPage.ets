///  WxMotionPage.ets
///
///  Created by iotjin on 2025/01/17. 
///  description:  微信运动

import { router } from '@kit.ArkUI';
import { BaseNavigation, JhProgressHUD, KColors } from 'JhCommon'
import { WxMotionModel } from '../models/WxMotionModel';
import { WxMotionCell } from '../widgets/WxMotionCell'


@Entry
@Preview
@Component
struct WxMotionPage {
  @State dataArr: WxMotionModel[] = []

  aboutToAppear() {
    this.dataArr = this.getData()
    // console.error('data', JSON.stringify(this.dataArr))
  }

  build() {
    Column() {
      BaseNavigation({
        title: '微信运动',
        bgColor: Color.Transparent,
        rightImgPath: $rawfile("images/ic_set_black.png"),
        rightItemCallBack: () => {
          this.clickCell('设置')
        },
      })
      this.body()
      this.footer()
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
        ForEach(this.dataArr, (item: WxMotionModel, index: number) => {
          ListItem() {
            WxMotionCell({
              model: item,
              onClickCell: () => {
                router.pushUrl({ url: 'pages/one/pages/WxMotionTopPage' })
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
  footer() {
    Row() {
      Button('步数排行榜')
        .fontColor(Color.Black)
        .backgroundColor(Color.Transparent)
        .layoutWeight(1)
        .onClick(() => this.clickCell('步数排行榜'))
    }
    .width('100%')
    .height(60)
    .backgroundColor(Color.White)
    .justifyContent(FlexAlign.Center)
  }

  clickCell(text: string) {
    JhProgressHUD.showText(`点击 ${text}`)
  }

  getData() {
    let dataArr: WxMotionModel[] = [
      {
        'time': '2020年5月8日 22:10',
        'ranking': '10',
        'steps': '2861',
        'img': 'images/picture/touxiang_1.jpeg',
        'text': '夺得05月08日排行榜冠军',
        'color': '#00AE5B',
      },
      {
        'time': '2020年6月6日 22:22',
        'ranking': '3',
        'steps': '12180',
        'img': 'images/picture/touxiang_2.jpeg',
        'text': '夺得6月6日排行榜冠军',
        'color': '#FF8B22',
      },
      {
        'time': '2020年7月12日 22:01',
        'ranking': '7',
        'steps': '1986',
        'img': 'images/picture/touxiang_3.jpeg',
        'text': '夺得7月12日排行榜冠军',
        'color': '#00AE5B',
      },
      {
        'time': '2020年8月18日 22:09',
        'ranking': '6',
        'steps': '23354',
        'img': 'images/picture/touxiang_4.jpeg',
        'text': '夺得8月18日排行榜冠军',
        'color': '#FF8B22',
      },
      {
        'time': '2020年9月9日 22:23',
        'ranking': '1',
        'steps': '20015',
        'img': 'images/picture/touxiang_5.jpeg',
        'text': '夺得9月9日排行榜冠军',
        'color': '#FF8B22',
      },
    ];
    return dataArr;
  }
}