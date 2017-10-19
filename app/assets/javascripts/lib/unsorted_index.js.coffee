namespace 'Lib'

class Lib.UnsortedIndex
  constructor: (@$container) ->
    self = this
    console.log 123

    # @$removeBtn = @$container.find('@removeBtn')
    # @$uploaderAdditional = @$container.find('@uploaderAdditional')
    # @$removePassport = @$container.find('@removePassport')
    # @$passport = @$container.find('@passUploader')

    # $('@uploader').each ->
    #   if $(this).data('filename')
    #     strArr = $(this).data('filename').split('/')
    #     filename = strArr[strArr.length - 1]
    #     self.uploaderChange(this, filename, self.shortFilename)

    # if $('@passUploader').data('filename')
    #   @$uploaderAdditional.show()
    #   self.addPassPage()
    #   $('@passPageUploader').change ->
    #     unless $(this).hasClass('active')
    #       self.addPassPage()