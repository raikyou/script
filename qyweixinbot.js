const axios = require('axios')

axios
    .post('https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=968b5d58-67d3-4f45-a2f1-ef6460e6871f', {
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
