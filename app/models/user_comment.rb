class UserComment < ApplicationRecord

	after_create :check_time_interval

	scope :active, -> {where(is_active: true)}

	def comment_date_time
		created_at.strftime("%Y-%m-%d %H:%M")
	end

	def check_time_interval
		comment = UserComment.order("created_at desc").find_by(is_active: true, visibility: 'visible')
		return self.visible! unless comment
		within_5_minutes = comment.within_5_minutes_records if comment
		if (comment.created_at+5.minutes) > Time.now.utc
			within_5_minutes.each.with_index(1) do |uc, index|
				uc.partially_visible! if index == within_5_minutes.count
				uc.not_visible! unless index == within_5_minutes.count
			end
		elsif (comment.created_at+5.minutes) < Time.now.utc
			within_5_minutes.each.with_index(1) do |uc, index|
				uc.visible! if index == within_5_minutes.count
				uc.not_visible! unless index == within_5_minutes.count
			end
			self.visible!
		end
	end

	def visible!
		update_attributes(is_active: true, visibility: 'visible')
	end

	def not_visible!
		update_attributes(is_active: true, visibility: 'not_visible')
	end

	def partially_visible!
		update_attributes(is_active: true, visibility: 'partially_visible')
	end

	def within_5_minutes_records
		UserComment.where("created_at < ? and created_at > ?", created_at, created_at + 5.minutes)
	end

end
