///  WxSubscriptionNumberPage.ets
///
///  Created by iotjin on 2025/01/17. 
///  description: 订阅号消息

import { router } from '@kit.ArkUI';
import { BaseNavigation, JhProgressHUD, JhSetCell, KColors } from 'JhCommon'
import { WxSubscriptionNumberModel } from '../models/WxSubscriptionNumberModel';
import { WxSubscriptionNumberCell } from '../widgets/WxSubscriptionNumberCell'


@Entry
@Preview
@Component
struct WxSubscriptionNumberPage {
  @State dataArr: WxSubscriptionNumberModel[] = []

  aboutToAppear() {
    this.dataArr = this.getData()
    // console.error('data', JSON.stringify(this.dataArr))
  }

  build() {
    Column() {
      BaseNavigation({
        title: '订阅号消息',
        bgColor: Color.Transparent,
        rightImgPath: $rawfile("images/ic_more_three.png"),
        rightItemCallBack: () => {
          router.pushUrl({ url: 'pages/one/pages/WxSubscriptionNumberListPage' })
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
        ForEach(this.dataArr, (item: WxSubscriptionNumberModel, index: number) => {
          ListItem() {
            WxSubscriptionNumberCell({
              model: item,
              index: index,
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
    .divider({
      strokeWidth: 10,
      startMargin: 0,
      endMargin: 0,
      color: Color.Transparent
      // color: KColors.kLineColor
    })
  }

  clickCell(text: string) {
    JhProgressHUD.showText(`点击 ${text}`)
  }

  getData() {
    let dataArr: WxSubscriptionNumberModel[] = [
      {
        'title': '央视新闻',
        'subtitle': '早啊，新闻来了',
        'time': '1小时前',
        'img1': 'images/picture/picture0.jpeg',
        'text2': '今天，央视新闻为你准备了一幅漫画，一起来看看，这是不是学生时代的你',
        'img2': 'images/picture/touxiang_1.jpeg',
      },
      {
        'title': '开发助手',
        'subtitle': '您收到一封新的邮件',
        'time': '1小时前',
        'img1': 'images/picture/picture1.jpeg',
        'text2': '欢迎欢迎',
        'img2': 'images/picture/touxiang_5.jpeg',
      },
      {
        'title': '程序员',
        'subtitle': '程序员面试现场发生了什么？？？',
        'time': '1小时前',
        'img1': 'images/picture/picture2.jpeg',
        'text2': '你的专业能为你做什么',
        'img2': 'images/picture/touxiang_2.jpeg',
      },
      {
        'title': '腾讯新闻',
        'subtitle': '早上好',
        'time': '1小时前',
        'img1': 'images/picture/picture3.jpeg',
        'text2': '来看看今日的天气情况吧',
        'img2': 'images/picture/touxiang_3.jpeg',
      },
      {
        'title': '人民网',
        'subtitle': '夜读',
        'time': '1小时前',
        'img1': 'images/picture/picture8.jpg',
        'text2': '夜读，别高估自己的水平，别低估他人的努力',
        'img2': 'images/picture/touxiang_4.jpeg',
      },
      {
        'title': '阿里技术',
        'subtitle': '从架构到源码：一文了解Flutter渲染机制',
        'time': '1小时前',
        'img1': 'images/picture/picture5.jpeg',
        'text2': '机器学习，从入门到进阶',
        'img2': 'images/picture/touxiang_5.jpeg',
      },
      {
        'title': 'CSDN',
        'subtitle': '小主，您有一条新的留言',
        'time': '1小时前',
        'img1': 'images/picture/picture6.jpg',
        'text2': '欢迎欢迎，快来看看吧',
        'img2': 'images/picture/touxiang_6.jpg',
      },
      {
        'title': '新华网',
        'subtitle': '这种病一旦患上将伴随一生，有些人最容易被盯上',
        'time': '1小时前',
        'img1': 'images/picture/picture7.jpg',
        'text2': '人造肉来了，"香"吗',
        'img2': 'images/picture/tubiao.png',
      },
    ];
    return dataArr;
  }
}