module ReceiveTextHelper
  def parse_body(body)
    tokens = body.split(',')
    
    # tokens.each do |tok|
    #   if dur = ChronicDuration.parse(tok) && (tok.include?(':') || tok.include?('m'))
    #     if dur > 240 && dur < 840   #probably pace (4min - 14min)
    #       pace = dur
    #     elsif dur < 240 && tok.include? ':' #probably wrote 1:07, 
    #       && ChronicDuration.parse(tok.strip + ':00')   #but meant 1:07:00
    #     elsif dur < 18000 #less then 5 hours
    #       time = dur
    #     end
    #     next
    #   elsif 
    # end

    errors = Array.new
    run_data = Hash.new

    tokens.each do |tok|
      tok.strip!
      if tok.upcase.include?("DATE")
        if date = Chronic.parse(tok, context: :past)
          run_data[:date] = date
        else
          errors.push("date")
        end
      elsif tok.upcase.include?("TIME")
        if ChronicDuration.parse(tok)
          run_data[:time_text] = tok
        else
          errors.push("time")
        end
      elsif tok.upcase.include?("DIST")
        if dist = tok.delete("^0-9.")
          run_data[:distance] = dist
        else
          errors.push("distance")
        end
      elsif tok.upcase.include?("PACE")
        if ChronicDuration.parse(tok)
          run_data[:pace_text] = tok
        else
          errors.push("pace")
        end
      elsif tok.upcase.include?("FEEL")
        if feel = tok.match(/(good|okay|bad)/i)[0]
          run_data[:feel] = 1 if feel == "bad"
          run_data[:feel] = 2 if feel == "okay"
          run_data[:feel] = 3 if feel == "good"
        else
          errors.push("feel")
        end
      elsif tok.upcase.include?("NOTE")
        run_data[:comment] = tok.gsub(/(note)(s:|s|:| )/i, '').strip
      end
    end

    return Hash[:data, run_data, :errors, errors]
  end
end