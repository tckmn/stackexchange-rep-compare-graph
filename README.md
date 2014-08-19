stackexchange-rep-compare-graph
===============================

Renders a fancy graph of different users' reputations on a certain site.

Sample run (to compare the current top 5 users of Programming Puzzles & Code Golf):

    users = [
        [281244, 'Howard'],
        [1266491, 'Doorknob'],
        [375332, 'marinus'],
        [278703, 'Peter Taylor'],
        [1793115, 'Martin Buttner']
    ]
    site = 'Programming Puzzles & Code Golf'
    puts 'Paste the following code in your JavaScript console of any SE user\'s rep graph page' +
        ' (for example, http://stackexchange.com/users/1266491/doorknob?tab=reputation):'
    puts RepCompareGraph.rep_compare_graph users, site
    puts "$('.reputation-accounts-container').remove();"
    
![](http://i.imgur.com/sHD2xfp.png)
