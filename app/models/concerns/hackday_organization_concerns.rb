module HackdayOrganizationConcerns
  def has_user_id?(id)
    users_hackday_organizations.collect(&:user_id).include?(id)
  end

  def sync_users(users_hash)
    ids_to_keep = []
    HackdayOrganization.transaction do
      users_hash.each do |id, checked|
        if checked.to_i == 1
          ids_to_keep << id
          users_hackday_organizations.create(user_id: id) unless has_user_id?(id)
        end
      end
      UsersHackdayOrganization.where('hackday_organization_id = ? AND user_id NOT IN (?)', self.id, ids_to_keep).destroy_all
    end
  end
end
