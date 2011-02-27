class User < ActiveRecord::Base
  has_many :sketches, :dependent => :destroy
  has_many :ipns
  after_create :add_sketch_demo

  validates_presence_of :provider, :uid, :name
  validates_uniqueness_of :uid

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["user_info"]["name"]
      user.email = auth["user_info"]["email"]
      user.plan = "free"
    end
  end

  def add_sketch_demo
    # add a demo sketch
    content = '{"0":{"class":"window","text":"Sketch Lab!","style":"position: absolute; top: 8px; left: 8px; width: 560px; height: 290px; z-index: 0; "},"1":{"class":"label","text":"With Sketch Lab, you can spend less time sketching, and more time building.","style":"left: 48px; top: 48px; z-index: 1; "},"2":{"class":"label","text":"You can find the undo and redo buttons in the toolbar above.","style":"left: 98px; top: 88px; z-index: 2; "},"3":{"class":"label","text":"There is undo and redo support, so feel free to be experimental.","style":"left: 88px; top: 68px; z-index: 3; "},"4":{"class":"note","text":"To change the text of a widget, right-click it and select Edit. You can also copy and paste widgets. To cut / copy a widget, just right click it and select Cut or Copy, respectively. To paste a widget, simply click the Paste button in the toolbar above. To rename the sketch, click the Rename button in the toolbar above. You can remove all the widgets from the drawing canvas by clicking the Clear Canvas button.","style":"position: absolute; width: 290px; height: 190px; left: 18px; top: 108px; z-index: 4; "},"5":{"class":"textarea","text":"To move a widget, just click it and drag it around the canvas.","style":"position: absolute; width: 224px; height: 39px; left: 328px; top: 108px; z-index: 5; "},"6":{"class":"textarea","text":"To resize a widget, drag the bottom right corner.","style":"z-index: 6; position: absolute; top: 158px; left: 328px; width: 224px; height: 89px; "}}'
    sketches.create!(:name => "Start Here", :content => content)
  end

  def paypal_encrypted(notify_url)
    values = {
      :business => APP_CONFIG[:seller_email],
      :item_name => "Sketch Lab",
      :a1 => 0,
      :p1 => 30,
      :t1 => "D",
      :a3 => APP_CONFIG[:price],
      :p3 => 1,
      :t3 => "M",
      :no_note => 1,
      :custom => id,
      :notify_url => notify_url,
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
