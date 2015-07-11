module ApplicationHelper
	def self.nav_item user_id

		#TODO REFATORAR
		arr = Array.new
		nav_itemx = arr.push({id: "home", href: "/home", value: "Home"})
		nav_itemx = arr.push({id: "credentials", href: "/credentials", value: "Credentials"})	
		nav_itemx = arr.push({id: "notes", href: "/notes", value: "Notes"})
		nav_itemx = arr.push({id: "users", href: "/users", value: "Users"})
		nav_itemx = arr.push({id: "logout", href: "/sessions/logout", value: "Logout"})

		nav_itemx
	end

end
