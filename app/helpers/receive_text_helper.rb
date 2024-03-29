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
    Chronic.time_class = Time.zone

    tokens.each do |tok|
      tok.strip!
      if tok.gsub!(/date\S*/i, '')
        if date = Chronic.parse(tok, context: :past).to_date
          run_data[:date_text] = date.to_s
        else
          errors.push("date")
        end
      elsif tok.gsub!(/time\S*/i, '')
        if ChronicDuration.parse(tok)
          run_data[:time_text] = tok.strip
        else
          errors.push("time")
        end
      elsif tok.gsub!(/dist\S*/i, '')
        if dist = tok.delete("^0-9.")
          run_data[:distance] = dist
        else
          errors.push("distance")
        end
      elsif tok.gsub!(/pace\S*/i, '')
        if ChronicDuration.parse(tok)
          run_data[:pace_text] = tok.strip
        else
          errors.push("pace")
        end
      elsif tok.gsub!(/feel\S*/i, '')
        if feel = tok.match(/(good|ok|bad)/i)[0]
          run_data[:feel] = 1 if feel == "good"
          run_data[:feel] = 2 if feel == "ok"
          run_data[:feel] = 3 if feel == "bad"
        else
          errors.push("feel")
        end
      elsif tok.gsub!(/eff\S*/i, '')
        if effort = tok.match(/(easy|med|mod|hard)/i)[0]
          run_data[:effort] = 1 if effort == "easy"
          run_data[:effort] = 2 if effort == "med" || effort == "mod"
          run_data[:effort] = 3 if effort == "hard"
        else
          errors.push("effort")
        end
      elsif tok.gsub!(/note\S*/i, '')
        run_data[:notes] = tok.strip
      end
    end

    return Hash[:data, run_data, :errors, errors]
  end

  # def parse_text(f)
  #   s = Run.new
  #   if f[:date_text].present?
  #     s.date = Chronic.parse(f[:date_text])
  #   else
  #     s.date = Date.today
  #   end
  #   if f[:distance]
  #     s.distance = f[:distance].to_f
  #   end
  #   if f[:time_text]
  #     if !f[:time_text].include?('h') && !f[:time_text].include?('m')
  #       f[:time_text] += ':00' unless f[:time_text].match(/.+:.+:.+/)
  #     end
  #     s.time_in_secs = ChronicDuration.parse(f[:time_text])
  #   end
  #   if f[:pace_text]
  #     s.pace_in_secs = ChronicDuration.parse(f[:pace_text])
  #     if s.pace_in_secs < 220 #user meant minutes, not seconds
  #       s.pace_in_secs *= 60
  #     end
  #   end
  #   if f[:feel]
  #     s.feel = f[:feel]
  #   end
  #   if f[:effort]
  #     s.effort = f[:effort]
  #   end
  #   if f[:notes]
  #     s.notes = f[:notes]
  #   end
  #   return s
  # end
end