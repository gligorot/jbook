module ProfilesHelper

	#returns gravatar image tag, default size is 80
	def gravatar_for(user, size: 80)
		gravatar_id 	= Digest::MD5::hexdigest(user.email.downcase)
		gravatar_url 	= "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}" 
		image_tag(gravatar_url, alt: "gravatar picture", class: "gravatar")
	end

	def generate_links_for(user)	
		unless user.request_exists_with(current_user)
			link_to "Send friend request", friendship_index_path(user_id: user.id), method: :post
		end
	end
end
