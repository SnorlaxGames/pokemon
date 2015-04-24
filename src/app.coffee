cores = require('./cores')
buildbot = require('./buildbot')
retroplayer = require('./retroplayer')
settings = require('./settings')

toBuffer = (ab) ->
  buffer = new Buffer(ab.byteLength)
  view = new Uint8Array(ab)
  for _, i in buffer
    buffer[i] = view[i]
  buffer

window.addEventListener 'load', (event) ->
  window.ondragover = (event) ->
    event.preventDefault()
    false

  window.ondrop = (event) ->
    event.preventDefault()
    file = event.dataTransfer.files[0]
    name = file.name
    [..., extension] = name.split('.')
    if cores[extension]
      core = cores[extension][0]
      reader = new FileReader()
      reader.addEventListener 'load', (event) ->
        document.getElementById('draghint').classList.add('hidden')
        retroplayer.playCore(window, core, toBuffer(reader.result), settings)
      reader.readAsArrayBuffer(file)
    false
