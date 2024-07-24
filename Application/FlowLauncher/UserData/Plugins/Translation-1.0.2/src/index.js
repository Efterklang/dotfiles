import fs from 'fs'
import translate from '@vitalets/google-translate-api'
import clipboard from 'clipboardy'
import { getFromTo, response } from './utils.js'
import { CONFIG_FILE_PATH, DEFAULT_RESULT, ICON_PATH } from './constants.js'

Promise.resolve().then(async () => {
    try {
        let { method, parameters: params } = JSON.parse(process.argv[2])
        let { from, to } = getFromTo()

        await main(method, params, from, to)
    } catch (e) {
        response([
            {
                Title: 'Error',
                Subtitle: e.message || '',
                IcoPath: ICON_PATH,
            },
        ])
    }
})

async function main(method, params, from, to) {
    switch (method) {
        case 'query':
            if (params.length > 0 && params[0].startsWith(':set')) {
                return setLanguage(params)
            } else if (params.length > 0 && params[0]) {
                return await performTranslate(params, from, to)
            } else {
                return response(DEFAULT_RESULT)
            }
        case 'setLanguage':
            return fs.writeFileSync(CONFIG_FILE_PATH, params.join(','))
        case 'copy':
            return clipboard.writeSync(params.join())
        default:
            return response(DEFAULT_RESULT)
    }
}

function setLanguage(params) {
    const split = params[0].trim().split(' ')

    if (split.length === 3) {
        const from = split[1]
        const to = split[2]
        return response([
            {
                Title: 'Translate',
                Subtitle: `Set translate from ${from.toUpperCase()} to ${to.toUpperCase()}`,
                JsonRPCAction: {
                    method: 'setLanguage',
                    parameters: [from, to],
                },
                IcoPath: ICON_PATH,
            },
        ])
    } else {
        return response([
            {
                Title: 'Translate',
                Subtitle: 'Set translate `From` and `To` languages `en`,`de` etc.',
                IcoPath: ICON_PATH,
            },
        ])
    }
}

async function performTranslate(params, from, to) {
    let text = params.join(' ').trim()
    const isReverse = text.startsWith('r ')

    if (isReverse && text.length > 2) {
        text = text.substring(2)
        const tmp = from
        from = to
        to = tmp
    }

    if (text) {
        const res = await translate(text.trim(), { to })

        return response([
            {
                Title: res.text,
                Subtitle: `${from} -> ${to} parameters`,
                IcoPath: ICON_PATH,
                JsonRPCAction: {
                    method: 'copy',
                    parameters: [res.text],
                    dontHideAfterAction: false,
                },
            },
        ])
    } else {
        return response(DEFAULT_RESULT)
    }
}