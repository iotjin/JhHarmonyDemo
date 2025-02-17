import { BaseNavigation, JhNinePicture } from 'JhCommon'


@Entry
@Preview
@Component
struct GridTest4Page {
  @State dataArr: ESObject[] = []
  @State dataArr2: ESObject[] = []

  aboutToAppear() {
    this.dataArr = this.getData()
    this.dataArr2 = this.getData2()

  }

  getData() {
    const tempArr: string[] = []
    for (let i = 0; i < 9; i++) {
      const img = i % 2 === 0
        ? 'https://gitee.com/iotjh/Picture/raw/master/lufei2.png'
        : 'https://gitee.com/iotjh/Picture/raw/master/lufei.png'
      tempArr.push(img)
    }
    return tempArr
  }

  getData2() {
    const tempArr: string[] = []
    for (let i = 0; i < 4; i++) {
      const img = i % 2 === 0
        ? 'https://gitee.com/iotjh/Picture/raw/master/lufei2.png'
        : 'https://gitee.com/iotjh/Picture/raw/master/lufei.png'
      tempArr.push(img)
    }
    return tempArr
  }

  build() {
    Column() {
      BaseNavigation({ title: 'GridTest4 - 九宫格' })
      Scroll() {
        Column() {
          this.body()
        }
        .height('100%')
      }
      .layoutWeight(1)
      .edgeEffect(EdgeEffect.Spring, {
        alwaysEnabled: true
      })
    }
  }

  @Builder
  body() {
    Text('九宫格')
    JhNinePicture({
      images: this.dataArr,
      lRSpace: 100,
      onPress: (index: number) => {
        this.onClickImg(index)
      }
    })
    Text('九宫格，4图处理')
    JhNinePicture({
      images: this.dataArr2,
      lRSpace: 100,
      onPress: (index: number) => {
        this.onClickImg(index)
      }
    })
    Text('九宫格，4图未处理')
    Row() {
      JhNinePicture({
        isHandleFour: false,
        images: this.dataArr2,
        onPress: (index: number) => {
          this.onClickImg(index)
        }
      })
    }
    .margin({ left: 50, right: 50 })

  }

  onClickImg(index: number) {
    console.error('index', JSON.stringify(index))
  }
}