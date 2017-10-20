namespace 'Lib'

class Lib.UnsortedIndex
  constructor: (@$container) ->
    self = this
    
    $(document).ready ->
      setInterval (->
        $.ajax(
          url: Routes.detect_new_messages_unsorted_messages_path()
          type: 'GET'
          dataType: 'script'
        ).success(
            (data, textStatus, jqXHR) ->
              if data == 'true'
                $.ajax(
                  url: Routes.reload_collection_unsorted_messages_path()
                  type: 'GET'
                  dataType: 'script'
                )
                $('<audio class="sound-player" autoplay="autoplay" style="display:none;">' + '<source src="' + '/file-sounds-937-job-done.wav' + '" />' + '<embed src="' + '/file-sounds-937-job-done.wav' + '" hidden="true" autostart="true" loop="false"/>' + '</audio>').appendTo 'body'
        )
      ), 5000