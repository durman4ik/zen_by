/**
 * Slider jQuery plugin
 *
 * @link http://www.monosolutions.com
 * @copyright mono solutions 2014
 */
$(document).on('ready', function() {
    (function ($, Modernizr, document, undefined) {
        "use strict";
        var Slider = function (element, options) {
            var defaults = {
                container: ".slide-container",
                slides: ".slide",
                previous: '[data-bind~="previous-slide"]',
                next: '[data-bind~="next-slide"]',
                index: undefined,
                speed: 300,
                auto: false,
                interval: 5e3,
                pause: true,
                keyboard: false,
                onInit: undefined,
                onChange: undefined
            };
            this.options = $.extend({}, defaults, options);
            this.$element = $(element);
            this.$window = $(window);
            this.$container = this.$element.find(this.options.container);
            this.$slides = this.$element.find(this.options.slides);
            this.slideCount = this.$slides.length - 1;
            this.currentSlide = 0;
            this.currentOffset = 0;
            this.offsetMethod = undefined;
            this.transitionMethod = undefined;
            this.setOffset = undefined;
            this.setTransition = undefined;
            this.animating = undefined;
            this.$btnPrevious = this.$element.find(this.options.previous);
            this.$btnNext = this.$element.find(this.options.next);
            this.clickEvent = "click";
            if (this.slideCount > 0) {
                this.init()
            }
        };
        Slider.prototype = {
            init: function () {
                var self = this;
                if (Modernizr.touch) {
                    self.clickEvent = "tap"
                }
                self.setOffsetMethod();
                self.setTransitionMethod();
                if (self.options.index !== undefined) {
                    self.changeSlide(self.options.index, false)
                }
                if (self.clickEvent == "tap") {
                    self.$btnPrevious.on("click", function (e) {
                        self.previousSlide();
                        e.stopPropagation();
                        e.preventDefault()
                    });
                    self.$btnNext.on("click", function (e) {
                        self.nextSlide();
                        e.stopPropagation();
                        e.preventDefault()
                    })
                }
                self.$btnPrevious.on(self.clickEvent, function (e) {
                    self.previousSlide();
                    e.stopPropagation();
                    e.preventDefault()
                });
                self.$btnNext.on(self.clickEvent, function (e) {
                    self.nextSlide();
                    e.stopPropagation();
                    e.preventDefault()
                });
                self.$element.on("quickswiperight", function (e) {
                    self.previousSlide(false)
                });
                self.$element.on("quickswipeleft", function (e) {
                    self.nextSlide(false)
                });
                self.$element.on("swipe", function (e) {
                    var offset = e.direction == "left" ? self.currentOffset - e.delta.x : self.currentOffset + e.delta.x;
                    self.setOffset(self.$container, offset + "px")
                });
                self.$element.on("swipeleft", function (e) {
                    if (e.delta.x > self.$slides.width() / 2) {
                        self.nextSlide(false)
                    } else {
                        self.changeSlide(self.currentSlide)
                    }
                });
                self.$element.on("swiperight", function (e) {
                    if (e.delta.x > self.$slides.width() / 2) {
                        self.previousSlide(false)
                    } else {
                        self.changeSlide(self.currentSlide)
                    }
                });
                if (self.options.keyboard) {
                    $(document).on("keydown", function (e) {
                        switch (e.keyCode) {
                            case 37:
                                self.previousSlide();
                                break;
                            case 39:
                                self.nextSlide();
                                break
                        }
                    })
                }
                if (!Modernizr.touch && self.options.auto && self.options.pause) {
                    self.$element.on({
                        mouseenter: $.proxy(self.stop, self),
                        mouseleave: $.proxy(self.start, self)
                    })
                }
                self.$element.addClass("slider-ready");
                self.$window.on("load", function () {
                    if (self.options.auto) {
                        self.start()
                    }
                });
                self.$window.on("resize", function () {
                    self.changeSlide(self.currentSlide, false)
                });
                if (self.options.onInit) {
                    self.options.onInit.call(self)
                }
            },
            previousSlide: function (rotate) {
                if (rotate === undefined) {
                    rotate = true
                }
                var slide = this.currentSlide === 0 ? rotate ? this.slideCount : 0 : this.currentSlide - 1;
                if (this.options.auto) {
                    this.start()
                }
                this.changeSlide(slide)
            },
            nextSlide: function (rotate) {
                if (rotate === undefined) {
                    rotate = true
                }
                var slide = this.currentSlide === this.slideCount ? rotate ? 0 : this.slideCount : this.currentSlide + 1;
                if (this.options.auto) {
                    this.start()
                }
                this.changeSlide(slide)
            },
            changeSlide: function (slide, animate) {
                if (animate === undefined) {
                    animate = true
                }
                var self = this;
                self.currentSlide = slide;
                self.currentOffset = self.$slides.outerWidth(true) * self.currentSlide * -1;
                if (animate) {
                    if (self.setTransition) {
                        self.setTransition(self.$container, self.options.speed)
                    }
                    if (self.animating) {
                        clearTimeout(self.animating)
                    }
                    self.animating = setTimeout(function () {
                        self.animating = undefined;
                        if (self.setTransition) {
                            self.setTransition(self.$container, 0)
                        }
                        if (self.options.onChange) {
                            self.options.onChange.call(self)
                        }
                    }, self.options.speed)
                } else if (self.options.onChange) {
                    self.options.onChange.call(self)
                }
                self.setOffset(self.$container, self.currentOffset + "px")
            },
            start: function () {
                var self = this;
                if (self.isRunning) {
                    clearInterval(self.isRunning)
                }
                if (self.options.auto) {
                    self.isRunning = setInterval(function () {
                        self.nextSlide()
                    }, self.options.interval)
                }
            },
            stop: function () {
                clearInterval(this.isRunning);
                this.isRunning = undefined
            },
            setOffsetMethod: function () {
                var self = this;
                self.setOffset = function () {
                    self.offsetMethod = "left";
                    if (Modernizr.csstransforms3d) {
                        self.offsetMethod = Modernizr.prefixed("transform");
                        return function ($el, offset) {
                            $el[0].style[self.offsetMethod] = "translate3d(" + offset + ", 0px, 0px)"
                        }
                    } else if (Modernizr.csstransforms) {
                        self.offsetMethod = Modernizr.prefixed("transform");
                        return function ($el, offset) {
                            $el[0].style[self.offsetMethod] = "translate(" + offset + ", 0px)"
                        }
                    }
                    return function ($el, offset) {
                        $el[0].style[self.offsetMethod] = offset
                    }
                }()
            },
            setTransitionMethod: function () {
                var self = this;
                self.setTransition = function () {
                    if (Modernizr.csstransitions) {
                        self.transitionMethod = Modernizr.prefixed("transition");
                        return function ($el, speed) {
                            $el[0].style[self.transitionMethod] = "all " + speed + "ms ease-in-out"
                        }
                    }
                    return false
                }()
            }
        };
        $.fn.slider = function (options) {
            return this.each(function () {
                if (!$.data(this, "slider")) {
                    $.data(this, "slider", new Slider(this, options))
                }
            })
        };
        $(function () {
            var $slider = $('[data-bind~="slider"]'),
                $carousel = $('[data-bind~="carousel"]');
            if ($slider.length) {
                $slider.slider({
                    onChange: function () {
                        this.$element.find(".page-indication li").removeClass("active").eq(this.currentSlide).addClass("active")
                    }
                })
            }
            $carousel.each(function () {
                var $this = $(this);
                $this.slider({
                    auto: true,
                    interval: ~~$this.data("sliderInterval"),
                    pause: !!$this.data("sliderPause"),
                    onChange: function () {
                        this.$element.find(".carousel-indicators li").removeClass("active").eq(this.currentSlide).addClass("active")
                    }
                })
            })
        })
    })(jQuery, Modernizr, document);
});