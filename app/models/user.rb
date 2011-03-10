class User < ActiveRecord::Base
  has_many :sketches, :dependent => :destroy
  after_create :add_sketch_demo

  validates_presence_of :provider, :uid, :name, :email
  validates_uniqueness_of :uid, :email

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["user_info"]["name"]
      user.email = auth["user_info"]["email"]
    end
  end

  def add_sketch_demo
    # add a demo sketch
    content = '{"0":{"class":"window","text":"Sketch Lab!","style":"position: absolute; top: 8px; left: 8px; width: 560px; height: 290px; z-index: 0; "},"1":{"class":"label","text":"With Sketch Lab, you can spend less time sketching, and more time building.","style":"left: 48px; top: 48px; z-index: 1; "},"2":{"class":"label","text":"You can find the undo and redo buttons in the toolbar above.","style":"left: 98px; top: 88px; z-index: 2; "},"3":{"class":"label","text":"There is undo and redo support, so feel free to be experimental.","style":"left: 88px; top: 68px; z-index: 3; "},"4":{"class":"note","text":"To change the text and other properties of a widget, double-click it or right-click it and select Edit. You can also copy and paste widgets. To cut / copy a widget, just right click it and select Cut or Copy, respectively. To paste a widget, simply click the Paste button in the toolbar above. To rename the sketch, click the Rename button in the toolbar above. You can remove all the widgets from the drawing canvas by clicking the Clear Canvas button.","style":"position: absolute; width: 290px; height: 190px; left: 18px; top: 108px; z-index: 4; "},"5":{"class":"textarea","text":"To move a widget, just click it and drag it around the canvas.","style":"position: absolute; width: 224px; height: 39px; left: 328px; top: 108px; z-index: 5; "},"6":{"class":"textarea","text":"To resize a widget, drag the bottom right corner.","style":"z-index: 6; position: absolute; top: 158px; left: 328px; width: 224px; height: 89px; "}}'
    sketches.create!(:name => "Start Here", :content => content)
  end

  def plan
    # cache the plan
    @plan ||= accessLevel
  end

  private

  def accessLevel
    if kind.blank?
      # send a request to the Google Chrome Licensing API to check the user's status
      appId  = 'delppejinhhpcmimgfchjkbkpanhjkdj'
      userId = CGI::escape(uid)
      client = Signet::OAuth1::Client.new(
        :client_credential_key => 'anonymous',
        :client_credential_secret => 'anonymous',
        :token_credential_key => APP_CONFIG[:token_credential_key],
        :token_credential_secret => APP_CONFIG[:token_credential_secret]
      )
      response = client.fetch_protected_resource(
        :uri => "https://www.googleapis.com/chromewebstore/v1/licenses/#{appId}/#{userId}"
      )
      # get the accessLevel from the json response
      if JSON.parse(response[2][0])["accessLevel"] == "FULL"
        return 'paid'
      else
        return 'free'
      end
    else
      return kind
    end
  end

end
