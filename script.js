ACHIEVEMENTS = {
    "award_boss1": ["The Beginning", 100, "Defeat the first boss."],
    "award_boss2": ["The Hunter", 100, "Defeat the second boss."],
    "award_boss3": ["The Prey", 100, "Defeat the third boss."],
    "award_boss4": ["The Revelation", 100, "Defeat the fourth boss."],
    "award_boss5": ["The Conclusion", 150, "Defeat the final boss."],
    "award_opp": ["Illustrated Handbook of PET", 150, "See each type of monster at least once."],
    "award_100": ["Strong and healthy", 100, "Have Pikachu reach 100 health."],
    "award_emp": ["Come at me scrublord, I'm ripped", 100, "Use a Daredevil Potion to empower a boss."],
    "award_quick": ["Fools Events Done Quick", 100, "Defeat the last boss in under an hour."],
    "award_hax1": ["Far Lands", 50, "Complete the first hacking challenge."],
    "award_hax2": ["YEDONG'S TAIL", 50, "Complete the second hacking challenge."],
    "award_hax3": ["Worry Seed", 100, "Complete the third hacking challenge."],
    "award_hax4": ["Real ACE hours", 137, "Complete the last hacking challenge."],
    "award_hax4_pending": ["Real ACE hours (pending)", 137, "This user has sent their submission for the fourth hacking challenge."],
    "award_wholesome": ["Wholesome Award", 1, "Sell your soul to the Pay-To-Win Gods and donate at least $2.00."]
};

function updateAchievementTooltips(){
    for (award in ACHIEVEMENTS) {
        $('.' + award).each(function(a, e){
            var ac = ACHIEVEMENTS[award];
            e.title = "<b class='tooltip-name'>" + ac[0] + "</b><br><span class='tooltip-points'>" + ac[1] + " points</span><br><span class='tooltip-desc'>" + ac[2] + "</span>";
            $(e).tooltip({html: true});
            e.title = '';
        });
    }
}

function formatTimeDiff(diff){
    var time_split = [];
    time_split.push(diff % 60);
    diff = Math.floor(diff / 60);
    time_split.push(diff % 60);
    diff = Math.floor(diff / 60);
    time_split.push(diff % 24);
    diff = Math.floor(diff / 24);
    time_split.push(diff);
    time_split.reverse();
    var suffixes = ["days", "hours", "minutes", "seconds"];
    for (var i=0; i<suffixes.length; i++){
        suffixes[i] = time_split[i] + " " + suffixes[i];
        // if (time_split[i] == 0) suffixes.splice(i, 1);
    }
    return suffixes.join(", ");
}

function updateTimers(){
    var now = parseInt(+new Date() / 1000);
    var untilEventEnd = 1618495200 - now;
    if (untilEventEnd > 0){
        $('#countdown').html(formatTimeDiff(untilEventEnd) + " until the end of the event.");
    }else{
        $('#countdown').html("The event has ended. Thanks for participating!");
    }
}

$(document).ready(function(){
    updateTimers();
    updateAchievementTooltips();
    setInterval(updateTimers, 1000);
});