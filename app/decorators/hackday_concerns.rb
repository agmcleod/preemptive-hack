module HackdayConcerns
  def has_hardware?(hardware)
    has_hardware_id?(hardware.id)
  end

  def has_hardware_id?(id)
    hardwares_hackdays.collect(&:hardware_id).include?(id)
  end

  def start_date_formatted
    start_date.to_formatted_s(:db)
  end

  def sync_hardware(ids_hash)
    ids_to_keep = []
    Hackday.transaction do
      ids_hash.each do |id, checked|
        id = id.to_i
        if checked.to_i == 1
          ids_to_keep << id
          hardwares_hackdays.build(hardware_id: id) unless has_hardware_id?(id)
        end
      end
      hardwares_hackdays.each do |hd|
        if !ids_to_keep.include?(hd.hardware_id)
          hardwares_hackdays.destroy(hd)
        end
      end
      save!
    end
  end
end
