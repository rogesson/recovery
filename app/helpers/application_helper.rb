module ApplicationHelper
	def self.nav_item user_id
		user = User.find(user_id)
		unread_count = " (#{user.unread_message_count})" if user.unread_message_count > 0
		
		arr = Array.new
		nav_itemx = arr.push({href: "/home", value: "Home"})
		nav_itemx = arr.push({href: "/credentials", value: "Credentials"})	
		nav_itemx = arr.push({href: "/notes", value: "Notes"})
		nav_itemx = arr.push({href: "/users", value: "Users"})
		nav_itemx = arr.push({href: "/messages", value: "Messages#{unread_count}"})
		nav_itemx = arr.push({href: "/sessions/logout", value: "Logout"})

		nav_itemx
	end
end
