class DigestManager

	def self.enc(content, c_key)
		cipher = Gibberish::AES.new(c_key)
    cipher.encrypt(content)
	end

	def self.dec(content, c_key)
    cipher = Gibberish::AES.new(c_key)
    cipher.decrypt(content)
	end
end