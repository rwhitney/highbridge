class ShiftsController < ApplicationController
  before_filter :authenticate_member!
  
  # GET /shifts
  # GET /shifts.json
  def index
    @shifts = Shift.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @shifts }
    end
  end

  # GET /shifts/1
  # GET /shifts/1.json
  def show
    @shift = Shift.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @shift }
    end
  end

  # GET /shifts/new
  # GET /shifts/new.json
  def new
    if current_member.can_admin_admins?
      @shift = Shift.new

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @shift }
      end
    else
      render_forbidden
    end
  end

  # GET /shifts/1/edit
  def edit
    if current_member.can_admin_admins?
      @shift = Shift.find(params[:id])
    else
      render_forbidden
    end
  end

  # POST /shifts
  # POST /shifts.json
  def create
    if current_member.can_admin_admins?
      @shift = Shift.new(params[:shift])

      respond_to do |format|
        if @shift.save
          format.html { redirect_to @shift, notice: 'Shift was successfully created.' }
          format.json { render json: @shift, status: :created, location: @shift }
        else
          format.html { render action: "new" }
          format.json { render json: @shift.errors, status: :unprocessable_entity }
        end
      end
    else
      render_forbidden
    end
  end

  # PUT /shifts/1
  # PUT /shifts/1.json
  def update
    if current_member.can_admin_admins?
      @shift = Shift.find(params[:id])

      respond_to do |format|
        if @shift.update_attributes(params[:shift])
          format.html { redirect_to @shift, notice: 'Shift was successfully updated.' }
          format.json { head :ok }
        else
          format.html { render action: "edit" }
          format.json { render json: @shift.errors, status: :unprocessable_entity }
        end
      end
    else
      render_forbidden
    end
  end

  # DELETE /shifts/1
  # DELETE /shifts/1.json
  def destroy
    if current_member.can_admin_admins?
      @shift = Shift.find(params[:id])
      @shift.destroy

      respond_to do |format|
        format.html { redirect_to shifts_url }
        format.json { head :ok }
      end
    else
      render_forbidden
    end
  end
end
