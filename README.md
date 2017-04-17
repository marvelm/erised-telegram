## erised-telegram

### Usage
```
git clone https://github.com/marvelm/erised-telegram && cd erised-telegram
docker build . -t 'erised-telegram'
docker run -it -v /home/m/dev/fake-home:/root/ -e TELEGRAM_BOT_TOKEN=my_token erised-telegram
```
