
class Member < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :portablename, :fullname, :portablenumber, :streetaddress
  attr_accessible :city, :zip, :area, :homephone, :workphone, :cellorotherphone
  attr_accessible :shirtsize, :status, :miscnotes
  attr_accessor :monthly_total

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
  
  validates_presence_of :fullname, :portablename, :portablenumber, :email, :status
  validates_uniqueness_of :portablename, :portablenumber
  validates_format_of :email, :with => EmailAddress
  validates_inclusion_of :status, :in => ["Associate", "Active", "Probationary"]
  validates_inclusion_of :portablenumber, :in => 1..999   # according to Drew (10/30/2011), we don't have a limit here 
                                                          # but it would be mystifying to be out of this range

  def get_all_members
    #Member.find(:all, :conditions => ["shiftdate = ?", thedate.to_date], :order => 'shiftnum ASC', :readonly => true)
  end
end
