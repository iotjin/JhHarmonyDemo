///  JhNinePicture.ets
///
///  Created by iotjin on 2025/02/12. 
///  description:  九宫格图片展示 4图处理 加载本地和网络图片


const _space = 5.0; // 上下左右间距

type imageType = string | Resource | PixelMap

@Preview
@Component
export struct JhNinePicture {
  @Prop public images: imageType[] = []
  @Prop public lRSpace: number = 0 // 外部设置的左右间距
  @Prop private itemMargin: number = 5 // item行列间距
  @Prop public isHandleFour: boolean = true
  public onPress?: (index: number) => void
  //
  @State private maxColumn: number = 3

  aboutToAppear() {
  }

  build() {
    if (this.images.length > 0) {
      this.body()
    }
  }

  getColumnWidth() {
    // return `calc((100% - 10vp) / 3)`
    return `calc((100% - ${this.itemMargin * (this.maxColumn - 1)}vp) / ${this.maxColumn})`
  }

  @Builder
  body() {
    Grid() {
      ForEach(this.images, (item: imageType, index: number) => {
        GridItem() {
          Image(item)
            .width(this.images.length === 1 ? '55%' : this.getColumnWidth())
            .aspectRatio(this.images.length === 1 ? (55 / 76) : 1)
            .objectFit(ImageFit.Cover)
            .onClick(() => this.clickItemCell(index))
        }
      })
    }
    .maxCount(this.isHandleFour && this.images.length === 4 ? 2 : this.maxColumn)
    .columnsGap(this.itemMargin) // 设置列间距
    .rowsGap(this.itemMargin) // 设置行间距
    .padding(_space)
    .width(`calc(100% - ${this.lRSpace}vp)`)
  }

  clickItemCell(index: number) {
    this.onPress?.(index)
  }
}