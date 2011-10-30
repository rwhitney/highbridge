
class Member < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  EmailAddress = begin
    qtext = /[^\x0d\x22\x5c\x80-\xff]/
    dtext = /[^\x0d\x5b-\x5d\x80-\xff]/
    atom = /[^\x00-\x20\x22\x28\x29\x2c\x2e\x3a-\x3c\x3e\x40\x5b-\x5d\x7f-\xff]+/
    quoted_pair = /\x5c[\x00-\x7f]/
    domain_literal = /\x5b(?:#{dtext}|#{quoted_pair})*\x5d/
    quoted_string = /\x22(?:#{qtext}|#{quoted_pair})*\x22/
    domain_ref = atom
    sub_domain = /(?:#{domain_ref}|#{domain_literal})/
    word = /(?:#{atom}|#{quoted_string})/
    domain = /#{sub_domain}(?:\x2e#{sub_domain})*/
    local_part = /#{word}(?:\x2e#{word})*/
    addr_spec = /#{local_part}\x40#{domain}/
    pattern = /\A#{addr_spec}\z/
  end

  has_many :e1shifts, :class_name => 'Shift', :foreign_key => "e1member_id"
  has_many :e2shifts, :class_name => 'Shift', :foreign_key => "e2member_id"
  has_many :drivershifts, :class_name => 'Shift', :foreign_key => "dmember_id"
  
  validates_presence_of :fullname, :portablename, :portablenumber, :email, :privilege, :status, :password, :salt
  validates_length_of :password, :within => 5..40
  validates_uniqueness_of :portablename
  validates_format_of :email, :with => EmailAddress
  validates_inclusion_of :privilege, :in => ["Normal", "Admin", "WebAdmin"]
  validates_inclusion_of :status, :in => ["Associate", "Active", "Probationary"]
  validates_inclusion_of :portablenumber, :in => 1..999   # according to Drew, we don't have a limit here 
                                                          # but it would be strange to be out of this range

  attr_accessor :monthly_total
  
  def Member.create!(attributes)
    if attributes[:salt].nil?
      m = Member.new(attributes)
      m.encode_password!
      m.save
      m
    else
      super
    end
  end
  
  def save
    encode_password! if salt.nil?
    super
  end
  
  def Member.validate_login(username, password)
    m = Member.find :first, :conditions => ["portablename = ?", username]  # this syntax protects against SQL injection

    if m
      pwdhash = Member.hash_data(password, m.salt)
      m = nil unless m.password == pwdhash
    end
    return m
  end
  
  def encode_password!
    create_salt!
    hash_password!
  end

  protected
    def Member.hash_data(data, salt = "")
      Digest::MD5.hexdigest("#{data}#{salt}")
    end

    def create_salt!
      self.salt = Member.hash_data("#{Time.now}#{self.portablename}")
    end

    def hash_password!
      self.password = Member.hash_data(self.password, self.salt)
    end
end
