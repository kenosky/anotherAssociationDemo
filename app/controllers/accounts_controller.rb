class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]

  # GET /customer/1/accounts
  def index
    @customer = Customer.find(params[:customer_id])
    # recall that each customer has either 0 or 1 account
    # a customer does not have more accounts and
    # that's why we write  bellow account and not accounts!!!
    # note that @account can be nil if no account has been created yet
    @account = @customer.account
  end

  # GET /accounts/1
  # GET /accounts/1.json
  
  # GET /customers/1/accounts/new
  def new
    @customer = Customer.find(params[:customer_id])
    @account = @customer.build_account()
  end
  
  # POST /customers/1/accounts
  def create
    @customer = Customer.find(params[:customer_id])
    @account = @customer.build_account(account_params)
    
    respond_to do |format|
      if @account.save
  format.html { redirect_to customer_account_url(@customer, @account),
                  notice:'Account was successfully created.'}
         format.json { render :show, status: :created,
               location: @account }
      else
        format.html { render :new }
        format.json { render json: @account.errors,
                  status: :unprocessable_entity }
      end
    end
  end
  
  def show
      @customer = Customer.find(params[:customer_id])
      @account = @customer.account
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to @account, notice: 'Account was successfully updated.' }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    @account.destroy
    respond_to do |format|
      format.html { redirect_to accounts_url, notice: 'Account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      params.require(:account).permit(:details, :customer_id)
    end
end
