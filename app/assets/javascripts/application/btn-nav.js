/**
 * Dropdown navigation jQuery plugin
 *
 * @link http://www.monosolutions.com
 * @copyright mono solutions 2014
 */
$(document).on('ready', function(){
    (function($, Modernizr, undefined) {
        "use strict";
        var NavDropdown = function(element, options) {
            var defaults = {
                items: undefined,
                top: undefined,
                onToggle: undefined
            };
            this.options = $.extend({}, defaults, options);
            this.$element = $(element);
            this.$nav = undefined;
            if (this.options.items) {
                this.init()
            }
        };
        NavDropdown.prototype = {
            init: function() {
                var self = this,
                    clickEvents = ["click"];
                self.appendNav();
                self.$element.on(clickEvents.join(" "), function(e) {
                    if (clickEvents.length > 1 && e.type === "click") {
                        e.preventDefault();
                        return
                    }
                    if (self.options.top) {
                        self.$nav[0].style.top = self.options.top.height() + "px"
                    }
                    self.$nav.toggleClass("hidden");
                    if (self.options.onToggle) {
                        self.options.onToggle.call(self)
                    }
                    e.preventDefault()
                });
                self.$nav.on(clickEvents.join(" "), "li:has(ul) a .arrow", function(e) {
                    if (clickEvents.length > 1 && e.type === "click") {
                        e.preventDefault();
                        return
                    }
                    var $a = $(this).parent();
                    $a.parent().toggleClass("active");
                    self.toggleArrow($a);
                    e.preventDefault()
                })
            },
            appendNav: function() {
                var self = this;
                self.$nav = $('<nav class="nav-dropdown hidden hidden-large">' + self.options.items.html() + "</nav>");
                self.$nav.find("li").has("ul").each(function() {
                    self.addArrow($(this))
                });
                self.$element.after(self.$nav)
            },
            addArrow: function($el) {
                var arrow = '<span class="arrow">' + ($el.hasClass("active") ? "▼" : "▶") + "</span>";
                $el.children("a").prepend(arrow)
            },
            toggleArrow: function($el) {
                var $arrow = $el.children(".arrow"),
                    arrow = $arrow.html() == "▶" ? "▼" : "▶";
                $arrow.html(arrow)
            }
        };
        $.fn.navDropdown = function(options) {
            return this.each(function() {
                if (!$.data(this, "navDropdown")) {
                    $.data(this, "navDropdown", new NavDropdown(this, options))
                }
            })
        };
        $(function() {
            var $btnNav = $('[data-bind~="toggle-btn-nav"]'),
                $btnLanguage = $('[data-bind~="toggle-btn-language"]');
            if ($btnNav.length) {
                var $navItems = $(".nav-primary").length ? $(".nav-primary").clone() : $(".nav-secondary").clone();
                $btnNav.navDropdown({
                    items: $navItems,
                    top: $(".header-container"),
                    onToggle: function() {
                        $(".nav-dropdown").not(this.$nav).addClass("hidden")
                    }
                })
            }
            if ($btnLanguage.length) {
                var $languageItems = $(".nav-language").clone();
                $languageItems.find(".hidden-small, .btn-language").remove();
                $btnLanguage.navDropdown({
                    items: $languageItems,
                    top: $(".header-container"),
                    onToggle: function() {
                        $(".nav-dropdown").not(this.$nav).addClass("hidden")
                    }
                })
            }
        })
    })(jQuery, Modernizr);
});
