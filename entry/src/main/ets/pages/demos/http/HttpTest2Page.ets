import { APIs, BaseNavigation, ErrorType, HttpUtils, ResType } from 'JhCommon';
// import Request from 'JhCommon/src/main/ets/JhCommon/http/Request';
import { Request } from 'JhCommon';
import { AxiosError, AxiosResponse } from '@ohos/axios';

@Entry
@Component
struct HttpTest2Page {
  @State text1: string = ''
  @State text2: string = ''

  aboutToAppear() {
    // this.getRequest0()
    this.getRequest()
    this.postRequest()
    this.asyncRequest()
  }

  build() {
    Column() {
      BaseNavigation({ title: 'HttpTest2' })
      Scroll() {
        Column() {
          Text(this.text1).padding(15)
          Text(this.text2).padding(15)
        }
      }
    }
  }

  getRequest0() {
    const url = APIs.getPage
    const params: object = Object({ 'page': 0, 'limit': 10 })
    Request({ url: url, method: 'get', params: params }).then((res: AxiosResponse) => {
      // res 返回的 {code,suc,msg,data}
      console.log("封装 - get - 返回数据:" + JSON.stringify(res['data']))
      console.log("msg:" + res['msg'])
    }).catch((err: AxiosError) => {
      console.log("err:" + err.message)
    })
  }

  getRequest() {
    const url = APIs.getPage
    const params: object = Object({ 'page': 0, 'limit': 10 })

    // HttpUtils.request(Method.get, url, params).then((res: ResType) => {
    //   console.log("二次封装 - post - 返回数据:" + JSON.stringify(res))
    //   console.log("二次封装 - post - 返回数据:" + JSON.stringify(res.data))
    //   console.log('code:', res.code)
    //   console.log('msg:', res.msg)
    // }).catch((err: ErrorType) => {
    //   console.log("err:" + err.msg)
    // })

    HttpUtils.get(url, params).then((res: ResType) => {
      console.log("二次封装 - get - 返回数据:" + JSON.stringify(res))
      console.log("二次封装 - get - 返回数据:" + JSON.stringify(res.data))
      console.log('code:', res.code)
      console.log('msg:', res.msg)
      this.text1 = JSON.stringify(res.data)
    }).catch((err: ErrorType) => {
      console.log("err:" + err.msg)
    })
  }

  postRequest() {
    const url = APIs.apiPrefix + APIs.getSimpleDictList
    const params: object = Object({ 'page': 0, 'limit': 10 })

    HttpUtils.post(url, params).then((res: ResType) => {
      console.log("二次封装 - post - 返回数据:" + JSON.stringify(res))
      console.log("二次封装 - post - 返回数据:" + JSON.stringify(res.data))
      console.log('code:', res.code)
      console.log('msg:', res.msg)
      this.text2 = JSON.stringify(res.data)
    }).catch((err: ErrorType) => {
      console.log("err:" + err.msg)
    })
  }

  async asyncRequest() {
    const url = APIs.apiPrefix + APIs.getSimpleDictList
    const params: object = Object({ 'page': 0, 'limit': 10 })
    let res = await HttpUtils.post(url, params)
    console.log('code:', res.code)
    console.log('msg:', res.msg)
    if (res.code == 200) {
      console.log("data:" + JSON.stringify(res.data))
    }
  }
}