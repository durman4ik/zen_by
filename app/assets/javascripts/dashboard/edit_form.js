$(document).on('ready', function(){
    var stick_to_body_select          = $('#stick_to_body_select'),
        step                          = $('#fields_for_page_enabled'),
        page_enabled_checkbox         = $('.page_enabled_checkbox'),
        radiobuttons = $('.attach_checkbox');

    toastr.options = {
        closeButton: false,
        debug: false,
        newestOnTop: true,
        progressBar: true,
        positionClass: "toast-bottom-right",
        preventDuplicates: false,
        onclick: null,
        showDuration: "300",
        hideDuration: "1000",
        timeOut: "6000",
        extendedTimeOut: "2000",
        showEasing: "swing",
        hideEasing: "linear",
        showMethod: "fadeIn",
        hideMethod: "fadeOut"
    };

    $('.popover-right').popover({placement: 'right'});
    $('.popover-bottom').popover({placement: 'bottom'});
    $('.popover-top').popover({placement: 'top'});
    $('.popover-left').popover({placement: 'left'});


    if (!page_enabled_checkbox.is(':checked'))
        step.hide();

    if ($('#show_field_days_in_hotels_checkbox').is(':checked')) {
        $('.show_field_days_in_hotels').each(function(){
            $(this).removeClass('hidden')
        });
    } else {
        $('.show_field_days_in_hotels').each(function(){
            $(this).addClass('hidden')
        });
    }

    $("input[type=checkbox]").not('#onoffswitch').iCheck({
        checkboxClass: 'icheckbox_square-blue',
        increaseArea: '20%'
    });

    $("input[type=radio]").iCheck(({
        radioClass: 'iradio_square-blue'
    }));

    page_enabled_checkbox.on('change', function() {
        if(this.checked) {
            step.slideDown('fast');
        } else {
            step.slideUp('fast');
        }
    });

    $('#show_field_days_in_hotels_checkbox').on('ifChanged', function(){
        if(this.checked) {
            $('.show_field_days_in_hotels').each(function(){
               $(this).removeClass('hidden')
            });
        } else {
            $('.show_field_days_in_hotels').each(function(){
                $(this).addClass('hidden')
            });
        }
    });

    $('a.default_color').on('click', function(){
        var default_color = $(this).data('default');
        $(this).parent().parent().find('input.colorpicker').val(default_color).css('background-color', default_color, 'color', '#000');
    });

    tinyMCE.init({
        selector: "textarea.editor",
        plugins: 'image textcolor link code advlist',
        toolbar: 'undo redo | bold italic | fontsizeselect | alignleft aligncenter alignright | link image | bullist numlist outdent indent | code | forecolor backcolor ',
        fontsize_formats: "6pt 7pt 8pt 9pt 10pt 11pt 12pt 13pt 14pt 15pt 16pt 18pt 22pt 26pt 30pt 36pt"
    });

    $('.datepicker_start').datepicker({
        dateFormat: 'dd.mm.yy',
        minDate: 0,
        onSelect: function (date) {
            var finish = $(this).closest('.row').find('.datepicker_finish');
            var startDate = $(this).datepicker('getDate');
            var minDate = $(this).datepicker('getDate');
            if(finish.val() == '')
                finish.datepicker('setDate', minDate);
            finish.datepicker('option', 'minDate', minDate);
        }
    });

    $('.datepicker_finish').datepicker({
        dateFormat: 'dd.mm.yy'
    });

    $.datepicker.setDefaults($.datepicker.regional['ru']);


    $.each(radiobuttons, function(){
       if($(this).is(':checked')){
           var page_fields = $(this).closest('.fields').find('#page_fields'),
               country_fields = $(this).closest('.fields').find('#country_fields'),
               category_fields = $(this).closest('.fields').find('#category_fields'),
               tour_fields = $(this).closest('.fields').find('#tour_fields'),
               ar = [page_fields, tour_fields, category_fields, country_fields],
               value = this.value;
           $.each(ar, function(){
               if(this[0].id.indexOf(value) > -1) {
                   this.removeClass('hidden');
               } else {
                   this.addClass('hidden');
               }
           });
       }
    });

    $(document).on('ifChecked', '.attach_checkbox', function(){
        var page_fields = $(this).closest('.fields').find('#page_fields'),
            country_fields = $(this).closest('.fields').find('#country_fields'),
            category_fields = $(this).closest('.fields').find('#category_fields'),
            tour_fields = $(this).closest('.fields').find('#tour_fields'),
            ar = [page_fields, tour_fields, category_fields, country_fields],
            value = this.value;
        $.each(ar, function(){
            if(this[0].id.indexOf(value) > -1) {
                this.removeClass('hidden');
            } else {
                this.addClass('hidden');
            }
        });
    });

    $(document).on('change', '.attach_select', function() {
        var page_fields = $(this).closest('.fields').find('#page_fields'),
            country_fields = $(this).closest('.fields').find('#country_fields'),
            category_fields = $(this).closest('.fields').find('#category_fields'),
            tour_fields = $(this).closest('.fields').find('#tour_fields'),
            ar = [page_fields, tour_fields, category_fields, country_fields];
        var value = $(this).closest('.form-group')[0].id;

        $.each(ar, function(){
            if(this[0].id.indexOf(value) < 0) {
                $(this).find('select')[0].value = null
            }
        })
    });


});

$(document).on('nested:fieldAdded', function(event){
    var field = event.field,
        textarea = field.find('.tinyeditor')[0];

    if(textarea) {
        var text_area_id = textarea.id;
        tinyMCE.init({
            selector: "textarea.tinyeditor#" + text_area_id,
            plugins: 'image textcolor link code advlist',
            toolbar: 'undo redo | bold italic | fontsizeselect | alignleft aligncenter alignright | link image | bullist numlist outdent indent | code | forecolor backcolor ',
            fontsize_formats: "6pt 7pt 8pt 9pt 10pt 11pt 12pt 13pt 14pt 15pt 16pt 18pt 22pt 26pt 30pt 36pt"
        });
    }

    $('.datepicker_start').datepicker({
        dateFormat: 'dd.mm.yy',
        minDate: 0,
        onSelect: function (date) {
            var finish = $(this).closest('.row').find('.datepicker_finish');
            var startDate = $(this).datepicker('getDate');
            var minDate = $(this).datepicker('getDate');
            if(finish.val() == '')
                finish.datepicker('setDate', minDate);
            finish.datepicker('option', 'minDate', minDate);
        }
    });

    $('.datepicker_finish').datepicker({
        dateFormat: 'dd.mm.yy'
    });

    if ($('#show_field_days_in_hotels_checkbox').is(':checked')) {
        $('.show_field_days_in_hotels').each(function(){
            $(this).removeClass('hidden')
        });
    } else {
        $('.show_field_days_in_hotels').each(function(){
            $(this).addClass('hidden')
        });
    }

    $("input[type=checkbox]#is_active_travel_group").iCheck({
        checkboxClass: 'icheckbox_square-blue',
        radioClass: 'iradio_square-blue',
        increaseArea: '20%'
    });

    $("input[type=radio]").iCheck(({
        radioClass: 'iradio_square-blue'
    }));
});