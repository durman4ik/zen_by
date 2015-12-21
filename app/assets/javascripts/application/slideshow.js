/**
 * Slideshow plugin for jQuery.
 *
 * Transitions are done using CSS3 with progressive fallback to jQuery fadeIn.
 *
 * @dependencies jQuery, Modernizr
 * @author Chiel Robben <chiel@pephers.org>
 * @url https://github.com/Pephers/Slideshow
 * @license MIT
 */
$(document).on('ready', function() {
    (function ($, Modernizr, window, undefined) {

        'use strict';

        /**
         * Constructor
         *
         * @param {object} element
         * @param {object} options
         */
        var Slideshow = function (element, options) {

            var defaults = {
                auto: true,
                interval: 5000,
                duration: 600,
                pause: true,
                minHeight: 0,
                zIndexOffset: 0,
                onInit: undefined,
                onLoad: undefined,
                onResize: undefined,
                onChange: undefined
            };

            this.$element = $(element);
            this.$window = $(window);
            this.$slides = this.$element.children();
            this.isRunning = undefined;
            this.slideCount = this.$slides.length - 1;
            this.currentSlide = 0;
            this.height = 0;
            this.width = 0;
            this.fontSize = undefined;
            this.options = $.extend({}, defaults, options);

            this.init();

        };

        Slideshow.prototype = {

            /**
             * Initialize the slideshow
             */
            init: function () {

                var self = this,
                    img = self.$slides[self.currentSlide].getElementsByTagName('img')[0];

                // Hide all images but the first one
                if (Modernizr.csstransitions) {
                    self.$slides.eq(self.currentSlide).addClass('slide-active');
                } else {

                    self.$slides.css(
                        'zIndex',
                        self.options.zIndexOffset + 1
                    ).hide().eq(self.currentSlide).css(
                        'zIndex',
                        self.options.zIndexOffset + 2
                    ).show();

                }

                // Start the slideshow on load
                self.$window.on('load', function () {

                    self.$element.addClass('slideshow-ready');
                    self.setHeight();
                    self.setWidth();
                    self.setFontSize();

                    if (self.slideCount > 0) {
                        self.start();
                    }

                    if (self.options.onLoad) {
                        self.options.onLoad.call(self);
                    }

                });

                // Set height of the slideshow when window is resized
                self.$window.on('resize', function () {

                    self.setHeight();
                    self.setWidth();
                    self.setFontSize();
                    setTimeout(function () {
                        self.setHeight();
                    }, 70);
                    if (self.options.onResize) {
                        self.options.onResize.call(self);
                    }

                });

                if (img.complete) {

                    self.setHeight();
                    self.setWidth();
                    self.setFontSize();

                }

                // Pause slideshow when the mouse cursor is hovering
                if (!Modernizr.touch && self.options.pause && self.slideCount > 0) {

                    self.$element.on({

                        mouseenter: function (e) {
                            self.stop();
                        },

                        mouseleave: function (e) {
                            self.start();
                        }

                    });

                }

                if (self.options.onInit) {
                    self.options.onInit.call(self);
                }

            },

            /**
             * Start the slideshow
             */
            start: function () {

                var self = this;

                // Prevent multiple timers from running at once
                if (self.isRunning) {
                    clearInterval(self.isRunning);
                }

                if (self.options.auto) {

                    self.isRunning = setInterval(function () {
                        self.nextSlide();
                    }, self.options.interval);

                }

            },

            /**
             * Stop the slideshow
             */
            stop: function () {
                clearInterval(this.isRunning);
                this.isRunning = undefined;
            },

            /**
             * Slide to the next image
             */
            nextSlide: function () {

                var slide = this.currentSlide === this.slideCount ? 0 : this.currentSlide + 1;

                this.changeSlide(slide);

            },

            /**
             * Slide to the previous image
             */
            previousSlide: function () {

                var slide = this.currentSlide === 0 ? this.slideCount : this.currentSlide - 1;

                this.changeSlide(slide);

            },

            /**
             * Change to the slide specified.
             *
             * @param {int} slide
             */
            changeSlide: function (slide) {

                var self = this,
                    previousSlide = slide > self.slideCount ? (self.slideCount - 1) : (slide <= 0 ? self.slideCount : (slide - 1));

                self.currentSlide = slide;

                if (Modernizr.csstransitions) {
                    self.$slides.removeClass('slide-active').eq(self.currentSlide).addClass('slide-active');
                } else {

                    self.$slides.css(
                        'zIndex',
                        self.options.zIndexOffset + 1
                    ).eq(self.currentSlide).css(
                        'zIndex',
                        self.options.zIndexOffset + 2
                    ).fadeIn(self.options.duration, function () {
                            self.$slides.eq(previousSlide).hide();
                        });

                }

                self.setFontSize();

                if (self.options.onChange) {
                    self.options.onChange.call(self);
                }

            },

            /**
             * Set an option after the plugin has been initialized
             *
             * @param {string} key
             * @param {mixed}  value
             */
            setOption: function (key, value) {
                this.options[key] = value;
            },

            /**
             * Set height of the slideshow container
             */
            setHeight: function () {

                this.$element[0].style.height = 'auto';

                this.height = Math.max(this.$slides.eq(0).outerHeight(true), this.options.minHeight);

                this.$element[0].style.height = this.height + 'px';

            },

            /**
             * Set the width of the slideshow if items inside exceed the height
             */
            setWidth: function () {

                if (!this.options.minHeight) {
                    return;
                }

                if (!this.width) {
                    this.width = this.$element.width();
                }

                this.$element[0].style.marginLeft = 0;
                this.$element[0].style.marginRight = 0;

                var ratio = this.options.minHeight / this.$slides.eq(0).outerHeight(true);

                if (ratio > 1) {

                    var newWidth = this.width * ratio,
                        negativeLeftRight = (this.width * (ratio - 1) / 2) * -1;

                    this.$element[0].style.marginLeft = negativeLeftRight + 'px';
                    this.$element[0].style.marginRight = negativeLeftRight + 'px';

                }

            },

            /**
             * Set the font-size of the display text inside the module
             */
            setFontSize: function () {

                var $figcaptionInner = this.$slides.eq(this.currentSlide).find('.figcaption-inner'),
                    $figcaption = $figcaptionInner.find('figcaption'),
                    $btn = $figcaptionInner.find('.btn'),
                    figcapt = this.$slides.find('figcaption'),
                    slideNr = this.currentSlide,
                    ratio = 1;

                if (!$figcaptionInner || !$figcaption) {
                    return;
                }

                if (!figcapt[slideNr].fontSize) {
                    figcapt[slideNr].fontSize = parseFloat(figcapt[slideNr].style.fontSize);
                }
                // Reset font-size and get the height
                figcapt[slideNr].style.fontSize = figcapt[slideNr].fontSize + 'em';

                var height = $figcaptionInner.outerHeight(true) + ($btn.outerHeight(true) || 0);

                if (this.height) {
                    ratio = this.height / height;
                }

                if (ratio <= 1) {

                    var newFontSize = figcapt[slideNr].fontSize * ratio;

                    // If the font-size is lower than 1, set the line-height of the parent
                    $figcaptionInner[0].style.lineHeight = newFontSize < 1 ? newFontSize : '';
                    figcapt[slideNr].style.fontSize = newFontSize + 'em';

                }
            }

        };

        /**
         * Expose as jQuery plugin in Singleton fashion so it can only be
         * initialized once per element.
         */
        $.fn.slideshow = function (options) {

            return this.each(function () {

                if (!$.data(this, 'slideshow')) {
                    $.data(this, 'slideshow', new Slideshow(this, options));
                }

            });

        };

    })(jQuery, Modernizr, window);
});