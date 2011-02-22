class User < ActiveRecord::Base
  has_many :sketches, :dependent => :destroy
  has_many :ipns

  validates_presence_of :provider, :uid, :name
  validates_uniqueness_of :uid

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["user_info"]["name"]
      user.email = nil
      user.plan = "free"
    end
  end

  def paypal_encrypted(notify_url)
    values = {
      :business => APP_CONFIG[:seller_email],
      :custom => id,
      :notify_url => notify_url,
      :hosted_button_id => APP_CONFIG[:upgrade_btn_id],
      :cert_id => APP_CONFIG[:paypal_cert_id],
      :secret => APP_CONFIG[:paypal_secret]
    }
    encrypt_for_paypal(values)
  end

  PAYPAL_CERT_PEM = File.read("#{Rails.root}/certs/paypal_cert.pem")
  APP_CERT_PEM = File.read("#{Rails.root}/certs/app_cert.pem")
  APP_KEY_PEM = File.read("#{Rails.root}/certs/app_key.pem")

  def encrypt_for_paypal(values)
    # encrypt the values using OpenSSL
    signed = OpenSSL::PKCS7::sign(OpenSSL::X509::Certificate.new(APP_CERT_PEM), OpenSSL::PKey::RSA.new(APP_KEY_PEM, ''), values.map { |k, v| "#{k}=#{v}" }.join("\n"), [], OpenSSL::PKCS7::BINARY)
    OpenSSL::PKCS7::encrypt([OpenSSL::X509::Certificate.new(PAYPAL_CERT_PEM)], signed.to_der, OpenSSL::Cipher::Cipher::new("DES3"), OpenSSL::PKCS7::BINARY).to_s.gsub("\n", "")
  end

end
