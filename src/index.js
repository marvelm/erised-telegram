const erised = require('erised')
const TelegramBot = require('node-telegram-bot-api')

const token = process.env.TELEGRAM_BOT_TOKEN
const bot = new TelegramBot(token, {polling: true})

function extractUrls (entities, text) {
  return entities
    .filter(e => e.type === 'url')
    .map(({offset, length}) => text.slice(offset, offset + length))
}

bot.on('message', msg => {
  const {entities, text} = msg
  console.log(JSON.stringify(msg, null, 2))

  if (entities) {
    const urls = new Set(extractUrls(entities, text))
    urls.forEach(url => {
      erised.archivePage(url, 'bot')
        .tap(page => console.log(JSON.stringify(page, null, 2)))
    })
  }
})
