/**
 *
 * Color picker
 * Author: Stefan Petre www.eyecon.ro
 * 
 * Dual licensed under the MIT and GPL licenses
 * 
 */
(function (d) {
  var q = function () {
    var v = 65,
        F = {
        eventName: "click",
        onShow: function () {},
        onBeforeShow: function () {},
        onHide: function () {},
        onChange: function () {},
        onSubmit: function () {},
        color: "ff0000",
        livePreview: true,
        flat: false
        },
        h = function (a, b) {
        var c = f(a);
        d(b).data("colorpicker").fields.eq(1).val(c.r).end().eq(2).val(c.g).end().eq(3).val(c.b).end()
        },
        m = function (a, b) {
        d(b).data("colorpicker").fields.eq(4).val(a.h).end().eq(5).val(a.s).end().eq(6).val(a.b).end()
        },
        j = function (a, b) {
        d(b).data("colorpicker").fields.eq(0).val(i(f(a))).end()
        },
        n = function (a, b) {
        d(b).data("colorpicker").selector.css("backgroundColor", "#" + i(f({
          h: a.h,
          s: 100,
          b: 100
        })));
        d(b).data("colorpicker").selectorIndic.css({
          left: parseInt(150 * a.s / 100, 10),
          top: parseInt(150 * (100 - a.b) / 100, 10)
        })
        },
        o = function (a, b) {
        d(b).data("colorpicker").hue.css("top", parseInt(150 - 150 * a.h / 360, 10))
        },
        r = function (a, b) {
        d(b).data("colorpicker").currentColor.css("backgroundColor", "#" + i(f(a)))
        },
        p = function (a, b) {
        d(b).data("colorpicker").newColor.css("backgroundColor", "#" + i(f(a)))
        },
        G = function (a) {
        a = a.charCode || a.keyCode || -1;
        if (a > v && a <= 90 || a == 32) return false;
        d(this).parent().parent().data("colorpicker").livePreview === true && k.apply(this)
        },
        k = function (a) {
        var b = d(this).parent().parent(),
            c;
        if (this.parentNode.className.indexOf("_hex") > 0) {
          c = b.data("colorpicker");
          var e = this.value,
              g = 6 - e.length;
          if (g > 0) {
            for (var s = [], w = 0; w < g; w++) s.push("0");
            s.push(e);
            e = s.join("")
          }
          e = l(t(e));
          c.color = c = e
        } else if (this.parentNode.className.indexOf("_hsb") > 0) b.data("colorpicker").color = c = u({
          h: parseInt(b.data("colorpicker").fields.eq(4).val(), 10),
          s: parseInt(b.data("colorpicker").fields.eq(5).val(), 10),
          b: parseInt(b.data("colorpicker").fields.eq(6).val(), 10)
        });
        else {
          c = b.data("colorpicker");
          e = {
            r: parseInt(b.data("colorpicker").fields.eq(1).val(), 10),
            g: parseInt(b.data("colorpicker").fields.eq(2).val(), 10),
            b: parseInt(b.data("colorpicker").fields.eq(3).val(), 10)
          };
          c.color = c = l({
            r: Math.min(255, Math.max(0, e.r)),
            g: Math.min(255, Math.max(0, e.g)),
            b: Math.min(255, Math.max(0, e.b))
          })
        }
        if (a) {
          h(c, b.get(0));
          j(c, b.get(0));
          m(c, b.get(0))
        }
        n(c, b.get(0));
        o(c, b.get(0));
        p(c, b.get(0));
        b.data("colorpicker").onChange.apply(b, [c, i(f(c)), f(c)])
        },
        H = function () {
        d(this).parent().parent().data("colorpicker").fields.parent().removeClass("colorpicker_focus")
        },
        I = function () {
        v = this.parentNode.className.indexOf("_hex") > 0 ? 70 : 65;
        d(this).parent().parent().data("colorpicker").fields.parent().removeClass("colorpicker_focus");
        d(this).parent().addClass("colorpicker_focus")
        },
        J = function (a) {
        var b = d(this).parent().find("input").focus();
        a = {
          el: d(this).parent().addClass("colorpicker_slider"),
          max: this.parentNode.className.indexOf("_hsb_h") > 0 ? 360 : this.parentNode.className.indexOf("_hsb") > 0 ? 100 : 255,
          y: a.pageY,
          field: b,
          val: parseInt(b.val(), 10),
          preview: d(this).parent().parent().data("colorpicker").livePreview
        };
        d(document).bind("mouseup", a, x);
        d(document).bind("mousemove", a, y)
        },
        y = function (a) {
        a.data.field.val(Math.max(0, Math.min(a.data.max, parseInt(a.data.val + a.pageY - a.data.y, 10))));
        a.data.preview && k.apply(a.data.field.get(0), [true]);
        return false
        },
        x = function (a) {
        k.apply(a.data.field.get(0), [true]);
        a.data.el.removeClass("colorpicker_slider").find("input").focus();
        d(document).unbind("mouseup", x);
        d(document).unbind("mousemove", y);
        return false
        },
        K = function () {
        var a = {
          cal: d(this).parent(),
          y: d(this).offset().top
        };
        a.preview = a.cal.data("colorpicker").livePreview;
        d(document).bind("mouseup", a, z);
        d(document).bind("mousemove", a, A)
        },
        A = function (a) {
        k.apply(a.data.cal.data("colorpicker").fields.eq(4).val(parseInt(360 * (150 - Math.max(0, Math.min(150, a.pageY - a.data.y))) / 150, 10)).get(0), [a.data.preview]);
        return false
        },
        z = function (a) {
        h(a.data.cal.data("colorpicker").color, a.data.cal.get(0));
        j(a.data.cal.data("colorpicker").color, a.data.cal.get(0));
        d(document).unbind("mouseup", z);
        d(document).unbind("mousemove", A);
        return false
        },
        L = function () {
        var a = {
          cal: d(this).parent(),
          pos: d(this).offset()
        };
        a.preview = a.cal.data("colorpicker").livePreview;
        d(document).bind("mouseup", a, B);
        d(document).bind("mousemove", a, C)
        },
        C = function (a) {
        k.apply(a.data.cal.data("colorpicker").fields.eq(6).val(parseInt(100 * (150 - Math.max(0, Math.min(150, a.pageY - a.data.pos.top))) / 150, 10)).end().eq(5).val(parseInt(100 * Math.max(0, Math.min(150, a.pageX - a.data.pos.left)) / 150, 10)).get(0), [a.data.preview]);
        return false
        },
        B = function (a) {
        h(a.data.cal.data("colorpicker").color, a.data.cal.get(0));
        j(a.data.cal.data("colorpicker").color, a.data.cal.get(0));
        d(document).unbind("mouseup", B);
        d(document).unbind("mousemove", C);
        return false
        },
        M = function () {
        d(this).addClass("colorpicker_focus")
        },
        N = function () {
        d(this).removeClass("colorpicker_focus")
        },
        O = function () {
        var a = d(this).parent(),
            b = a.data("colorpicker").color;
        a.data("colorpicker").origColor = b;
        r(b, a.get(0));
        a.data("colorpicker").onSubmit(b, i(f(b)), f(b), a.data("colorpicker").el)
        },
        E = function () {
        var a = d("#" + d(this).data("colorpickerId"));
        a.data("colorpicker").onBeforeShow.apply(this, [a.get(0)]);
        var b = d(this).offset(),
            c;
        c = document.compatMode == "CSS1Compat";
        c = {
          l: window.pageXOffset || (c ? document.documentElement.scrollLeft : document.body.scrollLeft),
          t: window.pageYOffset || (c ? document.documentElement.scrollTop : document.body.scrollTop),
          w: window.innerWidth || (c ? document.documentElement.clientWidth : document.body.clientWidth),
          h: window.innerHeight || (c ? document.documentElement.clientHeight : document.body.clientHeight)
        };
        var e = b.top + this.offsetHeight;
        b = b.left;
        if (e + 176 > c.t + c.h) e -= this.offsetHeight + 176;
        if (b + 356 > c.l + c.w) b -= 356;
        a.css({
          left: b + "px",
          top: e + "px"
        });
        a.data("colorpicker").onShow.apply(this, [a.get(0)]) != false && a.show();
        d(document).bind("mousedown", {
          cal: a
        }, D);
        return false
        },
        D = function (a) {
        if (!P(a.data.cal.get(0), a.target, a.data.cal.get(0))) {
          a.data.cal.data("colorpicker").onHide.apply(this, [a.data.cal.get(0)]) != false && a.data.cal.hide();
          d(document).unbind("mousedown", D)
        }
        },
        P = function (a, b, c) {
        if (a == b) return true;
        if (a.contains) return a.contains(b);
        if (a.compareDocumentPosition) return !!(a.compareDocumentPosition(b) & 16);
        for (b = b.parentNode; b && b != c;) {
          if (b == a) return true;
          b = b.parentNode
        }
        return false
        },
        u = function (a) {
        return {
          h: Math.min(360, Math.max(0, a.h)),
          s: Math.min(100, Math.max(0, a.s)),
          b: Math.min(100, Math.max(0, a.b))
        }
        },
        t = function (a) {
        a = parseInt(a.indexOf("#") > -1 ? a.substring(1) : a, 16);
        return {
          r: a >> 16,
          g: (a & 65280) >> 8,
          b: a & 255
        }
        },
        l = function (a) {
        var b = {
          h: 0,
          s: 0,
          b: 0
        },
            c = Math.max(a.r, a.g, a.b),
            e = c - Math.min(a.r, a.g, a.b);
        b.b = c;
        b.s = c != 0 ? 255 * e / c : 0;
        b.h = b.s != 0 ? a.r == c ? (a.g - a.b) / e : a.g == c ? 2 + (a.b - a.r) / e : 4 + (a.r - a.g) / e : -1;
        b.h *= 60;
        if (b.h < 0) b.h += 360;
        b.s *= 100 / 255;
        b.b *= 100 / 255;
        return b
        },
        f = function (a) {
        var b = {},
            c = Math.round(a.h),
            e = Math.round(a.s * 255 / 100);
        a = Math.round(a.b * 255 / 100);
        if (e == 0) b.r = b.g = b.b = a;
        else {
          e = (255 - e) * a / 255;
          var g = (a - e) * (c % 60) / 60;
          if (c == 360) c = 0;
          if (c < 60) {
            b.r = a;
            b.b = e;
            b.g = e + g
          } else if (c < 120) {
            b.g = a;
            b.b = e;
            b.r = a - g
          } else if (c < 180) {
            b.g = a;
            b.r = e;
            b.b = e + g
          } else if (c < 240) {
            b.b = a;
            b.r = e;
            b.g = a - g
          } else if (c < 300) {
            b.b = a;
            b.g = e;
            b.r = e + g
          } else if (c < 360) {
            b.r = a;
            b.g = e;
            b.b = a - g
          } else {
            b.r = 0;
            b.g = 0;
            b.b = 0
          }
        }
        return {
          r: Math.round(b.r),
          g: Math.round(b.g),
          b: Math.round(b.b)
        }
        },
        i = function (a) {
        var b = [a.r.toString(16), a.g.toString(16), a.b.toString(16)];
        d.each(b, function (c, e) {
          if (e.length == 1) b[c] = "0" + e
        });
        return b.join("")
        },
        Q = function () {
        var a = d(this).parent(),
            b = a.data("colorpicker").origColor;
        a.data("colorpicker").color = b;
        h(b, a.get(0));
        j(b, a.get(0));
        m(b, a.get(0));
        n(b, a.get(0));
        o(b, a.get(0));
        p(b, a.get(0))
        };
    return {
      init: function (a) {
        a = d.extend({}, F, a || {});
        if (typeof a.color == "string") a.color = l(t(a.color));
        else if (a.color.r != undefined && a.color.g != undefined && a.color.b != undefined) a.color = l(a.color);
        else if (a.color.h != undefined && a.color.s != undefined && a.color.b != undefined) a.color = u(a.color);
        else
        return this;
        return this.each(function () {
          if (!d(this).data("colorpickerId")) {
            var b = d.extend({}, a);
            b.origColor = a.color;
            var c = "collorpicker_" + parseInt(Math.random() * 1E3);
            d(this).data("colorpickerId", c);
            c = d('<div class="colorpicker"><div class="colorpicker_color"><div><div></div></div></div><div class="colorpicker_hue"><div></div></div><div class="colorpicker_new_color"></div><div class="colorpicker_current_color"></div><div class="colorpicker_hex"><input type="text" maxlength="6" size="6" /></div><div class="colorpicker_rgb_r colorpicker_field"><input type="text" maxlength="3" size="3" /><span></span></div><div class="colorpicker_rgb_g colorpicker_field"><input type="text" maxlength="3" size="3" /><span></span></div><div class="colorpicker_rgb_b colorpicker_field"><input type="text" maxlength="3" size="3" /><span></span></div><div class="colorpicker_hsb_h colorpicker_field"><input type="text" maxlength="3" size="3" /><span></span></div><div class="colorpicker_hsb_s colorpicker_field"><input type="text" maxlength="3" size="3" /><span></span></div><div class="colorpicker_hsb_b colorpicker_field"><input type="text" maxlength="3" size="3" /><span></span></div><div class="colorpicker_submit"></div></div>').attr("id", c);
            b.flat ? c.appendTo(this).show() : c.appendTo(document.body);
            b.fields = c.find("input").bind("keyup", G).bind("change", k).bind("blur", H).bind("focus", I);
            c.find("span").bind("mousedown", J).end().find(">div.colorpicker_current_color").bind("click", Q);
            b.selector = c.find("div.colorpicker_color").bind("mousedown", L);
            b.selectorIndic = b.selector.find("div div");
            b.el = this;
            b.hue = c.find("div.colorpicker_hue div");
            c.find("div.colorpicker_hue").bind("mousedown", K);
            b.newColor = c.find("div.colorpicker_new_color");
            b.currentColor =
            c.find("div.colorpicker_current_color");
            c.data("colorpicker", b);
            c.find("div.colorpicker_submit").bind("mouseenter", M).bind("mouseleave", N).bind("click", O);
            h(b.color, c.get(0));
            m(b.color, c.get(0));
            j(b.color, c.get(0));
            o(b.color, c.get(0));
            n(b.color, c.get(0));
            r(b.color, c.get(0));
            p(b.color, c.get(0));
            b.flat ? c.css({
              position: "relative",
              display: "block"
            }) : d(this).bind(b.eventName, E)
          }
        })
      },
      showPicker: function () {
        return this.each(function () {
          d(this).data("colorpickerId") && E.apply(this)
        })
      },
      hidePicker: function () {
        return this.each(function () {
          d(this).data("colorpickerId") && d("#" + d(this).data("colorpickerId")).hide()
        })
      },
      setColor: function (a) {
        if (typeof a == "string") a = l(t(a));
        else if (a.r != undefined && a.g != undefined && a.b != undefined) a = l(a);
        else if (a.h != undefined && a.s != undefined && a.b != undefined) a = u(a);
        else
        return this;
        return this.each(function () {
          if (d(this).data("colorpickerId")) {
            var b = d("#" + d(this).data("colorpickerId"));
            b.data("colorpicker").color = a;
            b.data("colorpicker").origColor = a;
            h(a, b.get(0));
            m(a, b.get(0));
            j(a, b.get(0));
            o(a, b.get(0));
            n(a, b.get(0));
            r(a, b.get(0));
            p(a, b.get(0))
          }
        })
      }
    }
  }();
  d.fn.extend({
    ColorPicker: q.init,
    ColorPickerHide: q.hidePicker,
    ColorPickerShow: q.showPicker,
    ColorPickerSetColor: q.setColor
  })
})(jQuery);