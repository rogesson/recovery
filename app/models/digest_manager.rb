class DigestManager

	def self.enc(content, c_key)
		Gibberish::AES.new(c_key).encrypt(content)
	end

	def self.dec(content, c_key)
		Gibberish::AES.new(c_key).decrypt(content)
	end
end