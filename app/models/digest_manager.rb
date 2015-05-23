class DigestManager

	def self.enc(content, c_key)
		Gibberish::AES.new(c_key).enc(content)
	end

	def self.dec(content, c_key)
		Gibberish::AES.new(c_key).dec(content)
	end
end