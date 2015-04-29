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