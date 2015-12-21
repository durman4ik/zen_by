jQuery ->
  $('#new_file_upload').fileupload
    dataType: 'script',
    progressall: (e, data) =>
      progress = parseInt data.loaded / data.total * 100, 10
      $('#progress .progress-bar.progress-bar-success.progress-bar-striped').addClass('active').css(
        'width',
        progress + '%')

    done: (e, data) =>
      reset_progress_bar()


reset_progress_bar = () =>
  $('#progress .progress-bar.progress-bar-success.progress-bar-striped').remove()
  $('#progress').append("<div style='width:0%' class='progress-bar progress-bar-success progress-bar-striped'</div>")