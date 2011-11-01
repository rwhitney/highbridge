
class Member < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :portable_name, :full_name, :portable_number, :street_address
  attr_accessible :city, :zip, :area, :home_phone, :work_phone, :cell_or_other_phone
  attr_accessible :shirt_size, :status, :misc_notes, :first_name, :last_name, :training_level
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
  
  validates_presence_of :full_name, :portable_name, :portable_number, :email, :status, :training_level
  validates_uniqueness_of :portable_name, :portable_number
  validates_format_of :email, :with => EmailAddress
  validates_inclusion_of :status, :in => ["Associate", "Active", "Probationary", "LOA"]
  validates_inclusion_of :training_level, :in => ["EMT", "Driver", "First Responder", "Non Call"]
  validates_inclusion_of :portable_number, :in => 1..999   # according to Drew (10/30/2011), we don't have a limit here 
                                                          # but it would be mystifying to be out of this range

  def Member.get_members_ordered_by_training(training)
    Member.find(:all, :conditions => ["training_level = ?", training], :order => 'last_name ASC, first_name ASC', :readonly => true)
  end
  
  def has_home_phone
    home_phone && home_phone.strip.length > 0
  end
  
  def has_work_phone
    work_phone && work_phone.strip.length > 0
  end
  
  def has_cell_phone
    cell_or_other_phone && cell_or_other_phone.strip.length > 0
  end
  
  def last_name_first
    last_name + ", " + first_name
  end
end
