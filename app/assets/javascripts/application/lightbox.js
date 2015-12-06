/**
 * Lightbox jQuery plugin
 *
 * @link http://www.monosolutions.com
 * @copyright mono solutions 2014
 */
$(document).on('ready', function() {
    (function ($, Modernizr, document, window, undefined) {
        "use strict";
        var Lightbox = function (element, options) {
            var defaults = {};
            this.options = $.extend({}, defaults, options);
            this.$element = $(element);
            this.$window = $(window);
            this.$body = $(document.body);
            this.$backdrop = undefined;
            this.$lightbox = undefined;
            this.$loader = undefined;
            this.$ui = undefined;
            this.$btnClose = undefined;
            this.loading = undefined;
            this.slides = [];
            this.slideCount = 0;
            this.aspectRatio = undefined;
            this.clickEvent = "click";
            this.init()
        };
        Lightbox.prototype = {
            init: function () {
                var self = this,
                    $anchors = self.$element.find("a").has("img");
                if (Modernizr.touch) {
                    self.clickEvent = "tap"
                }
                $anchors.each(function () {
                    var img = $(this).find("img")[0];
                    self.slides.push({
                        src: "data:image/gif;base64,R0lGODlhAQABAAD/ACwAAAAAAQABAAACADs%3D",
                        fullSrc: this.href,
                        caption: this.title,
                        orientation: ""
                    })
                });
                self.slideCount = self.slides.length - 1;
                self.$element.on(self.clickEvent, "a:has(img)", function (e) {
                    for (var i = 0; i < self.slideCount; i++) {
                        if (self.slides[i].fullSrc === this.href) {
                            break
                        }
                    }
                    self.open(i);
                    e.preventDefault()
                });
                self.buildHTML();
                self.$window.on("load", function () {
                    self.setImageAspectRatio();
                    self.setImageClasses()
                })
            },
            open: function (index) {
                var self = this;
                self.$body.addClass("hide-overflow");
                self.$body.append(self.$backdrop);
                self.$body.append(self.$lightbox);
                self.$lightbox.slider({
                    container: ".lightbox-container",
                    slides: ".lightbox-image",
                    previous: ".prev",
                    next: ".next",
                    index: index,
                    keyboard: !Modernizr.touch,
                    onChange: function () {
                        self.loadImage(this.currentSlide)
                    }
                });
                self.loadImage(index);
                self.setAspectRatio();
                self.setImageClasses();
                self.$btnClose.on(self.clickEvent, function (e) {
                    self.close();
                    e.stopPropagation();
                    e.preventDefault()
                });
                if (Modernizr.touch) {
                    self.$ui.addClass("hidden-small");
                    self.$lightbox.on(self.clickEvent, function (e) {
                        self.$ui.toggleClass("hidden-small")
                    })
                } else {
                    $(document).on("keydown", function (e) {
                        if (e.keyCode === 27) {
                            self.close();
                            e.preventDefault()
                        }
                    })
                }
                self.$window.on("resize", $.proxy(self.setAspectRatio, self));
                self.$window.on("resize", $.proxy(self.setImageClasses, self))
            },
            close: function () {
                this.$backdrop.remove();
                this.$lightbox.remove();
                this.$body.removeClass("hide-overflow");
                this.$window.off("resize", $.proxy(self.setAspectRatio, self));
                this.$window.off("resize", $.proxy(self.setImageClasses, self))
            },
            buildHTML: function () {
                var self = this,
                    slides = "";
                for (var i = 0; i < self.slideCount + 1; i++) {
                    slides += '<div class="lightbox-image">';
                    slides += '<img src="' + self.slides[i].src + '" alt="">';
                    slides += '<div class="lightbox-caption">' + self.slides[i].caption + "</div>";
                    slides += "</div>"
                }
                self.$backdrop = $('<div class="lightbox-backdrop"></div>');
                self.$lightbox = $('<div class="lightbox"><div class="lightbox-container">' + slides + "</div></div>");
                self.$loader = $('<div class="lightbox-loading hidden"></div>');
                self.$ui = $('<div class="lightbox-ui"></div>');
                self.$btnClose = $('<a class="close" href="#"></a>');
                self.$lightbox.append(self.$loader);
                self.$lightbox.append(self.$ui);
                self.$ui.append(self.$btnClose);
                if (self.slideCount > 0) {
                    self.$ui.append($('<a class="prev" href="#"></a><a class="next" href="#"></a>'))
                }
            },
            startLoader: function () {
                var self = this,
                    y = 0;
                if (self.loading) {
                    return
                }
                self.loading = setInterval(function () {
                    y = y > -352 ? y - 32 : 0;
                    self.$loader[0].style.backgroundPosition = "0 " + y + "px"
                }, 100);
                self.$loader.removeClass("hidden")
            },
            stopLoader: function () {
                this.$loader.addClass("hidden");
                clearInterval(this.loading);
                this.loading = undefined
            },
            loadImage: function (index) {
                var self = this,
                    $slide = self.$lightbox.find(".lightbox-image").eq(index),
                    img = $slide.find("img")[0];
                if (img.src === self.slides[index].fullSrc) {
                    $slide.addClass("lightbox-image-loaded");
                    return
                }
                self.startLoader();
                $("<img>").attr("src", self.slides[index].fullSrc).on("load", function () {
                    if (this.src === self.slides[index].fullSrc) {
                        $slide.addClass("lightbox-image-loaded");
                        img.src = self.slides[index].fullSrc;
                        self.stopLoader()
                    }
                })
            },
            setAspectRatio: function () {
                this.aspectRatio = this.$lightbox.width() / this.$lightbox.height()
            },
            setImageAspectRatio: function () {
                for (var i = 0; i < this.slideCount; i++) {
                    var $img = this.$element.find("img").eq(i);
                    this.slides[i].aspectRatio = $img.width() / $img.height()
                }
            },
            setImageClasses: function () {
                var className, previousClassName;
                for (var i = 0; i < this.slideCount + 1; i++) {
                    className = this.aspectRatio > this.slides[i].aspectRatio ? "lightbox-image-tall" : "lightbox-image-wide";
                    previousClassName = className === "lightbox-image-wide" ? "lightbox-image-tall" : "lightbox-image-wide";
                    this.$lightbox.find(".lightbox-image").eq(i).removeClass(previousClassName).addClass(className)
                }
            }
        };
        $.fn.lightbox = function (options) {
            return this.each(function () {
                if (!$.data(this, "lightbox")) {
                    $.data(this, "lightbox", new Lightbox(this, options))
                }
            })
        };
        $(function () {
            $('[data-bind~="lightbox"]').lightbox()
        })
    })(jQuery, Modernizr, document, window);
});