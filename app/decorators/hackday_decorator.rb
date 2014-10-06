class HackdayDecorator

  def initialize(hackday)
    @hackday = hackday
  end

  def end_date_formatted
    @hackday.end_date.to_formatted_s(:db)
  end

  def has_hardware_id?(id)
    @hackday.hardwares_hackdays.map(&:hardware_id).include?(id)
  end

  def is_member?(user)
    @hackday.hackday_organization.is_member? user
  end

  def is_owner?(owner)
    return false if @hackday.hackday_organization.nil?
    @hackday.hackday_organization.is_owner? owner
  end

  def start_date_formatted
    @hackday.start_date.to_formatted_s(:db)
  end

  def sync_hardware(ids_hash)
    ids_to_keep = []
    Hackday.transaction do
      ids_hash.each do |id, checked|
        id = id.to_i
        if checked.to_i == 1
          ids_to_keep << id
          @hackday.hardwares_hackdays.build(hardware_id: id) unless @hackday.has_hardware_id?(id)
        end
      end
      @hackday.hardwares_hackdays.each do |hd|
        if !ids_to_keep.include?(hd.hardware_id)
          @hackday.hardwares_hackdays.destroy(hd)
        end
      end
      @hackday.save!
    end
  end
end
