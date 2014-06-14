module ApplicationHelper
	def self.navi_item
		arr = Array.new
		navi_item = arr.push({href: "/home", value: "Home"})
		navi_item = arr.push({href: "/credentials", value: "Credential"})	
		navi_item = arr.push({href: "/sessions/logout", value: "logout"})

		navi_item
	end
end
