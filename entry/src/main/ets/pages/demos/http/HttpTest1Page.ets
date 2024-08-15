import axios, { AxiosError, AxiosResponse } from '@ohos/axios';
import { APIs, BaseNavigation } from 'JhCommon';

@Entry
@Component
struct HttpTest1Page {
  @State text1: string = ''
  @State text2: string = ''

  aboutToAppear() {
    this.getRequest()
    this.postRequest()
  }

  build() {
    Column() {
      BaseNavigation({ title: 'HttpTest1' })
      Scroll() {
        Column() {
          Text(this.text1).padding(15)
          Text(this.text2).padding(15)
        }
      }
    }
  }

  getRequest() {
    const url = APIs.apiPrefix + APIs.getPage
    // axios.request({ url: url, params: { 'page': 0, 'limit': 10 } }).then((res: AxiosResponse) => {
    //   console.log("result:" + JSON.stringify(res.data))
    //   console.log("msg:" + res.data['msg'])
    //   this.text1 = JSON.stringify(res.data)
    // }).catch((err: AxiosError) => {
    //   console.log("err:" + err.message)
    // })

    const params: object = Object({ 'page': 0, 'limit': 10 })
    axios.get(url, { params: params }).then((res: AxiosResponse) => {
      console.log("get - 返回数据:" + JSON.stringify(res.data))
      console.log("msg:" + res.data['msg'])
      this.text1 = JSON.stringify(res.data)
    }).catch((err: AxiosError) => {
      console.log("err:" + err.message)
    })
  }

  postRequest() {
    const url = APIs.apiPrefix + APIs.getSimpleDictList
    const params: object = Object({ 'page': 0, 'limit': 10 })
    axios.post(url, params).then((res: AxiosResponse) => {
      console.log("post - 返回数据:" + JSON.stringify(res.data))
      console.log("msg:" + res.data['msg']);
      this.text2 = JSON.stringify(res.data);
    }).catch((err: AxiosError) => {
      console.log("err:" + err.message);
    });
  }
}