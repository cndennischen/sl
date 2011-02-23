/* 
 * JQuery CSS Rotate property using CSS3 Transformations
 * Copyright (c) 2011 Jakub Jankiewicz  <http://jcubic.pl>
 * licensed under the LGPL Version 3 license.
 * http://www.gnu.org/licenses/lgpl.html
 */
(function(d){function e(a){for(var b=["transform","WebkitTransform","MozTransform","msTransform","OTransform"],c;c=b.shift();)if(a.style[c]!==undefined)return c;return false}d.cssHooks.rotate={get:function(a){var b=e(a);return b?a.style[b].replace(/.*rotate\((.*)deg\).*/,"$1"):""},set:function(a,b){var c=e(a);if(c){b=parseInt(b);d(a).data("rotatation",b);a.style[c]=b==0?"":"rotate("+b%360+"deg)"}else return""}};d.fx.step.rotate=function(a){d.cssHooks.rotate.set(a.elem,a.now)}})(jQuery);
