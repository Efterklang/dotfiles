import fs from 'fs'
import { CONFIG_FILE_PATH } from './constants.js'

export function response(result) {
    console.log(JSON.stringify({ result }))
}

export function getFromTo() {
    if (!fs.existsSync(CONFIG_FILE_PATH)) {
        fs.writeFileSync(CONFIG_FILE_PATH, `en,de`)
    }
    let [from, to] = fs.readFileSync(CONFIG_FILE_PATH).toString('utf8').trim().split(',')

    return { from, to }
}
