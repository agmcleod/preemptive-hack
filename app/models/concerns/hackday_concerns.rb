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
    join_records = ids_hash.collect do |id, checked|
      if checked.to_i == 1
        ids_to_keep << id
        hardwares_hackdays.build(hardware_id: id) unless has_hardware_id?(id)
      end
    end.compact
    Hackday.transaction do
      join_records.each { |jr| jr.save }
      HardwaresHackdays.where('hackday_id = ? AND hardware_id NOT IN (?)', self.id, ids_to_keep).destroy_all
    end
  end
end
