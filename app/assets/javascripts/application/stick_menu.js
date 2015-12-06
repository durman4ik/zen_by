$(document).on('ready', function() {
    var start_pos=$('#stick_menu').offset().top;
    $(window).scroll(function(){
        if ($(window).scrollTop()>=start_pos) {
            if ($('#stick_menu').hasClass()==false) $('#stick_menu').addClass('to_top');
        }
        else $('#stick_menu').removeClass('to_top');
    });

    $(document).on("scroll", onScroll);

    function onScroll(event){
        var scrollPos = $(document).scrollTop();
        $('#stick_menu a').each(function () {
            var currLink = $(this);
            var refElement = $(currLink.attr("href"));
            if (refElement.position().top <= scrollPos+100 && refElement.position().top + refElement.height() > scrollPos) {
                $('#stick_menu ul li a').removeClass("active");
                currLink.addClass("active");
            }
            else{
                currLink.removeClass("active");
            }
        });
    }

    //smoothscroll
    $('a.tdd[href^="#"]').on('click', function (e) {
        e.preventDefault();
        $(document).off("scroll");

        $('a').each(function () {
            $(this).removeClass('active');
        });
        $(this).addClass('active');

        var target = this.hash,
            menu = target;
        $target = $(target);
        $('html, body').stop().animate({
            'scrollTop': $target.offset().top - 60
        }, 1000, 'swing', function () {
            window.location.hash = target;
            $(document).on("scroll", onScroll);
        });
    });
});
