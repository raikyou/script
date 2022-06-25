const axios = require('axios')

axios
    .post('https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=90f6d0f4-e7da-4cd5-b1ef-47e582b87199', {
        msgtype: 'text',
        text: {
            content: '下午14点进行产品和项目同步，会议号：9000305751',
            mentioned_list: ['@all']
        }
    })
    .then(response => {
        console.log(response.data)
    })
    .catch(error => {
        console.log(error)
    })
