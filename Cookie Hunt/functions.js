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
    max_score = 0;
    for(var i = 0; i < total; i++)
        max_score += Math.pow(2, i);
    return max_score;
}

function calculate_tally(score, total_stations) {
    var cookies = 0;
    for(var i = 0; i < total_stations; i++) {
        if(Math.pow(2, i) & score)
            cookies++;
    }
    return cookies;
}

function split_cookie() {
    split_cookie = {};
    s1 = cookie.split("&");
    for(var i = 0; i < s1.length; i++) {
        s2 = s1[i].split("=");
        split_cookie[s2[0]]=s2[1];
    }
    return split_cookie;
}

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
    var station_score = Math.pow(2, station_id);
    if(cookie.length == 0) {
        var score = Math.pow(2, station_id);
        document.cookie = "name=cookie_hunt&score=" + score;
        document.write("<h1>You found your first cookie!</h1>");
        document.write("<p>Finish the game by collecting all the cookies</p>");
    }
    else {
        // Parse the cookie to get the score
        var cookie_data = split_cookie();
        cookie_name = cookie_data['name'];
        score = cookie_data['score'];
        // Check if this cookie has already been found
        if(station_score & score) {
            document.write("<h1>Welcome back</h1>");
            document.write("<p>You've already found this cookie. Keep looking for the rest!</p>");
        }
        // If not, add this cookie to the score
        else {
            document.cookie = "name=cookie_score&score=" + (score + station_score);
            // If all the cookies have been found, show the result
            if(score === max_score(total_stations)) {
                document.write("<h1>Congratulations - you found all the cookies!</h1>");
            }
            // Otherwise, show the new cookie found message
            else {
                document.write("<h1>You've found another cookie!</h1>");
            }
        }
    }
    var tally = calculate_tally(score, total_stations);
    // Show progress meter
    document.write("<p><meter>" + Math.round(100*tally/total_stations) + "%</meter></p>");
    // Animate meter
    
    // Show rating
    document.write("<p>Your rating is: " + get_rating(tally, total_stations) + "</p>");
}