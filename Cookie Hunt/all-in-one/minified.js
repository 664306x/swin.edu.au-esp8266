"use strict";function max_score(o){for(var e=0,t=0;o>t;t++)e+=Math.pow(2,t);return e}
function get_tally(o,e){for(var t=0,i=0;e>i;i++)Math.pow(2,i)&o&&t++;return t}
function split_cookie(){split_cookie={};var o,e;o=cookie.split("&");
for(var t=0;t<o.length;t++)e=o[t].split("="),split_cookie[e[0]]=e[1];return split_cookie}
function get_rating(o,e){var t,i=o/e;return.25>i?t="Prefer ice cream":.5>i?t="Connoisseur":.75>i?t="Aficionado":1>i?t="Maniac":1==i&&(t="Monster!"),t}
function write_page(o,e){var t=new Date,i=Math.pow(2,o),n=split_cookie(),r=(n.name,parseInt(n.score));t.setTime(parseInt(t.getTime()+COOKIE_LIFETIME)),r?i&r?(document.write("<h1>Welcome back</h1>"),
document.write("<p>You've already found this cookie. Keep looking for the rest!</p>")):(r+=i,
document.cookie="name=cookie_hunt&score="+r+"; expires="+t.toGMTString(),
document.write(r==max_score(e)?"<h1>Congratulations - you found all the cookies!</h1>":"<h1>You've found another cookie!</h1>")):(r=i,document.cookie="name=cookie_hunt&score="+r+"; expires="+t.toGMTString(),
document.write("<h1>You found your first cookie!</h1>"),
document.write("<p>Finish the game by collecting all the cookies</p>")),
document.write("<p>You've found "+get_tally(r,e)+" out of "+e+" cookies. Your cookie rating is: "+get_rating(get_tally(r,e),e)+"</p>")}
var station_id=0,cookie=document.cookie,total_stations=3,COOKIE_LIFETIME=864e5;window.onload=write_page(station_id,total_stations,cookie);