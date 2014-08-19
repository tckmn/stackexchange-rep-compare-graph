#!/usr/bin/ruby

require 'open-uri'

class RepCompareGraph
    def self.enclosed_range str, search_pattern, open_marker, close_marker
        if search_pattern.is_a? String
            search_pattern = Regexp.new(Regexp.escape search_pattern)
        end
        start_idx = str.match(search_pattern).begin 0
        idx = str.index(open_marker, start_idx) + 1
        nest_level = 1
        while nest_level > 0
            case str[idx]
            when open_marker
                nest_level += 1
            when close_marker
                nest_level -= 1
            end
            idx += 1
        end
        stop_idx = idx
        start_idx..stop_idx
    end
    private_class_method :enclosed_range

    def self.rep_compare_graph users, site
        site_regexp = /\{\s*name:\s*["']#{site}["'][^}]+\}/
        chart_page = nil

        datas = users.map {|user|
            user = [user] unless user.is_a? Array
            user_page = open("http://stackexchange.com/users/#{user[0]}?tab=reputation").read
            chart_page = user_page unless chart_page
            user_data = user_page.match site_regexp
            user_data[0].sub(site, user[1] || "User ##{user[0]}")
        }
        data = datas.join ','

        chart = chart_page[enclosed_range(chart_page, 'new Highcharts.Chart', '{', '}')]
        chart_data_range = enclosed_range(chart, /series:\s*\[\s*\{\s*name:/, '[', ']')
        chart[chart_data_range] = "series: [#{data}]"
        chart
    end
end
