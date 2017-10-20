namespace 'Lib'

class Lib.UnsortedIndex
  constructor: (@$container) ->
    self = this
    
    $(document).ready ->
      setInterval (->
        $.ajax(
          url: Routes.collection_count_unsorted_messages_path()
          type: 'GET'
          dataType: 'script'
        ).success(
            (data, textStatus, jqXHR) ->
              console.log data
              if parseInt(data) != parseInt($('@messageTr').length)
                $('<audio class="sound-player" autoplay="autoplay" style="display:none;">' + '<source src="' + 'assets/sounds/file-sounds-937-job-done.wav' + '" />' + '<embed src="' + 'assets/sounds/file-sounds-937-job-done.wav' + '" hidden="true" autostart="true" loop="false"/>' + '</audio>').appendTo 'body'
        )
        setTimeout (->
          $.ajax(
            url: Routes.reload_collection_unsorted_messages_path()
            type: 'GET'
            dataType: 'script'
          )
        ), 100
      ), 5000