module HackdayConcerns
  def start_date_formatted
    start_date.to_formatted_s(:db)
  end
end
