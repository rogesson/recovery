module ApplicationHelper
	def self.nav_item
		arr = Array.new
		nav_itemx = arr.push({href: "/home", value: "Home"})
		nav_itemx = arr.push({href: "/credentials", value: "Credential"})	
		nav_itemx = arr.push({href: "/sessions/logout", value: "Logout"})

		nav_itemx
	end
end
