$(document).on('ready', function(){
    var stick_to_body_select          = $('#stick_to_body_select'),
        step                          = $('#fields_for_page_enabled'),
        page_enabled_checkbox         = $('.page_enabled_checkbox'),
        radiobuttons                  = $('.attach_checkbox'),
        calendar_fields               = $('#calendar_row'),
        ind_or_group_switcher         = $('#onoffswitch');


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

    $(document).on('click', 'input[type="submit"]', function() {
        if ($(this).closest('form').validationEngine('validate') == true) {
            window.loading_screen = window.pleaseWait({
                backgroundColor: 'rgba(111, 111, 111, 0.60)',
                loadingHtml: '<div class="sk-fading-circle"><div class="sk-circle1 sk-circle"></div><div class="sk-circle2 sk-circle"></div><div class="sk-circle3 sk-circle"></div><div class="sk-circle4 sk-circle"></div><div class="sk-circle5 sk-circle"></div><div class="sk-circle6 sk-circle"></div><div class="sk-circle7 sk-circle"></div><div class="sk-circle8 sk-circle"></div><div class="sk-circle9 sk-circle"></div><div class="sk-circle10 sk-circle"></div><div class="sk-circle11 sk-circle"></div><div class="sk-circle12 sk-circle"></div></div>'
            });
        }
    });


    tinyMCE.init({
        selector: "textarea.editor",
        plugins: 'image textcolor link code advlist',
        toolbar: 'undo redo | bold italic | fontsizeselect | alignleft aligncenter alignright | link image | bullist numlist outdent indent | code | forecolor backcolor ',
        fontsize_formats: "6pt 7pt 8pt 9pt 10pt 11pt 12pt 13pt 14pt 15pt 16pt 18pt 22pt 26pt 30pt 36pt"
    });

    $('.popover-right').popover({placement: 'right'});
    $('.popover-bottom').popover({placement: 'bottom'});
    $('.popover-top').popover({placement: 'top'});
    $('.popover-left').popover({placement: 'left'});



    if (!page_enabled_checkbox.is(':checked'))
        step.hide();

    if ($('#show_field_days_in_hotels_checkbox').is(':checked')) {
        $('.show_field_days_in_hotels').each(function(){
            $(this).removeClass('hidden');
            $('.remove_tour_block').removeClass('col-md-offset-5').addClass('col-md-offset-3');
        });
    } else {
        $('.show_field_days_in_hotels').each(function(){
            $(this).addClass('hidden');
            $('.remove_tour_block').removeClass('col-md-offset-3').addClass('col-md-offset-5');
        });
    }
    if(ind_or_group_switcher.is(':checked')) {
        hideCalendar();
    } else {
        showCalendar();
    }

    if($('#special_tour_types').length > 0 && $('#special_tour_types')[0].value == 'Self Travel пример') {
        showCalendar();
    } else if($('#special_tour_types').length > 0 && $('#special_tour_types')[0].value != 'Self Travel пример') {
        hideCalendar()
    }


    $(document).on('change', '#special_tour_types', function() {
        if (this.value == 'Self Travel пример') {
            showCalendar();
        } else {
            hideCalendar();
        }
    });

    $(document).on('change', '.group_or_not_tour', function() {
        if (this.checked) {
            hideCalendar();
        } else {
            showCalendar();
        }
    });

    function showCalendar(){
        calendar_fields.slideDown('fast');
    }

    function hideCalendar(){
        calendar_fields.slideUp('fast');
    }

    $("input[type=checkbox]").not('#onoffswitch').not('#onoffswitch1').not('#onoffswitch2').iCheck({
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

    $(document).on('ifChanged', '#show_field_days_in_hotels_checkbox', function(){
        if(this.checked) {
            $('.show_field_days_in_hotels').each(function(){
                $(this).removeClass('hidden');
                $('.remove_tour_block').removeClass('col-md-offset-5').addClass('col-md-offset-3');
            });
        } else {
            $('.show_field_days_in_hotels').each(function(){
                $(this).addClass('hidden');
                $('.remove_tour_block').removeClass('col-md-offset-3').addClass('col-md-offset-5');
            });
        }
    });

    $('a.default_color').on('click', function(){
        var default_color = $(this).data('default');
        $(this).parent().parent().find('input.colorpicker').val(default_color).css('background-color', default_color, 'color', '#000');
    });

    $('.datepicker_start').datepicker({
        dateFormat: 'dd-mm-yy',
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
        dateFormat: 'dd-mm-yy'
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
               if(typeof this[0] != 'undefined' && value != ''  && this[0].id.indexOf(value) > -1) {
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
            if(typeof this[0] != 'undefined' && value != '' && this[0].id.indexOf(value) > -1) {
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
            if(typeof this[0] != 'undefined' && value != '' && this[0].id.indexOf(value) < 0) {
                $(this).find('select')[0].value = null
            }
        })
    });

});

$(document).on('nested:fieldAdded', function(event){
    var field           = event.field,
        textarea        = field.find('.tinyeditor')[0],
        boxes           = $("input[type=checkbox]").not('#onoffswitch').not('#onoffswitch1').not('#onoffswitch2'),
        radios          = $('.attach_checkbox');

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
        dateFormat: 'dd-mm-yy',
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
        dateFormat: 'dd-mm-yy'
    });

    if ($('#show_field_days_in_hotels_checkbox').is(':checked')) {

        $('.show_field_days_in_hotels').each(function(){
            $(this).removeClass('hidden');
            $('.remove_tour_block').removeClass('col-md-offset-5').addClass('col-md-offset-3');
        });
    } else {
        $('.show_field_days_in_hotels').each(function(){
            $(this).addClass('hidden');
            $('.remove_tour_block').removeClass('col-md-offset-3').addClass('col-md-offset-5');
        });
    }

    $.each(radios, function(){
        if($(this).is(':checked')){
            var page_fields = $(this).closest('.fields').find('#page_fields'),
                country_fields = $(this).closest('.fields').find('#country_fields'),
                category_fields = $(this).closest('.fields').find('#category_fields'),
                tour_fields = $(this).closest('.fields').find('#tour_fields'),
                ar = [page_fields, tour_fields, category_fields, country_fields],
                value = this.value;
            $.each(ar, function(){
                if(typeof this[0] != 'undefined' && value != ''  && this[0].id.indexOf(value) > -1) {
                    this.removeClass('hidden');
                } else {
                    this.addClass('hidden');
                }
            });
        }
    });

    boxes.iCheck({
        checkboxClass: 'icheckbox_square-blue',
        increaseArea: '20%'
    });

    $("input[type=radio]").iCheck(({
        radioClass: 'iradio_square-blue'
    }));
});













