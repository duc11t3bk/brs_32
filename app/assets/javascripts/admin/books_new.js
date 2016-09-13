$(document).on("ready page:load", function(){
  $('#book_cover_image_name1').fileinput({
    showUpload : false,
    showRemove : false,
    previewFileType: "image"
  });
  $('#book_cover_image_name').on('change', function(){
    if(this.files[0] != null){
      var size_in_megabytes = this.files[0].size/1024/1024;
      if(size_in_megabytes > 1){
        alert('Maximum file size is 1MB. Please choose an other file!');
        $('#book_cover_image_name').fileinput('clear');
      }
    }
  });
  $('.form_date').datetimepicker({
    startView: 'month',
    minView: 'month',
    autoclose: true,
    todayBtn: true
  });

  Dropzone.options.new_book = {
    paramName: "book[cover_image_name]"
  }
});


