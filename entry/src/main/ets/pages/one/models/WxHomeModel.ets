export class WxHomeModel {
  title?: string
  subtitle?: string
  img?: string
  time?: string
  isNew?: boolean
  type?: string // 0,1,2,3
}

// type 0 没有侧滑
// type 1 删除
// type 2 标为未读和删除
// type 3 不在关注和删除

export interface WxHomeItemType {
  title?: string
  subtitle?: string
  img?: string
  time?: string
  isNew?: boolean
  type?: string
}