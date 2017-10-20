namespace 'Lib'

class Lib.UnsortedIndex
  constructor: (@$container) ->
    self = this
    
    $(document).ready ->
      setInterval (->
        jQuery.ajax
          url: Routes.reload_collection_unsorted_messages_path()
          type: 'GET'
          dataType: 'script'
      ), 5000