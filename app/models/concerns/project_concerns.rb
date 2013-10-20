module ProjectConcerns
  def has_hardware_id?(id)
    hardwares.collect(&:id).include? id
  end

  def hackday_organization
    hackday && hackday.hackday_organization
  end
end
