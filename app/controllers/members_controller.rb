class MembersController < ApplicationController
  before_filter :authenticate_member!
  
  # GET /members
  # GET /members.json
  def index
    @members = Member.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @members }
    end
  end
  
  def compliance
    @members = Member.all
    
    @today = Date.today
    @this_month = Date.new(@today.year, @today.month, 1)
    @last_month = @this_month - 1.month
    @prev_month = @last_month - 1.month
    @this_month_name = @this_month.strftime("%b MTD")
    @last_month_name = @last_month.strftime("%b")
    @prev_month_name = @prev_month.strftime("%b")
    @prev_month_shifts = Shift.find_all_in_month(@prev_month)
    @last_month_shifts = Shift.find_all_in_month(@last_month)
    @this_month_shifts = Shift.find_all_in_month(@this_month)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @members }
    end
  end

  # GET /members/1
  # GET /members/1.json
  def show
    @member = Member.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @member }
    end
  end

  # GET /members/new
  # GET /members/new.json
  def new
    @member = Member.new
    
    @available_portable_numbers = Member.get_available_portable_numbers(1..60)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @member }
    end
  end

  # GET /members/1/edit
  def edit
    @member = Member.find(params[:id])
    @available_portable_numbers = Member.get_available_portable_numbers(1..60)
    @available_portable_numbers.push @member.portable_number
    @available_portable_numbers.sort!
  end

  # POST /members
  # POST /members.json
  def create
    @member = Member.new(params[:member])

    respond_to do |format|
      if @member.save
        format.html { redirect_to @member, notice: 'Member was successfully created.' }
        format.json { render json: @member, status: :created, location: @member }
      else
        # raise YAML::dump(@member)
        # raise @member.errors[0].to_s
        format.html { render action: "new" }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /members/1
  # PUT /members/1.json
  def update
    # this if statement allows devise to accept record when password is not filled in
    if params[:member][:password].blank?
      params[:member].delete(:password)
      params[:member].delete(:password_confirmation)
    end
    
    @member = Member.find(params[:id])

    respond_to do |format|
      if @member.update_attributes(params[:member])
        format.html { redirect_to @member, notice: 'Member was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    @member = Member.find(params[:id])
    @member.destroy

    respond_to do |format|
      format.html { redirect_to members_url }
      format.json { head :ok }
    end
  end
end
