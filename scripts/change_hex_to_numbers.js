const fs = require('fs')
const { join } = require('path')
function replaceColors(str) {
    let splits = str.split('(color:').filter(Boolean)
    let rstr = str;
    splits.forEach((item, index, all) => {
    if(item.indexOf(')') > 0) {
        const params = item.split(')')[0]
        rstr = rstr.replaceAll(`(color:${params})`, parseInt(`0x${params.trim()}`))
    }
    })
    return rstr
    }
const root = fs.readdirSync('./themes')
root.forEach((folder) => {
    const accents = fs.readdirSync(`./themes/${folder}`)
    accents.forEach((a) => {
let xcuSplits = fs.readFileSync(join(__dirname,'..', `themes`, folder, a, `catppuccin-${folder}-${a}.xcu`)).toString()
const formatted = replaceColors(xcuSplits)
fs.writeFileSync(join(__dirname,'..', `themes`, folder, a, `catppuccin-${folder}-${a}.xcu`), formatted.replaceAll('\n', '').replaceAll('\r', '').replaceAll(`\t`, '').replaceAll(` `, '') + "\n")
require('child_process').execSync(`sed -i 's/\r//' ${join(__dirname,'..', `themes`, folder, a, `install.sh`)}`)
})
})