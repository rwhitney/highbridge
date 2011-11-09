
class Member < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  # removed :registerable so new users can only be added by administrators
  # removed :validatable so email is not forced to be unique
  devise :database_authenticatable, :recoverable, :rememberable, :trackable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :portable_name, :full_name, :portable_number, :street_address
  attr_accessible :city, :zip, :area, :home_phone, :work_phone, :cell_or_other_phone
  attr_accessible :shirt_size, :status, :misc_notes, :first_name, :last_name, :training_level
  attr_accessor :last_total, :prev_total, :monthly_total

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

  has_many :e1shifts,     :class_name => 'Shift', :foreign_key => "e1member_id"
  has_many :e2shifts,     :class_name => 'Shift', :foreign_key => "e2member_id"
  has_many :drivershifts, :class_name => 'Shift', :foreign_key => "dmember_id"

  # these three normally come from devise but I removed :validatable so I have to take over validations
  validates_presence_of     :password, :if => :password_required?
  validates_confirmation_of :password, :if => :password_required?
  validates_length_of       :password, :within => 6..128, :allow_blank => true

  validates_presence_of   :full_name, :portable_name, :portable_number, :email, :status, :training_level
  validates_uniqueness_of :portable_name, :portable_number
  validates_format_of     :email, :with => EmailAddress
  validates_inclusion_of  :status, :in => ["Associate", "Active", "Probationary", "LOA", "Not Active", "Past Member"]
  validates_inclusion_of  :training_level, :in => ["EMT", "Driver", "First Responder", "Non Call"]
  validates_inclusion_of  :portable_number, :in => 1..999   # according to Drew (10/30/2011), we don't have a limit here 
                                                          # but it would be mystifying to be out of this range
  # this is the implementation from devise
  # once I turned off validations, it no longer appears to provide this implementation
  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end
  
  def Member.get_all_but_past
    Member.find(:all, :conditions => ['status != "Past Member"'], :order => 'portable_name ASC', :readonly => true)
  end

  def Member.get_all_portable_names
    Member.find(:all, :select => 'portable_number, portable_name', :conditions => ['status != "Past Member"'], :order => 'portable_name ASC', :readonly => true)
  end
  
  def Member.get_with_portable_number(portable_number)
    if portable_number.nil? || portable_number.to_s.length == 0
      nil
    else
      Member.find(:first, :conditions => ["portable_number = ?", portable_number])
    end
  end
  
  def Member.get_available_portable_numbers(in_range)
    members = Member.find(:all, :select => 'portable_number', :order => 'portable_number ASC', :readonly => true)
    available_numbers = []
    in_range.each do |num|
      available_numbers.push(num)
    end
    members.each do |member|
      available_numbers.delete(member.portable_number)
    end
    available_numbers
  end
  
  # used during an import.  It takes a portable name and either finds the member or creates one 
  # with some made-up data (in order to pass validation)
  def Member.get_or_create_member(portable_name)
    member = Member.get_with_portable_name(portable_name)
    if member.nil?
      if portable_name =~ /([a-zA-Z]+)(\d{1,3})/
        base_name = $1
        portable_number = $2.to_i
        
        member = Member.new
        member.full_name = "#{base_name} Jones"
        member.first_name = base_name
        member.last_name = "Jones"
        member.portable_name = portable_name
        member.portable_number = portable_number
        member.email = "#{base_name}@somewhere.net"
        member.training_level = "Non Call"
        member.status = "LOA"
        member.password = "password"
        member.save
      end
    end
    member
  end
  
  def Member.get_with_portable_name(portable_name)
    if portable_name.nil? || portable_name.length == 0
      nil
    else
      Member.find(:first, :conditions => ["portable_name = ?", portable_name])
    end
  end
  
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
