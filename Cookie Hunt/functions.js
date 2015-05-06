"use strict";
var total_stations = 3; // Change to however many stations you desire.
var COOKIE_LIFETIME = 3600 * 24 * 1000; // = 24 hours in milliseconds

/* Function to calculate max score
 * The score is a bit register:
 * - game progress is represented by no. of on bits, NOT the size of 
 *  the score (eg. 127 is much better than 128)
 * - the score for each station found is represented by 2 to the 
 *  power of station_id
 * - Whether a station has been found or not can be determined by 
 *  <score for station> & <current score>
 *  (where & is the binary AND operation)
 */
function max_score(total) {
    var max_score = 0;
    for(var i = 0; i < total; i++)
        max_score += Math.pow(2, i);
    return max_score;
}

/* Get the number of stations found */
function get_tally(score, total_stations) {
    var cookies = 0;
    for(var i = 0; i < total_stations; i++) {
        if(Math.pow(2, i) & score)
            cookies++;
    }
    return cookies;
}

/* Parse the cookie into a 2D array
 * Assumes tuples separated by '&',key + value separated by '='
 */
function split_cookie() {
    split_cookie = {};
    var s1, s2;
    s1 = cookie.split("&");
    for(var i = 0; i < s1.length; i++) {
        s2 = s1[i].split("=");
        split_cookie[s2[0] ]=s2[1];
    }
    return split_cookie;
}

/* Returns a rating (string) of current progress */
function get_rating(tally, total_stations) {
    var rating;
    var progress = tally / total_stations;
    if(progress < 0.25)
        rating = "Prefer ice cream";
    else if(progress < 0.5)
        rating = "Connoisseur";
    else if(progress < 0.75)
        rating = "Aficionado";
    else if(progress < 1)
        rating = "Maniac";
    else if(progress == 1)
        rating = "Monster!";
    return rating;
}

function write_page(station_id, total_stations, cookie) {
    var expiration_date = new Date();
    var station_score = Math.pow(2, station_id);
    // Parse the cookie to get the score
    var cookie_data = split_cookie();
    var cookie_name = cookie_data['name'];
    var score = parseInt(cookie_data['score']);
    // Cookie will be set to expire 24 hours from last access
    expiration_date.setTime(parseInt(expiration_date.getTime() + COOKIE_LIFETIME));
    if(!score) {
        score = station_score;
        document.cookie = "name=cookie_hunt&score=" + score + "; expires=" + expiration_date.toGMTString();
        document.write("<h1>You found your first cookie!</h1>");
        document.write("<p>Finish the game by collecting all the cookies</p>");
    }
    else {
        
        // Check if this cookie has already been found
        if(station_score & score) {
            document.write("<h1>Welcome back</h1>");
            document.write("<p>You've already found this cookie. Keep looking for the rest!</p>");
        }
        // If not, add this station_score to the score
        else {
            score += station_score;
            document.cookie = "name=cookie_hunt&score=" + score + "; expires=" + expiration_date.toGMTString();
            // If all the cookies have been found, show the result
            if(score == max_score(total_stations)) {
                document.write("<h1>Congratulations - you found all the cookies!</h1>");
            }
            // Otherwise, show the new cookie found message
            else {
                document.write("<h1>You've found another cookie!</h1>");
            }
        }
    }
    document.write("<p>You've found " + get_tally(score, total_stations) + " out of " + total_stations + " cookies. Your cookie rating is: " + get_rating(get_tally(score,total_stations), total_stations) + "</p>");
}
window.onload = write_page(station_id, total_stations, cookie);