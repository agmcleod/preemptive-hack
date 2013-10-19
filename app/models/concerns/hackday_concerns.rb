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
    ids_to_destroy = []
    ids_hash.each do |id, checked|
      if checked.to_i == 1 && !has_hardware_id?(id)
        hardwares_hackdays.build(hardware_id: id)
      elsif checked.to_i == 0 && has_hardware_id?(id)
        ids_to_destroy << id
      end
    end
    save && HardwaresHackdays.where(id: ids_to_destroy).destroy_all
  end
end
