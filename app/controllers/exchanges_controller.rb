class ExchangesController < ApplicationController
  load_and_authorize_resource

  # GET /exchanges/1
  # GET /exchanges/1.json
  def show
    @exchange = Exchange.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @exchange }
    end
  end

  def sign_up
    @exchange = Exchange.find(params[:id])
    current_user.exchanges << @exchange

    respond_to do |format|
      if current_user.save
        format.html { redirect_to dashboard_path, notice: "You have signed up for #{@exchange.name}." } 
      else
        format.html { redirect_to dashboard_path, notice: "We're sorry. There was a problem signing you up for #{@exchange.name}." }
        format.json { render json: current_user.errors, status: :unprocessable_entity }
      end
    end
  end

  def quit
    @exchange = Exchange.find(params[:id])
    current_user.exchanges.delete(@exchange)

    respond_to do |format|
      if current_user.save
        format.html { redirect_to dashboard_path, notice: "You have quit #{@exchange.name}. You can always sign up again later if you change your mind." }
      else
        format.html { redirect_to dashboard_path, notice: "We're sorry. There was a problem quitting #{@exchange.name}." }
        format.json { render json: current_user.errors, status: :unprocessable_entity }
      end
    end
  end

  def trigger_matchups
    @exchange = Exchange.find(params[:id])
    @exchange.match_and_notify

    respond_to do |format|
      format.html { redirect_to admin_path, notice: "You have triggered #{@exchange.name} matchups and notified users." }
      format.json { render json: @exchange }
    end
  end

  def close
    @exchange = Exchange.find(params[:id])
    @exchange.close

    respond_to do |format|
      format.html { redirect_to admin_path, notice: "You have closed #{@exchange.name} and notified users." }
      format.json { render json: @exchange }
    end
  end

  def post_gift
    @exchange = Exchange.find(params[:id])
    @post = current_user.posts.build(:exchange_id => @exchange.id)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /exchanges/new
  # GET /exchanges/new.json
  def new
    @exchange = Exchange.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @exchange }
    end
  end

  # GET /exchanges/1/edit
  def edit
    @exchange = Exchange.find(params[:id])
  end

  # POST /exchanges
  # POST /exchanges.json
  def create
    @exchange = Exchange.new(params[:exchange])

    respond_to do |format|
      if @exchange.save
        format.html { redirect_to @exchange, notice: 'Exchange was successfully created.' }
        format.json { render json: @exchange, status: :created, location: @exchange }
      else
        format.html { render action: "new" }
        format.json { render json: @exchange.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /exchanges/1
  # PUT /exchanges/1.json
  def update
    @exchange = Exchange.find(params[:id])

    respond_to do |format|
      if @exchange.update_attributes(params[:exchange])
        format.html { redirect_to @exchange, notice: 'Exchange was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @exchange.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /exchanges/1
  # DELETE /exchanges/1.json
  def destroy
    @exchange = Exchange.find(params[:id])
    @exchange.destroy

    respond_to do |format|
      format.html { redirect_to admin_url }
      format.json { head :no_content }
    end
  end
end
